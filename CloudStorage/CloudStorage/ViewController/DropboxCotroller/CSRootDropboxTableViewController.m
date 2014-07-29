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
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationItem setTitle:@"Dropbox"];
    // Do any additional setup after loading the view from its nib.
    [self loadRootFolderOfDropbox];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _restClient = nil;
    _metaDataContent = nil;
}

#pragma mark -
#pragma mark delege apis reponse methods

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    if (metadata.isDirectory) {
        _metaDataContent = metadata.contents;
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

- (void)loadRootFolderOfDropbox {
    [_restClient loadMetadata:@"/"];
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
    [cell.textLabel setText:object.filename];
    
    return cell;
}


@end
