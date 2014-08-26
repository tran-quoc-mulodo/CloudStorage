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

@interface CSAppDelegate : UIResponder <UIApplicationDelegate> {
    NSString *relinkUserId;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CSMainViewController *mainController;
@property (strong, nonatomic) CSLoginViewController *loginCotroller;

// for core data
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)changeRootViewController:(NSInteger)config;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
