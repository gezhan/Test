//
//  UILabel+CreateLabel.m
//  WinShare
//
//  Created by GZH on 2017/4/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "UILabel+CreateLabel.h"

@implementation UILabel (CreateLabel)

+ (UILabel *)Z_createLabelWithFrame:(CGRect)frame
                              title:(NSString *)title
                           textFont:(CGFloat)font
                           colorStr:(NSString *)colorStr
                           aligment:(NSTextAlignment)aligment
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = [UIColor colorWithHexString:colorStr];
    label.textAlignment = aligment;
    return label;
}



@end
