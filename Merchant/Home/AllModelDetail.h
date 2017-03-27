//
//  AllModelDetail.h
//  Merchant
//
//  Created by 李江 on 16/12/6.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
@property (nonatomic ,copy)NSString *orderid;
@property (nonatomic ,copy)NSString *ordertime;
@property (nonatomic ,strong)NSNumber *num;
@property (nonatomic ,copy)NSString *username;
@property (nonatomic ,copy)NSString *mobile;
@property (nonatomic ,copy)NSString *address;
@property (nonatomic ,copy)NSArray *dashes;
@property (nonatomic ,strong)NSNumber *seq;
@property (nonatomic ,assign)BOOL printed;

@property (nonatomic,copy) NSString *saleprice;
@property (nonatomic,copy) NSString *payed;
@property (nonatomic,copy) NSString *bonus;


@end

@interface AllModelDetail : NSObject
@property (nonatomic ,copy)NSString *date;
@property (nonatomic ,copy)NSNumber *ordernum;
@property (nonatomic ,copy)NSArray *orders;

+(void)getAllOrderDetail:(NSString *)cateid OrderDate:(NSString *)date success:(void(^)(AllModelDetail *model))success;
@end
