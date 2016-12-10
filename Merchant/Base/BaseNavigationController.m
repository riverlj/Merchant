//
//  BaseNavigationController.m
//  Merchant
//
//  Created by 李江 on 16/11/29.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

+(void)initialize {
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    navigationBar.backIndicatorImage = [UIImage imageNamed:@"nav-goback"];
    navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"nav-goback"];
    navigationBar.tintColor = [UIColor whiteColor];


}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [super pushViewController:viewController animated:animated];
}

@end
