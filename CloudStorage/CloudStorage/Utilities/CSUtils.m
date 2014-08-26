//
//  CSUtils.m
//  CloudStorage
//
//  Created by Anh Quoc on 8/15/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import "CSUtils.h"
#import "CSReachability.h"

@implementation CSUtils

+ (BOOL)checkNetWorkIsConnect {
    return ISCONNECTINGNETWORK;
}

+ (NSString *)calculatorFromByteToOther:(long long)value {
    int multiplyFactor = 0;
    double convertValue = (double)value;
    
    NSArray *tokens = @[@"bytes", @"KB", @"MB", @"GB", @"TB"];
    
    while (convertValue > 1024) {
        convertValue /= 1024;
        multiplyFactor++;
    }
    
    return [NSString stringWithFormat:@"%4.1f %@", convertValue, tokens[multiplyFactor]];
}

+ (NSString *)calculatorStringPercentUsedSpaceDropbox:(long long)allValue andUsedValue:(long long)usedValue {
    double convertAllValue = (double)allValue;
    double convertUsedValue = (double)usedValue;
    double percent = convertUsedValue/convertAllValue*100;
    return [NSString stringWithFormat:@"%4.1f%% of %@", percent, [self calculatorFromByteToOther:allValue]];
}

+ (NSString *)calculatorStringUsedSpaceDropbox:(long long)allValue andUsedValue:(long long)usedValue {
    return [NSString stringWithFormat:@"%@ of %@", [self calculatorFromByteToOther:usedValue], [self calculatorFromByteToOther:allValue]];
}

@end
