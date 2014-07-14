//
//  BIDConstants.h
//  TestApp
//
//  Created by Anh Quoc on 7/14/14.
//  Copyright (c) 2014 Apress. All rights reserved.
//

typedef enum {
	StatusLogin = 0,
    StatusLogout = 1
} StatusLoginType;


// Singleton
#define kBIDAppDelegate    (BIDAppDelegate*)[[UIApplication sharedApplication] delegate]


// Color
#define kBIDNavigationBackgroundColor [UIColor colorWithRed:37.0f/255.0f green:135.0f/255.0f blue:193.0f/255.0f alpha:1.0]