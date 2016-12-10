//
//  Theme.h
//  Merchant
//
//  Created by 李江 on 16/11/29.
//  Copyright © 2016年 riverli. All rights reserved.
//

#ifndef Theme_h
#define Theme_h

//高度----------start
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define TABBARHEIGHT  64
//高度----------end

// 颜色---------start
#define UIColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGB(r, g, b) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1.0f]
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:(a)]

#define CORLOR_THEME UIColorFromHex(0x09C7CA)
#define CORLOR_BACKGROUND RGB(245,245,245)
#define COLOR_CLEAR [UIColor clearColor]
#define CORLOR_222222 UIColorFromHex(0x222222)
#define CORLOR_000000 UIColorFromHex(0x000000)
#define CORLOR_7d7d7d UIColorFromHex(0x7d7d7d)
#define CORLOR_F3A619 UIColorFromHex(0xF3A619)
#define RS_COLOR_NUMLABEL  UIColorFromHex(0x666666)
#define CORLOR_LINE  RGBA(238,238,238,1)

// 颜色---------end


// 字体---------start
#define Font(x) [UIFont systemFontOfSize:x]
#define BoldFont(x) [UIFont boldSystemFontOfSize:x]

#define RS_FONT_10 Font(10)
#define RS_FONT_11 Font(11)
#define RS_FONT_12 Font(12)
#define RS_FONT_13 Font(13)
#define RS_FONT_14 Font(14)
#define RS_FONT_15 Font(15)
#define RS_FONT_16 Font(16)
#define RS_FONT_17 Font(17)
#define RS_FONT_18 Font(18)
#define RS_FONT_19 Font(19)
#define RS_FONT_20 Font(20)
#define RS_FONT_21 Font(21)

#define RS_BOLDFONT_10 BoldFont(10)
#define RS_BOLDFONT_11 BoldFont(11)
#define RS_BOLDFONT_12 BoldFont(12)
#define RS_BOLDFONT_13 BoldFont(13)
#define RS_BOLDFONT_14 BoldFont(14)
#define RS_BOLDFONT_15 BoldFont(15)
#define RS_BOLDFONT_16 BoldFont(16)
#define RS_BOLDFONT_17 BoldFont(17)
#define RS_BOLDFONT_18 BoldFont(18)
#define RS_BOLDFONT_19 BoldFont(19)
#define RS_BOLDFONT_20 BoldFont(20)
#define RS_BOLDFONT_21 BoldFont(21)
// 字体---------end

#endif /* Theme_h */
