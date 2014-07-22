//
//  CSMainTabViewController.h
//  CloudStorage
//
//  Created by Anh Quoc on 7/14/14.
//  Copyright (c) 2014 anhquoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSFirstViewController.h"
#import "CSSecondViewController.h"
#import "CSThirdViewController.h"
#import "CSFourViewController.h"
#import "CSFiveViewController.h"

@interface CSMainTabViewController : UITabBarController {
    
}

@property (nonatomic, strong) CSFirstViewController *controller1;
@property (nonatomic, strong) CSSecondViewController *controller2;
@property (nonatomic, strong) CSThirdViewController *controller3;
@property (nonatomic, strong) CSFourViewController *controller4;
@property (nonatomic, strong) CSFiveViewController *controller5;

@end
