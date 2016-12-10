//
//  OrderInfoTableViewCell.h
//  Merchant
//
//  Created by 李江 on 16/12/3.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllModelDetail.h"

@protocol  PrintBtnClickDelegate<NSObject>
-(void)printBtnClick:(OrderModel *)model;
@end

@interface TwoLabelView : UIView

@property (nonatomic ,strong)UILabel *leftLabel;
@property (nonatomic ,strong)UILabel *rightLabel;



@end

@interface OrderInfoTableViewCell : UITableViewCell

@property (nonatomic ,strong)TwoLabelView *headerView;
@property (nonatomic ,strong)TwoLabelView *userNameView;
@property (nonatomic ,strong)TwoLabelView *cellView;
@property (nonatomic ,strong)TwoLabelView *orderAddressView;
@property (nonatomic ,strong)TwoLabelView *orderNumView;
@property (nonatomic ,strong)UIButton *printButton;

@property (nonatomic ,weak)id<PrintBtnClickDelegate> printBtnClickDelegate;


-(void)setModels:(id)model;
@end
