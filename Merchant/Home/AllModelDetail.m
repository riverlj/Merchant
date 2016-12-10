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
        NSDictionary *dic = @{
            @"date": @"2016-11-04",
            @"ordernum": @(4),
            @"orders": @[
                        @{
                            @"orderid": @"4067",
                            @"ordertime": @"2016-11-03 20:47:07",
                            @"num": @(1),
                            @"username": @"安南",
                            @"mobile": @"13811508888",
                            @"address": @"中电发展大厦A韵苑学生公寓楼1",
                            @"dashes": @[
                                         @{
                                             @"id": @(1),
                                             @"name": @"包子",
                                             @"num": @(2)
                                             }
                                         ],
                            @"seq": @(2)
                        },
                        @{
                            @"orderid": @"4070",
                            @"ordertime": @"2016-11-03 20:49:46",
                            @"num": @(1),
                            @"username": @"安南",
                            @"mobile": @"13811508888",
                            @"address": @"中电发展大厦A韵苑学生公寓楼1",
                            @"dashes": @[
                                         @{
                                             @"id": @(1),
                                             @"name": @"包子",
                                             @"num": @(2)
                                             }
                                         ],
                            @"seq": @(1)
                        }
                        ]
        };
//        AllModelDetail *model = [AllModelDetail yy_modelWithDictionary:data];
        AllModelDetail *model = [AllModelDetail yy_modelWithDictionary:dic];
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
