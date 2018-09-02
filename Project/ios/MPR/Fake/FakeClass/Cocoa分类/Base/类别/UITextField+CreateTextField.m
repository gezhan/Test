//
//  UITextField+CreateTextField.m
//  WinShare
//
//  Created by GZH on 2017/4/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "UITextField+CreateTextField.h"

@implementation UITextField (CreateTextField)

+ (UITextField *)Z_createTextFieldWithFrame:(CGRect)frame
                                 placeHodel:(NSString *)placeHodel
                                   textFont:(CGFloat)textFont
                                   colorStr:(NSString *)colorStr
                                  textClear:(BOOL)textClear
                                   aligment:(NSTextAlignment)aligment
                                  keyBoardType:(UIKeyboardType)keyBoardType
                                borderStyle:(UITextBorderStyle)borderStyle {
    
    UITextField *textField = [[UITextField alloc]init];
    textField.frame = frame;
    textField.placeholder = placeHodel;
    textField.font = [UIFont systemFontOfSize:textFont];
//    textField.textColor = [UIColor colorWithHexString:colorStr];
    textField.textAlignment = aligment;
    textField.keyboardType = keyBoardType;
    textField.borderStyle = borderStyle;
    
    if (textClear) {
        textField.clearButtonMode = UITextFieldViewModeAlways;
    }
    
    return textField;
}


@end
