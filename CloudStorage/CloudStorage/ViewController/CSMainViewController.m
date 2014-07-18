//
//  CSMainViewController.m
//  CloudStorage
//
//  Created by Anh Quoc on 7/14/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import "CSMainViewController.h"

@interface CSMainViewController ()

@end

@implementation CSMainViewController

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
    [self createGUI];
}

- (void)createGUI {
    [[[self.viewControllers objectAtIndex:0] tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"tabbar-dropbox-selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar-dropbox-default.png"]];
    
    [[[self.viewControllers objectAtIndex:2] tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"tabbar-googledrive-selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar-googledrive-default.png"]];
    
    [[[self.viewControllers objectAtIndex:3] tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"tabbar-sky-selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar-sky-default.png"]];
    
    [[[self.viewControllers objectAtIndex:4] tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"tabbar-settings-selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar-settings-default.png"]];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
