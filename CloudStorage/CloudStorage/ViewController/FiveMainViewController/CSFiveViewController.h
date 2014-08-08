//
//  CSFiveViewController.h
//  CloudStorage
//
//  Created by Anh Quoc on 7/14/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>

@interface CSFiveViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, DBRestClientDelegate> {
    DBRestClient            *_restClient;
    BOOL                    _isDropboxLinked;
}

@property (strong, nonatomic) IBOutlet UITableView *tbvSetting;

- (void)reloadDropboxLinking;

@end
