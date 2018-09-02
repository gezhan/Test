//
//  UITextField+CreateTextField.h
//  WinShare
//
//  Created by GZH on 2017/4/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CreateTextField)


+ (UITextField *)Z_createTextFieldWithFrame:(CGRect)frame
                                 placeHodel:(NSString *)placeHodel
                                   textFont:(CGFloat)textFont
                                   colorStr:(NSString *)colorStr
                                  textClear:(BOOL)textClear
                                   aligment:(NSTextAlignment)aligment
                               keyBoardType:(UIKeyboardType)keyBoardType
                                borderStyle:(UITextBorderStyle)borderStyle;

@end
