//
//  OrderInfoTableViewCell.m
//  Merchant
//
//  Created by 李江 on 16/12/3.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "OrderInfoTableViewCell.h"
#import "AllModelDetail.h"
#import "OrderlistModel.h"

@implementation TwoLabelView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftLabel = [self creatLabel];
        self.leftLabel.textAlignment = NSTextAlignmentLeft;
        self.leftLabel.x = 15;
        self.rightLabel = [self creatLabel];
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightLabel];
        
        CALayer *lineLayer = [[CALayer alloc] init];
        lineLayer.frame = CGRectMake(0, self.height-1, self.width, 1);
        lineLayer.backgroundColor = CORLOR_LINE.CGColor;
        [self.layer addSublayer:lineLayer];
    }
    return self;
}

-(UILabel *)creatLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.y = 0;
    label.height = 45;
    label.textColor = CORLOR_222222;
    label.font = RS_FONT_14;
    return label;
}

@end

@interface OrderInfoTableViewCell()
{
    OrderModel *_orderModel;
}

@end
@implementation OrderInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view.backgroundColor = CORLOR_BACKGROUND;
        [self.contentView addSubview:view];

        self.headerView = [[TwoLabelView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 40)];
        [self.contentView addSubview:self.headerView];
        
        self.userNameView = [[TwoLabelView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [self.contentView addSubview:self.userNameView];
        
        self.cellView = [[TwoLabelView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [self.contentView addSubview:self.cellView];
        
        self.orderAddressView = [[TwoLabelView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [self.contentView addSubview:self.orderAddressView];
        
        self.orderNumView = [[TwoLabelView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [self.contentView addSubview:self.orderNumView];
        
        self.printButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.printButton.frame = CGRectMake(SCREEN_WIDTH-114-15, 0, 114, 26);
        [self.printButton setTitle:@"打印订单" forState:UIControlStateNormal];
        [self.printButton setTitle:@"打印订单" forState:UIControlStateHighlighted];
        [self.printButton setTitleColor:CORLOR_THEME forState:UIControlStateNormal];
        [self.printButton setTitleColor:CORLOR_THEME forState:UIControlStateHighlighted];
        self.printButton.titleLabel.font = RS_FONT_12;
        self.printButton.layer.borderWidth = 1;
        self.printButton.layer.borderColor = CORLOR_THEME.CGColor;
        self.printButton.layer.cornerRadius = 4;
        self.printButton.layer.masksToBounds = YES;
        [self.contentView addSubview:self.printButton];
        
        [self.printButton addTarget:self action:@selector(printButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)setModels:(OrderModel *)model
{
    _orderModel = model;
    
    self.headerView.leftLabel.text = [NSString stringWithFormat:@"#%@",model.seq];
    self.headerView.leftLabel.textColor = [UIColor redColor];
    self.headerView.leftLabel.x = 15;
    self.headerView.leftLabel.width = 30;
    self.headerView.rightLabel.text = model.ordertime;
    self.headerView.leftLabel.textColor = CORLOR_7d7d7d;
    self.headerView.rightLabel.x = 45;
    self.headerView.rightLabel.width = SCREEN_WIDTH-45-15;
    
    CGFloat y = 40;
    
    for (int i=0; i<model.dashes.count; i++) {
        ProductsDesc *pmodel = model.dashes[i];
        TwoLabelView *foodLabel = [[TwoLabelView alloc] initWithFrame:CGRectMake(0, y, SCREEN_WIDTH, 45)];
        foodLabel.leftLabel.text = pmodel.name;
        foodLabel.leftLabel.width = 250;
        foodLabel.rightLabel.text = [NSString stringWithFormat:@"%@个",pmodel.num];
        foodLabel.rightLabel.x = 265;
        foodLabel.rightLabel.width = SCREEN_WIDTH - 265-15;
        
        [self.contentView addSubview:foodLabel];
        y+=45;
    }

    self.userNameView.leftLabel.text = @"用户名";
    self.userNameView.rightLabel.text = model.username;
    self.userNameView.leftLabel.width = 100;
    self.userNameView.rightLabel.x = 115;
    self.userNameView.rightLabel.width = SCREEN_WIDTH-130;
    self.userNameView.y = y;
    y+=45;
    
    
    self.cellView.leftLabel.text = @"手机号";
    self.cellView.rightLabel.text = model.mobile;
    self.cellView.leftLabel.width = 100;
    self.cellView.rightLabel.x = 115;
    self.cellView.rightLabel.width = SCREEN_WIDTH-130;
    self.cellView.y = y;
    y+=45;
    
    self.orderAddressView.leftLabel.text = @"送餐地址";
    self.orderAddressView.rightLabel.text = model.address;
    self.orderAddressView.leftLabel.width = 100;
    self.orderAddressView.rightLabel.x = 115;
    self.orderAddressView.rightLabel.width = SCREEN_WIDTH-130;
    self.orderAddressView.rightLabel.numberOfLines = 0;
    self.orderAddressView.y = y;
    y+=45;
    
    self.orderNumView.leftLabel.text = @"订单编号";
    self.orderNumView.rightLabel.text = model.orderid;
    self.orderNumView.leftLabel.width = 100;
    self.orderNumView.rightLabel.x = 115;
    self.orderNumView.rightLabel.width = SCREEN_WIDTH-130;

    self.orderNumView.y = y;
    y+=45;
    
    self.printButton.y = y + 12;
    
    if (model.printed) {
        [self.printButton setTitleColor:CORLOR_7d7d7d forState:UIControlStateNormal];
        [self.printButton setTitleColor:CORLOR_7d7d7d forState:UIControlStateHighlighted];
        self.printButton.layer.borderColor = CORLOR_7d7d7d.CGColor;
        [self.printButton setTitle:@"已打印" forState:UIControlStateNormal];
        [self.printButton setTitle:@"已打印" forState:UIControlStateHighlighted];
        
    }
}

-(void)printButtonClicked
{
    if (self.printBtnClickDelegate && [self.printBtnClickDelegate respondsToSelector:@selector(printBtnClick:)]) {
        [self.printBtnClickDelegate printBtnClick:_orderModel];
    }
}



-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

@end
