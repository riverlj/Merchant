//
//  AppDelegate.h
//  Merchant
//
//  Created by 李江 on 16/11/29.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"
#import "UserInfoModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic ,strong)BaseNavigationController *currentNav;
@property (nonatomic ,strong)UserInfoModel *userInfoModel;




-(void)updateWindowRootViewController;

@end

