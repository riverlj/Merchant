//
//  AllModelDetail.m
//  Merchant
//
//  Created by 李江 on 16/12/6.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "AllModelDetail.h"
#import "OrderlistModel.h"

@implementation AllModelDetail
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"orders" : [OrderModel class]};
}

+(void)getAllOrderDetail:(NSString *)cateid OrderDate:(NSString *)date success:(void(^)(AllModelDetail *model))success
{
    NSDictionary *params = @{@"category":cateid,
                             @"curdate" : date};
    [RSHttp requestWithURL:@"/order/alldetail" params:params httpMethod:@"GET" success:^(NSDictionary *data) {
        AllModelDetail *model = [AllModelDetail yy_modelWithDictionary:data];
        success(model);
    } failure:^(NSInteger code, NSString *errmsg) {
        [[RSToastView shareRSToastView] showToast:errmsg];
    }];
}
@end

@implementation OrderModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"dashes" : [ProductsDesc class]};
}

@end
