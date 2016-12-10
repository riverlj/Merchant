//
//  LoginModel.m
//  Merchant
//
//  Created by 李江 on 16/12/5.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
+(void)loginWithPhoneNum:(NSString *)phoneNum password:(NSString *)pwd success:(void(^)(void))success
{
    NSDictionary *params = @{
                             @"login" : phoneNum,
                             @"password" : pwd
                             };
    [RSHttp requestWithURL:@"/account/login" params:params httpMethod:@"POSTJSON" success:^(NSDictionary *data) {
        NSString *token = [data valueForKey:@"token"];
        [NSUserDefaults setValue:token forKey:@"token"];
        NSString *token2 = [NSUserDefaults getValue:@"token"];
        NSLog(@"%@",token2);
        success();
    } failure:^(NSInteger code, NSString *errmsg) {
        [[RSToastView shareRSToastView] showToast:errmsg];
    }];
}
@end
