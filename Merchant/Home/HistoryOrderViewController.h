//
//  HistoryOrderViewController.h
//  Merchant
//
//  Created by 李江 on 16/12/3.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "BaseViewController.h"

@interface HistoryOrderViewController : BaseViewController
@property (nonatomic ,copy)NSArray *datasource;
@property (nonatomic ,copy)NSString *ordertype;

-(void)settableViewFrame;
-(void)reloadTableView;
@end
