//
//  UIButton+CreateButton.h
//  WinShare
//
//  Created by GZH on 2017/4/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CreateButton)

+ (UIButton *)Z_createButtonWithTitle:(NSString *)title
                          buttonFrame:(CGRect)frame
                            layerMask:(BOOL)mask
                             textFont:(CGFloat)font
                             colorStr:(NSString *)colorStr
                         cornerRadius:(CGFloat)cornerRadius;

@end
