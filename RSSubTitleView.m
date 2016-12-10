//
//  RSSubTitleView.m
//  RedScarf
//
//  Created by lishipeng on 15/12/30.
//  Copyright © 2015年 zhangb. All rights reserved.
//

#import "RSSubTitleView.h"

@implementation RSSubTitleView
-(instancetype) init
{
    self = [super init];
    if(self) {
        [self addSubview:self.image];
        self.normalColor =RS_COLOR_NUMLABEL;
        self.highlightColor = CORLOR_THEME;
        self.titleLabel.font = RS_FONT_14;
    }
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self addSubview:self.image];
        self.normalColor = RS_COLOR_NUMLABEL;
        self.highlightColor = CORLOR_THEME;
        self.titleLabel.font = RS_FONT_14;
    }
    return self;
}

-(void) setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    [self setTitleColor:_normalColor forState:UIControlStateNormal];
    if(!self.selected) {
        self.image.backgroundColor = [UIColor clearColor];
    }
}

-(UIImageView *) image
{
    if(_image) {
        return _image;
    }
    _image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 3)];
    _image.bottom = self.height;
    return _image;
}

-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.image.bottom = self.height;
    self.image.width = self.width;
}

-(void) setHighlightColor:(UIColor *)highlightColor
{
    _highlightColor = highlightColor;
    [self setTitleColor:_highlightColor forState:UIControlStateSelected];
    if(self.selected) {
        self.imageView.backgroundColor = _highlightColor;
    }
}

-(void) setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if(!self.selected) {
        self.image.backgroundColor = [UIColor clearColor];
    } else {
        self.image.backgroundColor = self.highlightColor;
    }
}

@end

@implementation RSSubButtonView

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self addSubview:self.nameLabel];
    }
    return self;
}

-(UILabel *)nameLabel{
    if (_nameLabel) {
        return _nameLabel;
    }
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.width-20, 21)];
    _nameLabel.layer.cornerRadius = 10;
    _nameLabel.layer.masksToBounds = YES;
    _nameLabel.font = Font(13);
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    return _nameLabel;
}


-(void) setSelected:(BOOL)selected
{
    _selected = selected;
    if(!self.selected) {
        self.nameLabel.backgroundColor = COLOR_CLEAR;
        self.nameLabel.textColor = CORLOR_222222;
    } else {
        self.nameLabel.backgroundColor = CORLOR_THEME;
        self.nameLabel.textColor = [UIColor whiteColor];
    }
}
@end
