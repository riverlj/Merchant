//
//  HistoryTableViewCell.h
//  Merchant
//
//  Created by 李江 on 16/12/3.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel *timeLabel;
@property (nonatomic ,strong)UILabel *numLabel;
@property (nonatomic ,strong)UILabel *totalMoneyLabel;

-(void)setModels:(id)model;
@end
