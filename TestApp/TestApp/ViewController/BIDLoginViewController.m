//
//  BIDLoginViewController.m
//  TestApp
//
//  Created by Anh Quoc on 7/8/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

#import "BIDLoginViewController.h"
#import "BIDAppDelegate.h"

@interface BIDLoginViewController ()

@end

@implementation BIDLoginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick:(id)sender {
    [kBIDAppDelegate changeRootViewController:StatusLogin];
}

- (BOOL)shouldAutorotate {
    return NO;
}

@end
