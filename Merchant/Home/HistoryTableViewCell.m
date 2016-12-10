//
//  HistoryTableViewCell.m
//  Merchant
//
//  Created by 李江 on 16/12/3.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import "OrderlistModel.h"

@implementation HistoryTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, (SCREEN_WIDTH-30)/3, 45)];
        self.timeLabel.textColor = CORLOR_222222;
        self.timeLabel.font = RS_FONT_14;
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.timeLabel];
        
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+((SCREEN_WIDTH-30)/3), 0, (SCREEN_WIDTH-30)/3, 45)];
        self.numLabel.textColor = CORLOR_222222;
        self.numLabel.font = RS_FONT_14;
        self.numLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.numLabel];
        
        self.totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15+(SCREEN_WIDTH-30)/3*2, 0, (SCREEN_WIDTH-30)/3, 45)];
        self.totalMoneyLabel.textColor = CORLOR_222222;
        self.totalMoneyLabel.font = RS_FONT_14;
        self.totalMoneyLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.totalMoneyLabel];
        
        CALayer *lineLayer = [[CALayer alloc] init];
        lineLayer.frame = CGRectMake(0, 44, SCREEN_WIDTH, 1);
        lineLayer.backgroundColor = CORLOR_LINE.CGColor;
        [self.contentView.layer addSublayer:lineLayer];
        
    }
    return self;
}

-(void)setModels:(OrderlistModel*)model
{
    self.timeLabel.text = model.date;
    self.numLabel.text = [NSString stringFromNumber:model.num];
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"%.2f", model.money.floatValue];
}

@end
