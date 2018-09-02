//
//  UIButton+WSF_ContentVertical.m
//  WinShare
//
//  Created by GZH on 2017/12/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "UIButton+WSF_ContentVertical.h"

@implementation UIButton (WSF_ContentVertical)

//竖排，图片在上，文字在下
- (void)wsf_verticalImageAndTitleWithSpacing:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}


//横排，图片在右，文字在左
- (void)wsf_horizontalTitleAndImageWithSpacing:(CGFloat)spacing{
    
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width+spacing), 0, imageSize.width);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width, 0, -titleSize.width);
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

//横排，图片在左，文字在又
- (void)wsf_horizontalImageAndTitleWithSpacing:(CGFloat)spacing{
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

@end
