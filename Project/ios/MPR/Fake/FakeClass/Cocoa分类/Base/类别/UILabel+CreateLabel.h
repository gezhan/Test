//
//  UILabel+CreateLabel.h
//  WinShare
//
//  Created by GZH on 2017/4/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CreateLabel)

+ (UILabel *)Z_createLabelWithFrame:(CGRect)frame
                              title:(NSString *)title
                           textFont:(CGFloat)font
                           colorStr:(NSString *)colorStr
                           aligment:(NSTextAlignment)aligment;

@end
