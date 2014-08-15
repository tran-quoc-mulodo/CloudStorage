//
//  CSUtils.h
//  CloudStorage
//
//  Created by Anh Quoc on 8/15/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSUtils : NSObject


// Util for Dropbox
+ (NSString *)calculatorFromByteToOther:(long long)byte;
+ (NSString *)calculatorStringPercentUsedSpaceDropbox:(long long)allValue andUsedValue:(long long)usedValue;
+ (NSString *)calculatorStringUsedSpaceDropbox:(long long)allValue andUsedValue:(long long)usedValue;

@end
