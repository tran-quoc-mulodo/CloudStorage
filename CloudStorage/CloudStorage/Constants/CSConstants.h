//
//  CSConstants.h
//  CloudStorage
//
//  Created by Anh Quoc on 7/14/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

typedef enum {
	StatusLogin = 0,
    StatusLogout = 1
} StatusLoginType;

// Drobox constants
#define kCSDroboxAppKey                     @"hmj6fernx13fv4a"
#define kCSDroboxAppSecret                  @"hc5dk9yccs2782v"

// Message Dropbox
#define kCSDroboxSessionTitle               @"Dropbox Session Ended"
#define kCSDroboxSessionMessage             @"Do you want to relink?"
#define kCSDroboxSessionRelink              @"Relink"


// Singleton
#define kCSAppDelegate    (CSAppDelegate*)[[UIApplication sharedApplication] delegate]


// Color
#define kCSNavigationBackgroundColor [UIColor colorWithRed:37.0f/255.0f green:135.0f/255.0f blue:193.0f/255.0f alpha:1.0]
#define kCSSearchBarBackgroundColor [UIColor colorWithRed:237.0f/255.0f green:237.0f/255.0f blue:237.0f/255.0f alpha:0.5]


// Constants

#define kCSTitleCancel                      @"Cancel"
