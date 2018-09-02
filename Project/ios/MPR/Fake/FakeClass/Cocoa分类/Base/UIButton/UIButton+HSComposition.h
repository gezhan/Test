//
//  UIButton+HSComposition.h
//  WinShare
//
//  Created by GZH on 2017/8/23.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HSButtonEdgeInsetsStyle) {
    HSButtonEdgeInsetsStyleTop,     // image在上，label在下
    HSButtonEdgeInsetsStyleLeft,    // image在左，label在右
    HSButtonEdgeInsetsStyleBottom,  // image在下，label在上
    HSButtonEdgeInsetsStyleRight    // image在右，label在左
};

@interface UIButton (HSComposition)

/** 
 * 设置button的titleLabel和imageView的布局样式，及间距 
 * @param style titleLabel和imageView的布局样式 
 * @param space titleLabel和imageView的间距 
 */
- (void)layoutButtonWithEdgeInsetsStyle:(HSButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

@end
