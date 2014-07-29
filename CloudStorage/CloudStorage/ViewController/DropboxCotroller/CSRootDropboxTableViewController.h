//
//  CSRootDropboxTableViewController.h
//  CloudStorage
//
//  Created by Anh Quoc on 7/24/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import "CSBaseTableViewController.h"
#import <DropboxSDK/DropboxSDK.h>

@interface CSRootDropboxTableViewController : CSBaseTableViewController <DBRestClientDelegate> {
    DBRestClient            *_restClient;
    NSArray                 *_metaDataContent;
}

@end
