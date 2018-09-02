//
//  UIImage+CreateImage.h
//  WinShare
//
//  Created by GZH on 2017/5/3.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CreateImage)

//颜色转换成图片
+ (UIImage *)imageFromColor:(UIColor *)color;

//保证图片拉伸不变形
- (UIImage *)resizingImageState;

//根据字符串生成指定大小的二维码
+ (UIImage *)createQRCodeImageWithMessage:(NSString *)message size:(CGFloat)size;

//变成圆形图片
- (UIImage *)circleImage;

@end
