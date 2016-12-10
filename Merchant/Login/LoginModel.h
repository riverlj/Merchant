//
//  LoginModel.h
//  Merchant
//
//  Created by 李江 on 16/12/5.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject
+(void)loginWithPhoneNum:(NSString *)phoneNum password:(NSString *)pwd success:(void(^)(void))success;
@end
