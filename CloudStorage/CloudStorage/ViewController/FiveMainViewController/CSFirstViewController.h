//
//  CSFirstViewController.h
//  CloudStorage
//
//  Created by Anh Quoc on 7/14/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

@class DBRestClient;

#import <UIKit/UIKit.h>

@interface CSFirstViewController : UIViewController {
    DBRestClient* restClient;
}

- (void)actionWhenDidLinkToDrobox;

@end
