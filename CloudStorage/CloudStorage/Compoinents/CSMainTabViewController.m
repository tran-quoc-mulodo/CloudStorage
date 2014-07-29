//
//  CSMainTabViewController.m
//  CloudStorage
//
//  Created by Anh Quoc on 7/14/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import "CSMainTabViewController.h"
#import "CSMainNavigationController.h"

@interface CSMainTabViewController ()

@end

@implementation CSMainTabViewController

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
    // iOS 7 or newer
    [[UINavigationBar appearance] setBarTintColor:kCSNavigationBackgroundColor];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,
                                                          nil]];
    
    _controller1 = [[CSFirstViewController alloc] initWithNibName:@"CSFirstViewController" bundle:nil];
    [_controller1 setTitle:@"Dropbox"];
    _controller2 = [[CSSecondViewController alloc] initWithNibName:@"CSSecondViewController" bundle:nil];
    [_controller2 setTitle:@"Box"];
    _controller3 = [[CSThirdViewController alloc] initWithNibName:@"CSThirdViewController" bundle:nil];
    [_controller3 setTitle:@"Google Drive"];
    _controller4 = [[CSFourViewController alloc] initWithNibName:@"CSFourViewController" bundle:nil];
    [_controller4 setTitle:@"Sky Drive"];
    _controller5 = [[CSFiveViewController alloc] initWithNibName:@"CSFiveViewController" bundle:nil];
    [_controller5 setTitle:@"Settings"];
    
    CSMainNavigationController *navigation1 = [[CSMainNavigationController alloc] initWithRootViewController:_controller1];
    
    CSMainNavigationController *navigation2 = [[CSMainNavigationController alloc] initWithRootViewController:_controller2];
    
    CSMainNavigationController *navigation3 = [[CSMainNavigationController alloc] initWithRootViewController:_controller3];
    
    CSMainNavigationController *navigation4 = [[CSMainNavigationController alloc] initWithRootViewController:_controller4];
    
    CSMainNavigationController *navigation5 = [[CSMainNavigationController alloc] initWithRootViewController:_controller5];
    
    
    self.viewControllers = [NSArray arrayWithObjects:navigation1, navigation2, navigation3, navigation4, navigation5, nil];
    
    [[[self.viewControllers objectAtIndex:0] tabBarItem] setImage:[UIImage imageNamed:@"tabbar-dropbox-selected.png"]];
    
    [[[self.viewControllers objectAtIndex:1] tabBarItem] setImage:[UIImage imageNamed:@"tabbar-box-selected.png.png"]];
    
    [[[self.viewControllers objectAtIndex:2] tabBarItem] setImage:[UIImage imageNamed:@"tabbar-googledrive-selected.png"]];
    
    [[[self.viewControllers objectAtIndex:3] tabBarItem] setImage:[UIImage imageNamed:@"tabbar-sky-selected.png"]];
    
    [[[self.viewControllers objectAtIndex:4] tabBarItem] setImage:[UIImage imageNamed:@"tabbar-settings-selected.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _controller1 = nil;
    _controller2 = nil;
    _controller3 = nil;
    _controller4 = nil;
    _controller5 = nil;
}

@end
