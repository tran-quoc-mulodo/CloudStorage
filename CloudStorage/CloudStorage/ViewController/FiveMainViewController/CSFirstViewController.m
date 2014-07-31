//
//  CSFirstViewController.m
//  CloudStorage
//
//  Created by Anh Quoc on 7/14/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import "CSFirstViewController.h"
#import <DropboxSDK/DropboxSDK.h>
#import "CSRootDropboxTableViewController.h"


@interface CSFirstViewController ()

@end

@implementation CSFirstViewController

#pragma mark -
#pragma mark LifeCircle methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.rootViewDropbox = nil;
}

#pragma mark -
#pragma mark Action view methods

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)configView {
    if([[DBSession sharedSession] isLinked]) {
        if (!_rootViewDropbox) {
            _rootViewDropbox = [[CSRootDropboxTableViewController alloc] initWithStyle:UITableViewStylePlain];
        }
        
        [self.navigationController pushViewController:_rootViewDropbox animated:NO];
    } else {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

- (void)actionWhenDidLinkToDrobox {
    _rootViewDropbox = [[CSRootDropboxTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:_rootViewDropbox animated:NO];
}

- (IBAction)btnLink:(id)sender {
    if (![[DBSession sharedSession] isLinked]) {
		[[DBSession sharedSession] linkFromController:self];
    } else {
        [[DBSession sharedSession] unlinkAll];
    }
}

@end
