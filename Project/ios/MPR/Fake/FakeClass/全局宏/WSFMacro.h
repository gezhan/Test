//
//  WSFMacro.h
//  WinShare
//
//  Created by QIjikj on 2017/11/27.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#ifndef WSFMacro_h
#define WSFMacro_h


#pragma mark - 屏幕宽高
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define isPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#pragma mark - UIApplication
#define kAppDelegate ([[UIApplication sharedApplication] delegate])
#define kAppWindow (kAppDelegate.window)



#pragma mark - RGB颜色
///------ 10进制 ------
#define RGBA(r, g, b, a) ([UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:a])
///------ 16进制 ------
#define HEXCOLOR(hex, a) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:a]
///------ 随机颜色 ------
#define RandomColor ([UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1])
///------ APP中常用颜色 ------
#define HEX_COLOR_0xE6E6E6 HEXCOLOR(0xE6E6E6, 1)// 灰色
#define HEX_COLOR_0xFF3142 HEXCOLOR(0xFF3142, 1)// 红色
#define HEX_COLOR_0x1A1A1A HEXCOLOR(0x1A1A1A, 1)// 正文黑色
#define HEX_COLOR_0x808080 HEXCOLOR(0x808080, 1)// 副文深灰色
#define HEX_COLOR_0xEFEFF4 HEXCOLOR(0xEFEFF4, 1)// 副标题的灰色
#define HEX_COLOR_0xCCCCCC HEXCOLOR(0xCCCCCC, 1)// 不可点击的灰色
#define HEX_COLOR_0x2B84C6 HEXCOLOR(0x2B84C6, 1)// 项目主题蓝色
#define HEX_COLOR_0xF5F5F5 HEXCOLOR(0xF5F5F5, 1)// 灰色
#define HEX_COLOR_0x333333 HEXCOLOR(0x333333, 1)// 浅黑色
#define HEX_COLOR_0xFF5959 HEXCOLOR(0xFF5959, 1)// 红色
#define HEX_COLOR_0xE5E5E5 HEXCOLOR(0xE5E5E5, 1)// 浅白色



#pragma mark - 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)    [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)        [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)        [UIFont fontWithName:(NAME) size:(FONTSIZE)]
///------ 系统默认10～20号字体 ------
#define SYSTEMFONT_10 SYSTEMFONT(10)
#define SYSTEMFONT_11 SYSTEMFONT(11)
#define SYSTEMFONT_12 SYSTEMFONT(12)
#define SYSTEMFONT_13 SYSTEMFONT(13)
#define SYSTEMFONT_14 SYSTEMFONT(14)
#define SYSTEMFONT_15 SYSTEMFONT(15)
#define SYSTEMFONT_16 SYSTEMFONT(16)
#define SYSTEMFONT_17 SYSTEMFONT(17)
#define SYSTEMFONT_18 SYSTEMFONT(18)
#define SYSTEMFONT_19 SYSTEMFONT(19)
#define SYSTEMFONT_20 SYSTEMFONT(20)




#pragma mark - 内联函数
#define RYJKIT_STATIC_INLINE static inline



#pragma mark - 沙河路经
#define PathUserDefaults    [NSUserDefaults standardUserDefaults]
#define PathTemp            NSTemporaryDirectory()
#define PathDocument        [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PathCache           [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/** 用户的基本信息路径 */
#define UserBaseInfoPath [NSString stringWithFormat:@"%@/UserBaseInfo",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]]




#endif /* WSFMacro_h */



