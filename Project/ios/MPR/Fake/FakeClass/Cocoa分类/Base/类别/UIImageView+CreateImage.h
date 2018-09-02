//
//  UIImageView+CreateImage.h
//  WinShare
//
//  Created by GZH on 2017/4/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CreateImage)

+ (UIImageView *)Z_createImageViewWithFrame:(CGRect)frame
                                      image:(NSString *)imageName
                                  layerMask:(BOOL)mask
                               cornerRadius:(CGFloat)cornerRadius;

@end
