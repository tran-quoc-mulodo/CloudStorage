//
//  NSDate+HumanizedTime.h
//  CloudStorage
//
//  Created by Anh Quoc on 8/1/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NSDateHumanizedType)
{
	NSDateHumanizedSuffixNone = 0,
    NSDateHumanizedSuffixLeft,
    NSDateHumanizedSuffixAgo
};

@interface NSDate (HumanizedTime)

- (NSString *) stringWithHumanizedTimeDifference:(NSDateHumanizedType) humanizedType withFullString:(BOOL) fullStrings;

@end
