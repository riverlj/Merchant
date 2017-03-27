//
//  AppHeader.h
//  Merchant
//
//  Created by 李江 on 16/12/2.
//  Copyright © 2016年 riverli. All rights reserved.
//

#ifndef AppHeader_h
#define AppHeader_h

#import "Theme.h"
#import "UIView+CustomFrame.h"
#import "NSString+RSHttp.h"
#import "UIDeviceAdditions.h"
#import "NSUserDefaults+Token.h"
#import "ViewsHeader.h"
#import "MBProgressHUD.h"
#import "YYCache.h"
#import "YYModel.h"
#import "RSHttp.h"
#import "RSToastView.h"
#import "PrinterSDK.h"
#import <CoreBluetooth/CoreBluetooth.h>

#ifdef DEBUG
#define  REDSCARF_BASE_URL @"http://e.dev.honglingjinclub.com"
#define REDSCARF_PAY_URL @""
#define REDSCARF_MOBILE_URL @"http://test.dev.honglingjinclub.com"
#define APP_REGISTER_URL @"http://test.dev.honglingjinclub.com/web/register.html"
#define APP_RESETPWD_URL @"http://test.dev.honglingjinclub.com/web/resetPwd.html"
#define APP_CHANNEL_BASE_URL @"http://test.dev.honglingjinclub.com/web/index.html#"

#define UTM_SOURCE @"testDev"
#else
//正式
#define  REDSCARF_BASE_URL @"http://e.honglingjinclub.com"
#define  REDSCARF_PAY_URL @""
#define  REDSCARF_MOBILE_URL @"http://waimai.honglingjinclub.com"
#define APP_REGISTER_URL @"http://waimai.honglingjinclub.com/web/register.html"
#define APP_RESETPWD_URL @"http://waimai.honglingjinclub.com/web/resetPwd.html"

#define APP_CHANNEL_BASE_URL @"http://waimai.honglingjinclub.com/web/index.html#"

#define UTM_SOURCE @"AppStore"
#endif

#define APPREQUESTTIMEOUT 5
#define MAINWINDOW [UIApplication sharedApplication].keyWindow

#endif /* AppHeader_h */
