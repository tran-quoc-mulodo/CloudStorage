//
//  BIDMainViewController.m
//  TestApp
//
//  Created by Anh Quoc on 7/7/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

#import "BIDMainViewController.h"
#import "BIDFirstViewController.h"
#import "BIDSecondViewController.h"
#import "BIDMainNavigationController.h"
#import "BIDThirdViewController.h"
#import "BIDFourViewController.h"
#import "BIDFiveViewController.h"

@interface BIDMainViewController ()

@end

@implementation BIDMainViewController

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
    
    // setup tabbar viewcontroller
    BIDFirstViewController *controller1 = [[BIDFirstViewController alloc] initWithNibName:@"BIDFirstViewController" bundle:nil];
    [controller1 setTitle:@"Dropbox"];
    BIDSecondViewController *controller2 = [[BIDSecondViewController alloc] initWithNibName:@"BIDSecondViewController" bundle:nil];
    [controller2 setTitle:@"Google Drive"];
    BIDThirdViewController *controller3 = [[BIDThirdViewController alloc] initWithNibName:@"BIDThirdViewController" bundle:nil];
    [controller3 setTitle:@"Sky Drive"];
    BIDFourViewController *controller4 = [[BIDFourViewController alloc] initWithNibName:@"BIDFourViewController" bundle:nil];
    [controller4 setTitle:@"Sugar Sync"];
    BIDFiveViewController *controller5 = [[BIDFiveViewController alloc] initWithNibName:@"BIDFiveViewController" bundle:nil];
    [controller5 setTitle:@"Settings"];
    
    BIDMainNavigationController *navigation1 = [[BIDMainNavigationController alloc] initWithRootViewController:controller1];
    
    BIDMainNavigationController *navigation2 = [[BIDMainNavigationController alloc] initWithRootViewController:controller2];
    
    BIDMainNavigationController *navigation3 = [[BIDMainNavigationController alloc] initWithRootViewController:controller3];
    
    BIDMainNavigationController *navigation4 = [[BIDMainNavigationController alloc] initWithRootViewController:controller4];
    
    BIDMainNavigationController *navigation5 = [[BIDMainNavigationController alloc] initWithRootViewController:controller5];
    
    
    self.viewControllers = [NSArray arrayWithObjects:navigation1, navigation2, navigation3, navigation4, navigation5, nil];
    
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
