//
//  WSFButton+HSF_Composition.h
//  WinShare
//
//  Created by QIjikj on 2017/12/21.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFButton.h"

typedef NS_ENUM(NSUInteger, WSFButtonEdgeInsetsType){
    WSFButtonEdgeInsetsType_ImageTop,       // image在上，label在下
    WSFButtonEdgeInsetsType_ImageLeft,      // image在左，label在右
    WSFButtonEdgeInsetsType_ImageBottom,    // image在下，label在上
    WSFButtonEdgeInsetsType_ImageRight      // image在右，label在左
};

@interface WSFButton (HSF_Composition)

/**
 * 根据按钮中的现有内容，设置button的titleLabel和imageView的布局样式，及间距
 * @param style titleLabel和imageView的布局样式
 * @param space titleLabel和imageView的间距
 * ⚠️如果对图片或者文字进行更换后，必须再次调用此方法。
 */
- (void)hsf_layoutButtonWithEdgeInsetsStyle:(WSFButtonEdgeInsetsType)style imageTitleSpace:(CGFloat)space;

@end
