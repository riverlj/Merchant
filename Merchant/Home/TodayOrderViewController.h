//
//  TodayOrderViewController.h
//  Merchant
//
//  Created by 李江 on 16/12/3.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderlistModel.h"

@interface TodayOrderViewController : BaseViewController
@property (nonatomic ,strong)OrderlistModel *orderlistModel;
@property (nonatomic ,copy)NSString *ordertype;
-(void)settableViewFrame;
-(void)reloadTableView ;
@end
