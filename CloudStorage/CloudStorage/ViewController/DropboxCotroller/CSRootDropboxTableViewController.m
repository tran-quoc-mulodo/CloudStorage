//
//  CSRootDropboxTableViewController.m
//  CloudStorage
//
//  Created by Anh Quoc on 7/24/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import "CSRootDropboxTableViewController.h"
#import "CSAppDelegate.h"


@interface CSRootDropboxTableViewController ()

@end

@implementation CSRootDropboxTableViewController

#pragma mark -
#pragma mark LifeCircle methods


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        _restClient.delegate = self;
        _path = @"/";
        _isRoot = YES;
        _isNeedSearch = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:kCSTitleTab1];
    _humanizedType = NSDateHumanizedSuffixAgo;
    if (_isRoot) {
        [self.navigationItem setHidesBackButton:YES];
    } else {
        [self.navigationItem setTitle:@"Title"];
        [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    }
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn-bar-button.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(actionBarButtonItem:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    if (_isRoot) {
        [_searchBar setPlaceholder:kCSDroboxPlaceHolderSearch];
    } else {
        [_searchBar setPlaceholder:kCSDroboxPlaceHolderSearchFolder];
    }
    
    // check internet then load from local or load from server directly
    [self loadDataFromtCoreData];
    [self loadTreesFolderOfDropboxWithPath];
    
    // add observer
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(unlinkObserverMethod:)
                                                 name:kCSNotificationDropboxUnlink
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _flagStopLoad = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _flagStopLoad = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    // cancel request before dealloc
    if (_isSearchMode) {
        for (DBMetadata *file in _metaDataContentSearch) {
            if (file.thumbnailExists) {
                [_restClient cancelThumbnailLoad:file.path size:kCSDroboxThumbnailSize];
            }
        }
    } else {
        for (DBMetadata *file in _metaDataContent) {
            if (file.thumbnailExists) {
                [_restClient cancelThumbnailLoad:file.path size:kCSDroboxThumbnailSize];
            }
        }
    }
    [_restClient cancelAllRequests];
    
    [_searchBar removeFromSuperview];
    _restClient = nil;
    _metaDataContent = nil;
    _path = nil;
    _searchBar = nil;
    searchDisplayController = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCSNotificationDropboxUnlink object:nil];
}

#pragma mark -
#pragma mark delege restClients reponse methods

- (void)unlinkObserverMethod:(NSNotification*)notification {
    // delete all data then pop to root viewcontroller
    [self.navigationController popToRootViewControllerAnimated:NO];
}

// load metadata
- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    if (metadata.isDirectory) {
        _metaDataContent = metadata.contents;
        [self reloadTableViewWhenDataLoaded];
        [self saveDataIntoCoreData:metadata];
    }
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error {
    // config view when load root folder error
    
}

// load thumbnail
- (void)restClient:(DBRestClient*)client loadedThumbnail:(NSString*)destPath {
    // insert image at this desPath into coredata then remove in Directory
    [self.tableView reloadData];
}

- (void)restClient:(DBRestClient*)client loadThumbnailFailedWithError:(NSError*)error {
    
}

// search
- (void)restClient:(DBRestClient*)restClient loadedSearchResults:(NSArray*)results
           forPath:(NSString*)path keyword:(NSString*)keyword {
    _metaDataContentSearch = results;
    for (DBMetadata *file in results) {
        if (file.isDirectory) {
            _numberFolderSearch++;
        } else {
            _numberFileSearch++;
        }
        if (file.thumbnailExists) {
            NSString *destinationPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"thumbnail_%@", file.filename]];
            [_restClient loadThumbnail:file.path ofSize:kCSDroboxThumbnailSize intoPath:destinationPath];
        }
    }
    
    [searchDisplayController.searchResultsTableView reloadData];
    // add footer couter item
    [self updateFooterOfTableView];
}
// results is a list of DBMetadata * objects
- (void)restClient:(DBRestClient*)restClient searchFailedWithError:(NSError*)error {
    
}


#pragma mark -
#pragma mark files and folders methods

- (void)loadDataFromtCoreData {
    NSManagedObjectContext *context = [kCSAppDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:kCSEntityDropbox
                inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(path = %@)", _path];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    if ([objects count] != 0) {
        matches = objects[0];
        _metaDataContent = [matches valueForKey:kCSDropboxMetaData];
        [self reloadTableViewWhenDataLoaded];
    }
}

- (void)saveDataIntoCoreData:(DBMetadata *)metadata {
    NSManagedObjectContext *context = [kCSAppDelegate managedObjectContext];
    NSManagedObject *metaData = [NSEntityDescription insertNewObjectForEntityForName:kCSEntityDropbox inManagedObjectContext:context];
    [metaData setValue:metadata.path forKey:kCSDropboxPath];
    [metaData setValue:metadata.contents forKey:kCSDropboxMetaData];
    NSError *error;
    [context save:&error];
}

- (void)actionBarButtonItem:(id)sender {
    
    
}

- (void)reloadTableViewWhenDataLoaded {
    [self.tableView reloadData];
    [self configTitleOfView];
    for (DBMetadata *file in _metaDataContent) {
        if (file.isDirectory) {
            _numberFolder++;
        } else {
            _numberFile++;
        }
        
        if (file.thumbnailExists && !_flagStopLoad) {
            NSString *destinationPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"thumbnail_%@", file.filename]];
            [_restClient loadThumbnail:file.path ofSize:@"32x32" intoPath:destinationPath];
        }
    }
    
    // add footer couter item
    [self updateFooterOfTableView];
    [self.tableView reloadData];
}

- (NSString *)returnNameMainPath {
    NSInteger value = 0;
    for (NSInteger i = _path.length - 1; i >= 0; i--) {
        char charactor = [_path characterAtIndex:i];
        if (charactor == '/') {
            value = i + 1;
            break;
        }
    }
    
    return [_path substringFromIndex:value];
}

- (void)updateFooterOfTableView {
    if (_isSearchMode) {
        if ([_metaDataContentSearch count] > 12) {
            UILabel *laberCouter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
            if (_numberFolderSearch == 0) {
                [laberCouter setText:[NSString stringWithFormat:@"%lu Files", (unsigned long)[_metaDataContentSearch count]]];
            } else if (_numberFileSearch == 0) {
                [laberCouter setText:[NSString stringWithFormat:@"%lu Folders", (unsigned long)[_metaDataContentSearch count]]];
            } else {
                [laberCouter setText:[NSString stringWithFormat:@"%ld Files, %ld Folders", (long)_numberFileSearch, (long)_numberFolderSearch]];
            }
            [laberCouter setFont:[UIFont systemFontOfSize:15.0f]];
            [laberCouter setTextColor:[UIColor darkGrayColor]];
            [laberCouter setTextAlignment:NSTextAlignmentCenter];
            searchDisplayController.searchResultsTableView.tableFooterView = laberCouter;
        } else {
            searchDisplayController.searchResultsTableView.tableFooterView = nil;
        }
    } else {
        if ([_metaDataContent count] > 12) {
            UILabel *laberCouter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
            if (_numberFolder == 0) {
                [laberCouter setText:[NSString stringWithFormat:@"%lu Files", (unsigned long)[_metaDataContent count]]];
            } else if (_numberFile == 0) {
                [laberCouter setText:[NSString stringWithFormat:@"%lu Folders", (unsigned long)[_metaDataContent count]]];
            } else {
                [laberCouter setText:[NSString stringWithFormat:@"%ld Files, %ld Folders", (long)_numberFile, (long)_numberFolder]];
            }
            [laberCouter setFont:[UIFont systemFontOfSize:15.0f]];
            [laberCouter setTextColor:[UIColor darkGrayColor]];
            [laberCouter setTextAlignment:NSTextAlignmentCenter];
            self.tableView.tableFooterView = laberCouter;
        } else {
            self.tableView.tableFooterView = nil;
        }
    }
}

- (void)configTitleOfView {
    if (!_isRoot) {
        [self.navigationItem setTitle:[self returnNameMainPath]];
    }
}

- (void)loadTreesFolderOfDropboxWithPath {
    [_restClient loadMetadata:_path];
}

- (void)loadSearchByPath:(NSString *)path andSearchString:(NSString *)searchString {
    [_restClient searchPath:path forKeyword:searchString];
}

#pragma mark -
#pragma mark tableView delegate and data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (_isSearchMode) {
        return [_metaDataContentSearch count];
    } else {
        return [_metaDataContent count];
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DropboxCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    DBMetadata *file = nil;
    if (_isSearchMode) {
        file = [_metaDataContentSearch objectAtIndex:indexPath.row];
    } else {
        file = [_metaDataContent objectAtIndex:indexPath.row];
    }
    
    if (file.thumbnailExists) {
        [cell.imageView setImage:[UIImage imageNamed:@"page_white_picture.png"]];
        NSString *destinationPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"thumbnail_%@", file.filename]];
        UIImage *image_icon = [UIImage imageWithContentsOfFile:destinationPath];
        if (image_icon) {
            [cell.imageView setImage:image_icon];
        }
    } else {
        [cell.imageView setImage:[UIImage imageNamed:file.icon]];
    }
    
    if (!file.isDirectory) {
        [cell.detailTextLabel setTextColor:[UIColor darkGrayColor]];
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:11.0f]];
        NSString *stringOfDate = [file.lastModifiedDate stringWithHumanizedTimeDifference:_humanizedType withFullString:YES];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@ modified %@", file.humanReadableSize, stringOfDate]];
    } else {
        [cell.detailTextLabel setText:nil];
    }
    
    [cell.textLabel setLineBreakMode:NSLineBreakByTruncatingMiddle];
    [cell.textLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [cell.textLabel setText:file.filename];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DBMetadata *file = nil;
    if (_isSearchMode) {
        file = [_metaDataContentSearch objectAtIndex:indexPath.row];
    } else {
        file = [_metaDataContent objectAtIndex:indexPath.row];
    }
    
    if (file.isDirectory) {
        // push to child folder
        CSRootDropboxTableViewController *viewController = [[CSRootDropboxTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [viewController setIsRoot:NO];
        [viewController setPath:[NSString stringWithFormat:@"%@", file.path]];
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        // review file if avalable
        
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    if (searchString.length == 0) {
        [controller.searchResultsTableView reloadData];
        _metaDataContentSearch = nil;
        _numberFileSearch = 0;
        _numberFolderSearch = 0;
        searchDisplayController.searchResultsTableView.tableFooterView = nil;
        _isSearchMode = NO;
        [self.tableView reloadData];
    } else {
        _isSearchMode = YES;
        [self loadSearchByPath:_path andSearchString:searchString];
    }
    return YES;
}

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    _numberFileSearch = 0;
    _numberFolderSearch = 0;
    _isSearchMode = YES;
}

- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    _metaDataContentSearch = nil;
    [self updateFooterOfTableView];
    _isSearchMode = NO;
    [self.tableView reloadData];
}


@end
