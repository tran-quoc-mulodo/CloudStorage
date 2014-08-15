//
//  CSFiveViewController.h
//  CloudStorage
//
//  Created by Anh Quoc on 7/14/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>

@interface CSFiveViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, DBRestClientDelegate> {
    
    // Dropbox
    DBRestClient            *_restClient;
    DBAccountInfo           *_restAccountInfo;
    BOOL                    _isDropboxLinked;
    BOOL                    _isDropboxLoadedData;
    BOOL                    _flagPercentText;
}

@property (strong, nonatomic) IBOutlet UITableView *tbvSetting;

- (void)reloadDropboxLinking;

@end
