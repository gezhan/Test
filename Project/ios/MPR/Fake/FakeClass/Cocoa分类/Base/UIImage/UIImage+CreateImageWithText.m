//
//  UIImage+CreateImageWithText.m
//  XiaoYing
//
//  Created by GZH on 2017/7/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "UIImage+CreateImageWithText.h"

@implementation UIImage (CreateImageWithText)

+ (UIImage *)createShareImage:(UIImage *)tImage Context:(NSString *)text textColor:(UIColor *)color {
    
    UIImage *sourceImage = tImage;
    CGSize imageSize; //画的背景 大小
    imageSize = [sourceImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    //获得 图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextDrawPath(context, kCGPathStroke);
    //字体大小
    CGFloat nameFont = 16;
    NSDictionary* attributes = @{
                                 NSForegroundColorAttributeName:color,//设置文字颜色
                                 NSFontAttributeName:[UIFont systemFontOfSize:nameFont],//设置文字的字体
                                 };
    CGRect sizeToFit = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, nameFont) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"#f99740"].CGColor);
    [text drawAtPoint:CGPointMake((imageSize.width-sizeToFit.size.width)/2 ,2) withAttributes:attributes];
    
//    NSLog(@"图片: %f %f",imageSize.width,imageSize.height);
//    NSLog(@"sizeToFit: %f %f",sizeToFit.size.width,sizeToFit.size.height);
    //返回绘制的新图形
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    return newImage;
}



@end
