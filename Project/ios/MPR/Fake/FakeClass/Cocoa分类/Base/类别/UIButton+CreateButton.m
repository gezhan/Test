//
//  UIButton+CreateButton.m
//  WinShare
//
//  Created by GZH on 2017/4/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "UIButton+CreateButton.h"

@implementation UIButton (CreateButton)


+ (UIButton *)Z_createButtonWithTitle:(NSString *)title
                          buttonFrame:(CGRect)frame
                            layerMask:(BOOL)mask
                             textFont:(CGFloat)font
                             colorStr:(NSString *)colorStr
                         cornerRadius:(CGFloat)cornerRadius {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setFrame:frame];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.backgroundColor = [UIColor colorWithHexString:colorStr];
    
//    button.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [button setTitleColor:[UIColor colorWithHexString:colorStr] forState:UIControlStateNormal];
    
    if (mask) {
        button.layer.cornerRadius = cornerRadius;
        button.layer.masksToBounds = YES;
    }
    
    return button;
}


@end
