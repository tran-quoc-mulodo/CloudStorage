//
//  CSManagerAccount.m
//  CloudStorage
//
//  Created by Anh Quoc on 8/7/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import "CSManagerAccount.h"


static CSManagerAccount *_Instance = nil;

@implementation CSManagerAccount

+ (id)instance {
    @synchronized(self) {
        if (_Instance == nil) {
            _Instance = [[CSManagerAccount alloc] init];
        }
    }
    return _Instance;
}

- (void)dealloc {
    _Instance = nil;
}

@end
