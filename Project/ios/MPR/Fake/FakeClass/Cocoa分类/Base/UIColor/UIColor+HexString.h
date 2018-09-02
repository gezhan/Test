//
//  UIColor+HexString.h
//  WinShare
//
//  Created by GZH on 2017/4/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

+ (UIColor*) colorWithHexString:(NSString*)color;

+ (UIColor*) colorWithHexString:(NSString*)color alpha:(CGFloat)alpha;

@end
