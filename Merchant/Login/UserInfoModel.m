//
//  UserInfoModel.m
//  Merchant
//
//  Created by 李江 on 16/12/6.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "UserInfoModel.h"
#import "AppDelegate.h"

@implementation UserInfoModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userid" : @"id"};
}

+(void)getUserInfoSuccess:(void(^)(void))success
{
    [RSHttp requestWithURL:@"/account/getuserinfo" params:nil httpMethod:@"GET" success:^(NSDictionary *data) {
        UserInfoModel *userModel = [UserInfoModel yy_modelWithDictionary:data];
         AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        delegate.userInfoModel = userModel;
        success();
    } failure:^(NSInteger code, NSString *errmsg) {
        [[RSToastView shareRSToastView] showToast:errmsg];
    }];
}

+(void)getUserbizlistSuccess:(void(^)(void))success
{
    [RSHttp requestWithURL:@"/order/bizlist" params:nil httpMethod:@"GET" success:^(NSArray *data) {
        AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        delegate.userInfoModel.bizlist = data;
        success();
    } failure:^(NSInteger code, NSString *errmsg) {
        [[RSToastView shareRSToastView] showToast:errmsg];
    }];
}

@end
