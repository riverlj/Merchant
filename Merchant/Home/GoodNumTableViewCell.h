//
//  GoodNumTableViewCell.h
//  Merchant
//
//  Created by 李江 on 16/12/3.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  DetailBtnClickDelegate<NSObject>
-(void)detailBtnClick;
@end

@interface GoodNumTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel *timeLabel;
@property (nonatomic ,strong)UIButton *detailBtn;
@property (nonatomic ,weak)id<DetailBtnClickDelegate> detailBtnClickDelegate;


-(void)setModels:(id)model;
@end


