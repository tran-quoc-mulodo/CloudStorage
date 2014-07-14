//
//  CSMainViewController.m
//  CloudStorage
//
//  Created by Anh Quoc on 7/14/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import "CSMainViewController.h"
#import "CSFirstViewController.h"
#import "CSSecondViewController.h"
#import "CSMainNavigationController.h"
#import "CSThirdViewController.h"
#import "CSFourViewController.h"
#import "CSFiveViewController.h"

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
    CSFirstViewController *controller1 = [[CSFirstViewController alloc] initWithNibName:@"CSFirstViewController" bundle:nil];
    [controller1 setTitle:@"Dropbox"];
    CSSecondViewController *controller2 = [[CSSecondViewController alloc] initWithNibName:@"CSSecondViewController" bundle:nil];
    [controller2 setTitle:@"Google Drive"];
    CSThirdViewController *controller3 = [[CSThirdViewController alloc] initWithNibName:@"CSThirdViewController" bundle:nil];
    [controller3 setTitle:@"Sky Drive"];
    CSFourViewController *controller4 = [[CSFourViewController alloc] initWithNibName:@"CSFourViewController" bundle:nil];
    [controller4 setTitle:@"Sugar Sync"];
    CSFiveViewController *controller5 = [[CSFiveViewController alloc] initWithNibName:@"CSFiveViewController" bundle:nil];
    [controller5 setTitle:@"Settings"];
    
    CSMainNavigationController *navigation1 = [[CSMainNavigationController alloc] initWithRootViewController:controller1];
    
    CSMainNavigationController *navigation2 = [[CSMainNavigationController alloc] initWithRootViewController:controller2];
    
    CSMainNavigationController *navigation3 = [[CSMainNavigationController alloc] initWithRootViewController:controller3];
    
    CSMainNavigationController *navigation4 = [[CSMainNavigationController alloc] initWithRootViewController:controller4];
    
    CSMainNavigationController *navigation5 = [[CSMainNavigationController alloc] initWithRootViewController:controller5];
    
    
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
