//
//  CSManagerAccount.h
//  CloudStorage
//
//  Created by Anh Quoc on 8/7/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DropboxSDK/DropboxSDK.h>

@interface CSManagerAccount : NSObject <DBRestClientDelegate>  {
    
}

+ (id)instance;

@end
