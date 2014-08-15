//
//  CSFiveViewController.m
//  CloudStorage
//
//  Created by Anh Quoc on 7/14/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import "CSFiveViewController.h"

#define kAlertLogoutDropboxTag      100

@interface CSFiveViewController ()

@end

@implementation CSFiveViewController

#pragma mark -
#pragma mark life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self reloadDropboxLinking];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)dealloc {
    _tbvSetting = nil;
    _restClient = nil;
    _restAccountInfo = nil;
}

#pragma mark -
#pragma mark reload data by observer methods

- (void)reloadDropboxLinking {
    if([[DBSession sharedSession] isLinked]) {
        if (!_restClient) {
            _restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
            _restClient.delegate = self;
        }
        _isDropboxLinked = YES;
        [_restClient loadAccountInfo];
        [self.tbvSetting reloadData];
    } else {
        _isDropboxLinked = NO;
        _restClient = nil;
        _restAccountInfo = nil;
        [self.tbvSetting reloadData];
        // push notification to root dropbox viewcontroller
        [[NSNotificationCenter defaultCenter] postNotificationName:kCSNotificationDropboxUnlink
                                                            object:nil];
    }
}

#pragma mark -
#pragma mark tableView delegate and data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            if (_isDropboxLinked)
                return 3;
                return 1;
            break;
            
        case 1:
            return 1;
            break;
            
        case 2:
            return 1;
            break;
            
        case 3:
            return 1;
            break;
            
        case 4:
            return 3;
            break;
            
        default:
            break;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellSetting";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // set default
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    [cell.detailTextLabel setText:nil];
    
    
    // Configure the cell...
    switch (indexPath.section) {
        case 0: {
            // config Dropbox
            if (_isDropboxLinked) {
                switch (indexPath.row) {
                    case 0: {
                        if (_isDropboxLoadedData) {
                            [cell.detailTextLabel setText:_restAccountInfo.displayName];
                        }
                        [cell.textLabel setText:kCSName];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        break;
                    }
                        
                    case 1: {
                        if (_isDropboxLoadedData) {
                            [cell.detailTextLabel setText:[CSUtils calculatorStringUsedSpaceDropbox:[_restAccountInfo quota].totalBytes andUsedValue:[_restAccountInfo quota].normalConsumedBytes]];
                            _flagPercentText = YES;
                        }
                        [cell.textLabel setText:kCSSpaceUsed];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        break;
                    }
                        
                        
                    case 2: {
                        [cell.textLabel setText:kCSDroboxButtonUnLinkTitle];
                        [cell.textLabel setTextColor:[UIColor redColor]];
                        break;
                    }
                        
                    default:
                        break;
                }
            } else {
                [cell.textLabel setText:kCSDroboxButtonLinkTitle];
                [cell.textLabel setTextColor:kCSButtonTitleColor];
            }
            break;
        }
            
        case 1: {
            [cell.textLabel setText:@"Test"];
            break;
        }
            
        case 2: {
            [cell.textLabel setText:@"Test"];
            break;
        }
            
        case 3: {
            [cell.textLabel setText:@"Test"];
            break;
        }
            
        case 4: {
            switch (indexPath.row) {
                case 0:
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                    [cell.textLabel setText:kCSPasscodeLock];
                    [cell.detailTextLabel setText:kCSPasscodeBoolOff];
                    break;
                    
                case 1: {
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                    [cell.textLabel setText:kCSLegalPrivacy];
                }
                    break;
                case 2: {
                    [cell.textLabel setText:kCSAppVersion];
                    [cell.detailTextLabel setText:kCSNumberVersion];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    break;
                }
                    
                default:
                    break;
            }
            
            break;
        }
            
        case 5: {
            if (indexPath.row == 0) {
                [cell.textLabel setText:kCSShareApptoFacebook];
            } else {
                [cell.textLabel setText:kCSShareApptoTwitter];
            }
            
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            break;
        }
            
        default:
            break;
    }
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:14.0f]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            return kCSTitleTab1;
            break;
        }
            
        case 1: {
            return kCSTitleTab2;
            break;
        }
            
        case 2: {
            return kCSTitleTab3;
            break;
        }
            
        case 3: {
            return kCSTitleTab4;
            break;
        }
            
        case 4: {
            return kCSTitleTab5;
            break;
        }
            
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0: {
            if (_isDropboxLinked && _isDropboxLoadedData && indexPath.row == 1) {
                // change title of this cell
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                if (_flagPercentText) {
                    [cell.detailTextLabel setText:[CSUtils calculatorStringPercentUsedSpaceDropbox:[_restAccountInfo quota].totalBytes andUsedValue:[_restAccountInfo quota].normalConsumedBytes]];
                } else {
                   [cell.detailTextLabel setText:[CSUtils calculatorStringUsedSpaceDropbox:[_restAccountInfo quota].totalBytes andUsedValue:[_restAccountInfo quota].normalConsumedBytes]]; 
                }
                _flagPercentText = !_flagPercentText;
                
            } else if (_isDropboxLinked && indexPath.row == 2) {
                UIAlertView *alertConfirm = [[UIAlertView alloc] initWithTitle:kCSSignOutTitle
                                                                       message:kCSSignOutMessage
                                                                      delegate:self
                                                             cancelButtonTitle:kCSTitleCancel
                                                             otherButtonTitles:kCSSignOutTitle, nil];
                [alertConfirm setTag:kAlertLogoutDropboxTag];
                [alertConfirm show];
            } else if (!_isDropboxLinked){
                [[DBSession sharedSession] linkFromController:self];
            }
            break;
        }
            
        case 1: {
            
            break;
        }
            
        case 2: {
            
            break;
        }
            
        case 3: {
            
            break;
        }
            
        case 4: {
            
            break;
        }
            
        case 6: {
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark delege restClients reponse methods

- (void)restClient:(DBRestClient*)client loadedAccountInfo:(DBAccountInfo*)info {
    _isDropboxLoadedData = YES;
    if (_restAccountInfo) {
        _restAccountInfo = nil;
    }
    _restAccountInfo = info;
    [self.tbvSetting reloadData];
}

- (void)restClient:(DBRestClient*)client loadAccountInfoFailedWithError:(NSError*)error {
    
}

#pragma mark -
#pragma mark UIAlertView delegate methods
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (alertView.tag) {
        case kAlertLogoutDropboxTag: {
            if (buttonIndex != alertView.cancelButtonIndex) {
                [[DBSession sharedSession] unlinkAll];
                [self reloadDropboxLinking];
            }
            break;
        }
            
        default:
            break;
    }
}

@end
