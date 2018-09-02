//
//  UIView+GetCurrentVC.m
//  WinShare
//
//  Created by GZH on 2017/4/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "UIView+GetCurrentVC.h"

@implementation UIView (GetCurrentVC)

- (UIViewController *)viewController
{
    UIResponder *responder = self.nextResponder;
    while (![responder isKindOfClass:[UIViewController class]] && responder != nil) {
        responder = responder.nextResponder;
    }
    return (UIViewController *)responder;
}

@end
