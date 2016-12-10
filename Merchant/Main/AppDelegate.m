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

@interface AppDelegate ()
@property (nonatomic,strong) MMDrawerController * drawerController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
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
    
    
    //导航样式
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                                          [UIFont boldSystemFontOfSize:17.0], NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setBackgroundColor:CORLOR_THEME];
    [[UINavigationBar appearance] setBarTintColor:CORLOR_THEME];
        
    return YES;
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
