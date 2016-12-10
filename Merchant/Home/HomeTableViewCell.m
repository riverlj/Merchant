//
//  HomeTableViewCell.m
//  Merchant
//
//  Created by 李江 on 16/12/3.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "UIView+CustomFrame.h"

@implementation HomeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];

    if (self) {
        self.foodtypeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(34, 30, 60, 60)];
        self.foodtypeImageView.layer.cornerRadius = 30;
        self.foodtypeImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.foodtypeImageView];
        
        self.foodNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.foodtypeImageView.right + 10, 0, SCREEN_WIDTH-(self.foodtypeImageView.right + 10), 30)];
        self.foodNameLabel.font = RS_FONT_16;
        self.foodNameLabel.textColor = CORLOR_222222;
        [self.contentView addSubview:self.foodNameLabel];
        
        self.foodNameLabel.centerY=self.foodtypeImageView.centerY;
    }
    
    return self;
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;//这里间距为10，可以根据自己的情况调整
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= frame.origin.x;
    [super setFrame:frame];
}

@end
