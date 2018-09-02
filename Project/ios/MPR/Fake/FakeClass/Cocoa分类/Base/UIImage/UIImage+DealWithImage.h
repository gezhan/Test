//
//  UIImage+DealWithImage.h
//  WinShare
//
//  Created by GZH on 2017/7/14.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DealWithImage)

//加水印
+ (UIImage *)imageWithimage:(UIImage *)image content:(NSString *)content frame:(CGRect)frame;

@end
