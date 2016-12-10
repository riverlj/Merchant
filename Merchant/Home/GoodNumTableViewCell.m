//
//  GoodNumTableViewCell.m
//  Merchant
//
//  Created by 李江 on 16/12/3.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "GoodNumTableViewCell.h"
#import "OrderlistModel.h"

@implementation GoodNumTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 40)];
        self.timeLabel.textColor = CORLOR_7d7d7d;
        self.timeLabel.font = RS_FONT_12;
        [self.contentView addSubview:self.timeLabel];
        
        CALayer *lineLayer = [[CALayer alloc] init];
        lineLayer.frame = CGRectMake(-15, 39, SCREEN_WIDTH+15, 1);
        lineLayer.backgroundColor = CORLOR_LINE.CGColor;
        [self.timeLabel.layer addSublayer:lineLayer];
        
        self.detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.detailBtn.frame = CGRectMake(SCREEN_WIDTH-90, 40, 90, 0);
        [self.detailBtn setTitle:@"详情" forState:UIControlStateNormal];
        [self.detailBtn setTitle:@"详情" forState:UIControlStateHighlighted];
        self.detailBtn.titleLabel.font = RS_FONT_14;
        [self.detailBtn setTitleColor:CORLOR_THEME forState:UIControlStateNormal];
        [self.detailBtn setTitleColor:CORLOR_THEME forState:UIControlStateHighlighted];
        [self.detailBtn addTarget:self action:@selector(detailBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.detailBtn];
    }
    
    return self;
}

-(void)setModels:(OrderlistModel *)model
{
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@需要生产的早餐菜品", model.date];
    for (int i=0; i<model.productsDescArr.count; i++) {
        ProductsDesc *pdes = model.productsDescArr[i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 40+45*i, SCREEN_WIDTH-90, 45)];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, view.width-60-15, 44)];
        label1.textColor = CORLOR_222222;
        label1.font = RS_FONT_14;
        label1.text = pdes.name;
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(label1.right, 0, 59-15, 44)];
        label2.textAlignment = NSTextAlignmentRight;
        label2.textColor = CORLOR_222222;
        label2.font = RS_FONT_14;
        label2.text = [NSString stringFromNumber:pdes.num];
        
        [view addSubview:label1];
        [view addSubview:label2];
        
        [self.contentView addSubview:view];
        
        CALayer *lineLayer = [[CALayer alloc] init];
        lineLayer.frame = CGRectMake(0, 44, view.width, 1);
        lineLayer.backgroundColor = CORLOR_LINE.CGColor;
        [view.layer addSublayer:lineLayer];
        
        lineLayer = [[CALayer alloc] init];
        lineLayer.backgroundColor = CORLOR_LINE.CGColor;
        lineLayer.frame = CGRectMake(view.width-1, 0, 1, 45);
        [view.layer addSublayer:lineLayer];
    }
    
    if (model.productsDescArr.count>0) {
        self.detailBtn.height = 45*model.productsDescArr.count;
    }else{
        self.detailBtn.y = 0;
        self.detailBtn.height = 40;
    }
}

-(void)detailBtnClicked:(UIButton *)sender
{
    if (self.detailBtnClickDelegate && [self.detailBtnClickDelegate respondsToSelector:@selector(detailBtnClick)]) {
        [_detailBtnClickDelegate detailBtnClick];
    }
}
@end
