//
//  UIButton+WSF_ContentVertical.h
//  WinShare
//
//  Created by GZH on 2017/12/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WSF_ContentVertical)

//竖排，图片在上，文字在下
- (void)wsf_verticalImageAndTitleWithSpacing:(CGFloat)spacing;

//横排，图片在右，文字在左
- (void)wsf_horizontalTitleAndImageWithSpacing:(CGFloat)spacing;

//横排，图片在左，文字在右
- (void)wsf_horizontalImageAndTitleWithSpacing:(CGFloat)spacing;

@end
