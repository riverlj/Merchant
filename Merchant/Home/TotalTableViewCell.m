//
//  TotalTableViewCell.m
//  Merchant
//
//  Created by 李江 on 16/12/3.
//  Copyright © 2016年 riverli. All rights reserved.
//

#import "TotalTableViewCell.h"

@implementation TotalTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.mainTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH, 20)];
        self.mainTitle.textColor = CORLOR_000000;
        self.mainTitle.font = RS_FONT_14;
        [self.contentView addSubview:self.mainTitle];
        
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH, 20)];
        self.timeLabel.textColor = CORLOR_000000;
        self.timeLabel.font = RS_FONT_14;
        [self.contentView addSubview:self.timeLabel];
        
        self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-60, 0, 60, 70)];
        [self.numLabel setTextAlignment:NSTextAlignmentRight];
        self.numLabel.textColor = CORLOR_F3A619;
        self.numLabel.font = RS_BOLDFONT_20;;
        [self.contentView addSubview:self.numLabel];
        
        self.numLabel.centerY = 35;
    }
    
    return self;
}

@end
