//
//  UIFont+Font.m
//  WinShare
//
//  Created by GZH on 2017/5/26.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "UIFont+Font.h"
#import <objc/message.h>

@implementation UIFont (Font)

+ (void)load
{
    Method systimeFont = class_getClassMethod(self, @selector(systemFontOfSize:));
//    Method hs_systimeFont = class_getClassMethod(self, @selector(hs_systemFontOfSize:));

    method_exchangeImplementations(systimeFont, systimeFont);
}

+ (UIFont *)hs_systemFontOfSize:(CGFloat)pxSize{
    CGFloat pt = (pxSize/96)*72;
    UIFont *font = [UIFont hs_systemFontOfSize:pt];
    return font;
}

@end
