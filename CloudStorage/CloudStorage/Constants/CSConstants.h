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

// net work
#define ISCONNECTINGNETWORK	(([[CSReachability reachabilityForInternetConnection] currentReachabilityStatus]!=NotReachable)||([[CSReachability reachabilityForLocalWiFi] currentReachabilityStatus]!=NotReachable))

// Drobox constants
#define kCSDroboxAppKey                     @"hmj6fernx13fv4a"
#define kCSDroboxAppSecret                  @"hc5dk9yccs2782v"

// Message Dropbox
#define kCSDroboxSessionTitle               @"Dropbox Session Ended"
#define kCSDroboxSessionMessage             @"Do you want to relink?"
#define kCSDroboxSessionRelink              @"Relink"
#define kCSDroboxPlaceHolderSearch          @"Search"
#define kCSDroboxPlaceHolderSearchFolder    @"Search this Folder"
#define kCSDroboxButtonLinkTitle            @"Link to Dropbox"
#define kCSDroboxButtonUnLinkTitle          @"Unlink this account"
#define kCSDroboxThumbnailSize              @"32x32"

// Message Setting
#define kCSNumberVersion                    @"1.0"
#define kCSPasscodeLock                     @"Passcode Lock"
#define kCSPasscodeBoolOn                   @"On"
#define kCSPasscodeBoolOff                  @"Off"
#define kCSLegalPrivacy                     @"Legal & Privacy"
#define kCSAppVersion                       @"App Version"
#define kCSShareApptoFacebook               @"Share CloudStorage to Facebook!"
#define kCSShareApptoTwitter                @"Share CloudStorage to Twitter!"
#define kCSEmail                            @"Email"
#define kCSName                             @"Name"
#define kCSSpaceUsed                        @"Space Used"

// key of Notification
#define kCSNotificationDropboxUnlink        @"kNotificationCenter_DropboxUnlink"

// key Entity Core Data
#define kCSEntityDropbox                    @"DropboxEntity"

// key Attribute Core Data
#define kCSDropboxPath                      @"path"
#define kCSDropboxMetaData                  @"metaData"

// Singleton
#define kCSAppDelegate                  (CSAppDelegate*)[[UIApplication sharedApplication] delegate]
#define kCSManagerAccount               [CSManagerAccount instance]


// Color
#define kCSNavigationBackgroundColor [UIColor colorWithRed:37.0f/255.0f green:135.0f/255.0f blue:193.0f/255.0f alpha:1.0]
#define kCSSearchBarBackgroundColor [UIColor colorWithRed:237.0f/255.0f green:237.0f/255.0f blue:237.0f/255.0f alpha:0.5]
#define kCSButtonTitleColor [UIColor colorWithRed:0 green:0.478431 blue:1.0 alpha:1.0]

// For alert and action sheet
#define kCSSignOutTitle                     @"Sign Out"
#define kCSSignOutMessage                   @"This action will remove all files from this iPhone. Are you sure?"

// Constants
#define kCSTitleCancel                      @"Cancel"
#define kCSTitleOk                          @"OK"
#define kCSTitleTab1                        @"Dropbox"
#define kCSTitleTab2                        @"Box"
#define kCSTitleTab3                        @"Google Drive"
#define kCSTitleTab4                        @"Sky Drive"
#define kCSTitleTab5                        @"Setting"
