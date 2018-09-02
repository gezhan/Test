//
//  UIView+ViewFrameGeometry.m
//  WinShare
//
//  Created by Gzh on 2017/4/30.
//

#import "HSBlockButton.h"

@implementation HSBlockButton

- (void)addTouchUpInsideBlock:(ButtonBlock)block
{
    _block = block;
    [self addTarget:self action:@selector(buttonTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonTouchUpInsideAction:(UIButton *)button
{
    _block(button);
}

@end
