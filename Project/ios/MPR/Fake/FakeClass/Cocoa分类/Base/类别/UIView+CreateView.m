//
//  UIView+CreateView.m
//  WinShare
//
//  Created by GZH on 2017/4/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "UIView+CreateView.h"

@implementation UIView (CreateView)

+ (UIView *)Z_createViewWithFrame:(CGRect)frame
                           colorStr:(NSString *)colorStr {
    
    UIView *view = [[UIView alloc]init];
    view.frame = frame;
    view.backgroundColor = [UIColor colorWithHexString:colorStr];
    
    
    return view;
}


@end
