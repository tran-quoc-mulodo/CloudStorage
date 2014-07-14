//
//  CSAppDelegate.h
//  CloudStorage
//
//  Created by Anh Quoc on 7/14/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CSMainViewController;
@class CSLoginViewController;

@interface CSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CSMainViewController *mainController;
@property (strong, nonatomic) CSLoginViewController *loginCotroller;

- (void)changeRootViewController:(NSInteger)config;

@end
