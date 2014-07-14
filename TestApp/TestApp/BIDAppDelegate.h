//
//  BIDAppDelegate.h
//  TestApp
//
//  Created by Anh Quoc on 7/7/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BIDMainViewController;
@class BIDLoginViewController;

@interface BIDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BIDMainViewController *mainController;
@property (strong, nonatomic) BIDLoginViewController *loginCotroller;

- (void)changeRootViewController:(NSInteger)config;


@end
