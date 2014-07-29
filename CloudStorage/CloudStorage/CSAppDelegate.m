//
//  CSAppDelegate.m
//  CloudStorage
//
//  Created by Anh Quoc on 7/14/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import "CSAppDelegate.h"
#import "CSMainViewController.h"
#import "CSLoginViewController.h"
#import <DropboxSDK/DropboxSDK.h>

@interface CSAppDelegate () <DBSessionDelegate, DBNetworkRequestDelegate>

@end

@implementation CSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DBSession *dbSession = [[DBSession alloc] initWithAppKey:kCSDroboxAppKey
                                                   appSecret:kCSDroboxAppSecret
                                                        root:kDBRootDropbox];
    [DBSession setSharedSession:dbSession];
    [DBRequest setNetworkRequestDelegate:self];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.loginCotroller = [[CSLoginViewController alloc] initWithNibName:@"CSLoginViewController" bundle:nil];
    
    [self.window setRootViewController:_loginCotroller];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	if ([[DBSession sharedSession] handleOpenURL:url]) {
		if ([[DBSession sharedSession] isLinked]) {
            // link to account dropbox successfull
            [_mainController.controller1 actionWhenDidLinkToDrobox];
		}
		return YES;
	}
    
    // Add whatever other url handling code your app requires here
	
	return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Function Login

- (void)changeRootViewController:(NSInteger)config {
    [UIView beginAnimations:@"FlipFromLeft" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:_window cache:YES];
    [UIView commitAnimations];
    
    if (config == StatusLogin) {
        if (!_mainController) {
            self.mainController = [[CSMainViewController alloc] initWithNibName:@"CSMainViewController" bundle:nil];
        }
        [self.window setRootViewController:_mainController];
    } else {
        [self.window setRootViewController:_loginCotroller];
    }
}

#pragma mark -
#pragma mark UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)index {
	if (index != alertView.cancelButtonIndex) {
		[[DBSession sharedSession] linkUserId:relinkUserId fromController:_mainController.controller1];
	}
	relinkUserId = nil;
}

#pragma mark -
#pragma mark DBSessionDelegate methods

- (void)sessionDidReceiveAuthorizationFailure:(DBSession*)session userId:(NSString *)userId {
	relinkUserId = [NSString stringWithFormat:@"%@", userId];
	[[[UIAlertView alloc] initWithTitle:kCSDroboxSessionTitle
                                message:kCSDroboxSessionMessage
                               delegate:self
                      cancelButtonTitle:kCSTitleCancel
                      otherButtonTitles:kCSDroboxSessionRelink, nil] show];
}

#pragma mark -
#pragma mark DBNetworkRequestDelegate methods

static int outstandingRequests;

- (void)networkRequestStarted {
	outstandingRequests++;
	if (outstandingRequests == 1) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	}
}

- (void)networkRequestStopped {
	outstandingRequests--;
	if (outstandingRequests == 0) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
}

@end
