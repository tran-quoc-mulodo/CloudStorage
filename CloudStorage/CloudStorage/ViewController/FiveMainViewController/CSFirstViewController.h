//
//  CSFirstViewController.h
//  CloudStorage
//
//  Created by Anh Quoc on 7/14/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CSRootDropboxTableViewController;

@interface CSFirstViewController : UIViewController

- (void)actionWhenDidLinkToDrobox;
- (void)configView;

@property (nonatomic, strong) CSRootDropboxTableViewController *rootViewDropbox;

@end
