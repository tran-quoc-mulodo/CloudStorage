//
//  CSRootDropboxTableViewController.m
//  CloudStorage
//
//  Created by Anh Quoc on 7/24/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import "CSRootDropboxTableViewController.h"


@interface CSRootDropboxTableViewController ()

@end

@implementation CSRootDropboxTableViewController

#pragma mark -
#pragma mark LifeCircle methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        _restClient.delegate = self;
        _path = @"/";
        _isRoot = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Dropbox"];
    if (_isRoot) {
        [self.navigationItem setHidesBackButton:YES];
    } else {
        [self.navigationItem setTitle:@"Title"];
        [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    }
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn-bar-button.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(actionBarButtonItem:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    // Do any additional setup after loading the view from its nib.
    
    // check internet then load from local or load from server directly
    [self loadTreesFolderOfDropboxWithPath];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _restClient = nil;
    _metaDataContent = nil;
    _path = nil;
}

#pragma mark -
#pragma mark delege restClients reponse methods

// load metadata
- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    if (metadata.isDirectory) {
        _metaDataContent = metadata.contents;
        [self configTitleOfView];
        for (DBMetadata *file in metadata.contents) {
            if (file.isDirectory) {
                _numberFolder++;
            } else {
                _numberFile++;
            }
            if (file.thumbnailExists) {
                NSString *destinationPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"thumbnail_%@", file.filename]];
                [_restClient loadThumbnail:file.path ofSize:@"32x32" intoPath:destinationPath];
            }
        }
        [self.tableView reloadData];
    }
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error {
    DEBUG_LOG(@"Error loading metadata: %@", error);
    // config view when load root folder error
    
}

// load thumbnail
- (void)restClient:(DBRestClient*)client loadedThumbnail:(NSString*)destPath metadata:(DBMetadata*)metadata {
    // insert image at this desPath into coredata then remove in Directory
    
    [self.tableView reloadData];
}

- (void)restClient:(DBRestClient*)client loadThumbnailFailedWithError:(NSError*)error {
    
}


#pragma mark -
#pragma mark files and folders methods

- (void)actionBarButtonItem:(id)sender {
    
    
}

- (void)configTitleOfView {
    if (!_isRoot) {
        int value = 0;
        for (int i = _path.length - 1; i >= 0; i--) {
            char charactor = [_path characterAtIndex:i];
            if (charactor == '/') {
                value = i + 1;
                break;
            }
        }
        [self.navigationItem setTitle:[_path substringFromIndex:value]];
    }
}

- (void)loadTreesFolderOfDropboxWithPath {
    [_restClient loadMetadata:_path];
}

#pragma mark -
#pragma mark tableView delegate and data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if(_metaDataContent) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if ([_metaDataContent count] > 12) {
        return [_metaDataContent count] + 2;
    }
    return [_metaDataContent count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *CellIdentifier = @"CellSearch";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        if (_isRoot) {
            [searchBar setPlaceholder:@"Search"];
        } else {
            [searchBar setPlaceholder:@"Search this Folder"];
        }
        [searchBar setBarTintColor:kCSSearchBarBackgroundColor];
        
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTintColor:kCSNavigationBackgroundColor];
        
        [cell.contentView addSubview:searchBar];
        return cell;
    }
    
    if (indexPath.row >= [_metaDataContent count] + 1) {
        static NSString *CellIdentifier = @"CellCount";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        if (_numberFolder == 0) {
            [cell.textLabel setText:[NSString stringWithFormat:@"%d Files", [_metaDataContent count]]];
        } else if (_numberFile == 0) {
            [cell.textLabel setText:[NSString stringWithFormat:@"%d Folders", [_metaDataContent count]]];
        } else {
            [cell.textLabel setText:[NSString stringWithFormat:@"%d Files, %d Folders", _numberFile, _numberFolder]];
        }
        [cell.textLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [cell.textLabel setTextColor:[UIColor darkGrayColor]];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        return cell;
    }
    
    static NSString *CellIdentifier = @"DropboxCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    DBMetadata *file = [_metaDataContent objectAtIndex:indexPath.row - 1];
    if (file.thumbnailExists) {
        // get thumbnail
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
        [cell.detailTextLabel setText:file.humanReadableSize];
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:11.0f]];
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
    if (indexPath.row >= [_metaDataContent count] + 1 || indexPath.row == 0) {
        return;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DBMetadata *file = [_metaDataContent objectAtIndex:indexPath.row - 1];
    if (file.isDirectory) {
        // push to child folder
        CSRootDropboxTableViewController *viewController = [[CSRootDropboxTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [viewController setPath:[NSString stringWithFormat:@"%@", file.path]];
        [viewController setIsRoot:NO];
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        // review file
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 40.0f;
    } else {
        return 44.0f;
    }
}


@end
