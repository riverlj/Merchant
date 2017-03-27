//
//  AppDelegate.m
//  Merchant
//
//  Created by 李江 on 16/11/29.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "BaseNavigationController.h"
#import "LoginViewController.h"
#import "PersonalViewController.h"
#import "MMDrawerController.h"
#import "SVProgressHUD.h"
#import "AllModelDetail.h"
#import "BCListViewController.h"
#import "PrintUtli.h"
#import <JSPatchPlatform/JSPatch.h>

@interface AppDelegate ()<BluetoothDelegate>
{
    NSArray *_parray;
}
@property (nonatomic,strong) MMDrawerController * drawerController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [JSPatch startWithAppKey:@"你的AppKey"];
    [JSPatch sync];
    
    [NSUserDefaults clearLastDayPrint];
    [NSUserDefaults clearLastDayPrintedtype];
    //
    NSString *token = [NSUserDefaults getValue:@"token"];
    if (token.length > 0) {
        [self updateWindowRootViewController];
    }else {
        LoginViewController *login = [[LoginViewController alloc] init];
        BaseNavigationController *loginNav = [[BaseNavigationController alloc] initWithRootViewController:login];
        self.window.rootViewController = loginNav;
    }
    
    [self.window makeKeyAndVisible];
    
    NSDictionary*configure=[PrinterWraper getPrinterSetting];
    NSMutableDictionary *newdic =[NSMutableDictionary dictionaryWithDictionary:configure];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectSuccess) name:@"auto_connect_success" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(printfinshed) name:@"PRINT_ORDER_FINISH" object:nil];

    
    [newdic setObject:@2 forKey:@"keepAlive"];//0 打完后断开,1 打完后自动决定,2打完后继续连接
    [PrinterWraper setPrinterSetting:newdic];
    
    [SVProgressHUD showWithStatus:@"正在自动连接打印机"];
    [PrinterWraper autoConnectLastPrinterTimeout:10 Completion:^(NSString *uid) {
        if (uid) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"auto_connect_success" object:nil];
            [SVProgressHUD showSuccessWithStatus:@"打印机连接成功"];
        }else
            [SVProgressHUD dismiss];
    }];


    //导航样式
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                                          [UIFont boldSystemFontOfSize:17.0], NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setBackgroundColor:CORLOR_THEME];
    [[UINavigationBar appearance] setBarTintColor:CORLOR_THEME];
    
    return YES;
}

-(void) connectSuccess
{
    self.canprint = YES;
    //自动打印
    BOOL autoprint = [[NSUserDefaults getValue:@"autoprint"] boolValue];
    
    BOOL intime = false;
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * currentStr = [df stringFromDate:currentDate];
    
    NSArray *array = @[
                       @[@"06:00:00",@"06:30:00"],
                       @[@"11:00:00",@"11:30:00"],
                       @[@"17:00:00",@"17:30:00"]
                       ];
    int type = 0;
    for (int i=0; i<array.count; i++) {
        type=i+1;
        NSMutableArray *marray1 = [[NSMutableArray alloc] init];
        for (NSString *str in array[i]) {
            NSString *tempstr = [NSString stringWithFormat:@"%@ %@", currentStr, str];
            [marray1 addObject:tempstr];
            
        }
        intime = [self validateWithStartTime:marray1[0] withExpireTime:marray1[1]];
        if (intime) {
            break;
        }
    }
    
    //该类型今天是否打印过
    NSMutableDictionary *dic = [NSUserDefaults getPrintedType];
    NSString *typeprinted = [dic valueForKey:[NSString stringFromNumber:@(type)]];
    if (typeprinted.length>0 && [typeprinted integerValue] == 1) {
        return;
    }
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (autoprint && intime &&delegate.canprint) {
        [SVProgressHUD showWithStatus:@"正在自动打印"];
        [AllModelDetail getAllOrderDetail:[NSString stringFromNumber:@(type)] OrderDate:currentStr success:^(AllModelDetail *model) {
            
            //只会自动打印一次
            NSMutableDictionary *dic = [NSUserDefaults getPrintedType];
            [dic setValue:@"1" forKey:[NSString stringFromNumber:@(type)]];
            [NSUserDefaults setPrintedType:dic];
            
            _parray = model.orders;
            [PrintUtli print:_parray fromVc:self nav:nil printListVc:nil];
        }];
    }
}

-(void)finishPrint
{
    [self printfinshed];
}

-(void)printfinshed
{
    
    NSArray *array = [NSUserDefaults getPrintedOrders];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    [mArray addObjectsFromArray:array];
    for (OrderModel *model in _parray) {
        NSString *orderid = model.orderid;
        BOOL flag = false;
        for (NSString *torderid in array) {
            if ([torderid isEqualToString:orderid]) {
                flag = true;
                break;
            }
        }
        
        if (!flag) {
            [mArray addObject:orderid];
        }
    }
    [NSUserDefaults setPrintedOrders:mArray];
}

- (BOOL)validateWithStartTime:(NSString *)startTime withExpireTime:(NSString *)expireTime {
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // 时间格式,此处遇到过坑,建议时间HH大写,手机24小时进制和12小时禁止都可以完美格式化
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *start = [dateFormat dateFromString:startTime];
    NSDate *expire = [dateFormat dateFromString:expireTime];
    
    if ([today compare:start] == NSOrderedDescending && [today compare:expire] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}


-(void)updateWindowRootViewController
{
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:[[HomeViewController alloc]init]];
    
    self.currentNav = baseNav;
    
    PersonalViewController *personalVc = [[PersonalViewController alloc] init];
    
    
    self.drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:baseNav
                                             leftDrawerViewController:personalVc];
    
    //4、设置打开/关闭抽屉的手势
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    self.drawerController.showsShadow = NO;
    //5、设置左右两边抽屉显示的多少
    self.drawerController.maximumLeftDrawerWidth = 250.0;
    self.drawerController.maximumRightDrawerWidth = 250.0;
    
    self.window.rootViewController = self.drawerController;

}

@end
