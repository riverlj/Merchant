//
//  OrderlistModel.m
//  Merchant
//
//  Created by 李江 on 16/12/6.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "OrderlistModel.h"


@implementation OrderlistModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userid" : @"id"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"productsDescArr" : [ProductsDesc class]};
}

+(void)getOrderList:(NSString *)cateid success:(void(^)(NSArray *))success
{
    NSDictionary *params = @{@"category":cateid};
    [RSHttp requestWithURL:@"/order/list" params:params httpMethod:@"GET" success:^(NSArray *data) {
        NSArray *array = [NSArray yy_modelArrayWithClass:OrderlistModel.class json:data];
        success(array);
    } failure:^(NSInteger code, NSString *errmsg) {
        [[RSToastView shareRSToastView] showToast:errmsg];
    }];
}
@end

@implementation ProductsDesc

@end
