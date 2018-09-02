//
//  HSMathod.h
//  WinShare
//
//  Created by GZH on 2017/5/5.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MBProgressHUD;

/** 通过字号得到该种字体的高度 */
#define HeightForFontSize(x) [HSMathod getHeightForTextNum:1 limitWidth:100 fontSize:(x)]

@interface HSMathod : NSObject

//获取当前屏幕显示的viewController对象，不需要任何参数
+ (UIViewController *)getCurrentViewController;

//通过字符串、限定的文本宽，得到文本高
+ (CGFloat)getHightForText:(NSString *)textStr limitWidth:(CGFloat)limitWidth fontSize:(CGFloat)fontSize;

//通过字符串、限定的文本高，得到文本宽
+ (CGFloat)getWidthForText:(NSString *)textStr limitHight:(CGFloat)limitHight fontSize:(CGFloat)fontSize;

//通过字符串、字体大小，得到单行文本的size
+ (CGSize)getSizeForText:(NSString *)textStr fontSize:(CGFloat)fontSize;

//通过字数、限定的文本宽、字体，得到文本高
+ (CGFloat)getHeightForTextNum:(NSInteger)num limitWidth:(CGFloat)limitWidth fontSize:(CGFloat)fontSize;

//颜色转换成图片
+ (UIImage *)imageWithColor:(UIColor *)color;

//显示一个等待加载的Gif图片，并返回该view
+ (UIView *)showLoadingGifToView:(UIView *)view;

//WS项目中加载中的GIF
+ (MBProgressHUD *)showLoading:(UIView *)view title:(NSString *)title;

//判断是否IPv6环境并解析域名获得了IP地址
+ (NSString *)getIPWithHostName:(const NSString *)hostName;


/**
 拨打电话
 @param telephoneNumber 电话号码
 */
+ (void)callPhoneWithNumber:(NSString *)telephoneNumber;

@end
