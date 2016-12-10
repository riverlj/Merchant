//
//  UserInfoModel.h
//  Merchant
//
//  Created by 李江 on 16/12/6.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic ,copy)NSString *userid;
@property (nonatomic ,copy)NSString *mobile;
@property (nonatomic ,copy)NSString *login;
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSArray *address;
@property (nonatomic ,strong)NSArray *bizlist;


+(void)getUserInfoSuccess:(void(^)(void))success;
+(void)getUserbizlistSuccess:(void(^)(void))success;
@end
