//
//  CSRootDropboxTableViewController.h
//  CloudStorage
//
//  Created by Anh Quoc on 7/24/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import "CSBaseTableViewController.h"
#import <DropboxSDK/DropboxSDK.h>
#import "NSDate+HumanizedTime.h"

@interface CSRootDropboxTableViewController : CSBaseTableViewController <DBRestClientDelegate, UISearchBarDelegate, UISearchDisplayDelegate> {
    DBRestClient            *_restClient;
    NSArray                 *_metaDataContent;
    NSArray                 *_metaDataContentSearch;
    BOOL                    _isRoot;
    BOOL                    _flagStopLoad;
    NSInteger               _numberFile;
    NSInteger               _numberFolder;
    NSInteger               _numberFileSearch;
    NSInteger               _numberFolderSearch;
    NSInteger               _numberThumbnailCount;
    NSDateHumanizedType     _humanizedType;
}

@property (nonatomic, strong) NSString *path;
@property (nonatomic, assign) BOOL  isRoot;

- (void)loadThumbnailWithFilePath:(NSString *)path andDesPath:(NSString *)destinationPath;

@end
