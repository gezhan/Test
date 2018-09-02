//
//  UIImageView+CreateImage.m
//  WinShare
//
//  Created by GZH on 2017/4/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "UIImageView+CreateImage.h"

@implementation UIImageView (CreateImage)

+ (UIImageView *)Z_createImageViewWithFrame:(CGRect)frame
                                      image:(NSString *)imageName
                                  layerMask:(BOOL)mask
                               cornerRadius:(CGFloat)cornerRadius {
    
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.image = [UIImage imageNamed:imageName];
    imageview.frame = frame;
    
    if (mask) {
        imageview.layer.cornerRadius = cornerRadius;
        imageview.layer.masksToBounds = YES;
    }
    
    
    return imageview;
    
}




@end
