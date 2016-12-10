//
//  OrderlistModel.h
//  Merchant
//
//  Created by 李江 on 16/12/6.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderlistModel : NSObject

@property (nonatomic ,copy)NSString *date;
@property (nonatomic ,copy)NSNumber *num;
@property (nonatomic ,copy)NSNumber *money;
@property (nonatomic ,copy)NSArray *productsDescArr;

+(void)getOrderList:(NSString *)cateid success:(void(^)(NSArray *))success;

@end

@interface ProductsDesc : NSObject
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSNumber *num;
@end
