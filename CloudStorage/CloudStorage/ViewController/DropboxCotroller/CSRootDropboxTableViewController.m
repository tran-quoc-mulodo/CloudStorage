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

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    if (metadata.isDirectory) {
        _metaDataContent = metadata.contents;
        [self configTitleOfView];
        [self.tableView reloadData];
    }
    
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error {
    DEBUG_LOG(@"Error loading metadata: %@", error);
    // config view when load root folder error
    
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
    return [_metaDataContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DropboxCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    DBMetadata *object = [_metaDataContent objectAtIndex:indexPath.row];
    if (object.isDirectory) {
        if ([object.filename isEqualToString:@"Public"] && _isRoot) {
            [cell.imageView setImage:[UIImage imageNamed:@"icon-folder-public.png"]];
        } else {
            [cell.imageView setImage:[UIImage imageNamed:@"icon-folder.png"]];
        }
    } else if ([object.icon isEqualToString:@"page_white_picture"]) {
        
    } else {
        DEBUG_LOG(@"%@", object.icon);
        [cell.imageView setImage:nil];
    }
    
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [cell.textLabel setText:object.filename];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DBMetadata *object = [_metaDataContent objectAtIndex:indexPath.row];
    if (object.isDirectory) {
        // push to child folder
        CSRootDropboxTableViewController *viewController = [[CSRootDropboxTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [viewController setPath:[NSString stringWithFormat:@"%@", object.path]];
        [viewController setIsRoot:NO];
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        // review file
        
    }
}


@end
