//
//  BIDMainNavigationController.m
//  TestApp
//
//  Created by Anh Quoc on 7/8/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

#import "BIDMainNavigationController.h"

@interface BIDMainNavigationController ()

@end

@implementation BIDMainNavigationController

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
	// Do any additional setup after loading the view.
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
        // iOS 7 or newer
        [self.navigationBar setBarTintColor:kBIDNavigationBackgroundColor];
    } else {
        // iOS 6 or older
        [[UINavigationBar appearance] setTintColor:kBIDNavigationBackgroundColor];
    }
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], UITextAttributeTextColor,
                                                          nil]];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
