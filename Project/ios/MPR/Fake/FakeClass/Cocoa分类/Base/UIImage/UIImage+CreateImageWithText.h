//
//  UIImage+CreateImageWithText.h
//  XiaoYing
//
//  Created by GZH on 2017/7/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CreateImageWithText)

// 1.将文字添加到图片上;imageName 图片名字， text 需画的字体
+ (UIImage *)createShareImage:(UIImage *)tImage Context:(NSString *)text textColor:(UIColor *)color;

@end
