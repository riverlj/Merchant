//
//  LoginViewController.m
//  Merchant
//
//  Created by 李江 on 16/12/2.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "LoginModel.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *cellphoneTextFild;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFild;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
}
- (IBAction)loginAction:(UIButton *)sender {
    if (_cellphoneTextFild.text.length==0) {
        [[RSToastView shareRSToastView] showToast:@"用户名不能为空"];
        return;
    }
    if (_passwordTextFild.text.length==0) {
        [[RSToastView shareRSToastView] showToast:@"密码不能为空"];
    }
    [[RSToastView shareRSToastView] showHUD:@""];
    __weak LoginViewController *selfWeak = self;
    [LoginModel loginWithPhoneNum:_cellphoneTextFild.text password:_passwordTextFild.text success:^{
        [selfWeak.view endEditing:YES];
        [[RSToastView shareRSToastView] hidHUD];
        //跳转到首页
        AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate updateWindowRootViewController];
    }];
}
@end
