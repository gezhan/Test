//
//  UINavigationController+HSMViewController.m
//  WinShare
//
//  Created by GZH on 2017/10/17.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "UINavigationController+HSMViewController.h"

@implementation UINavigationController (HSMViewController)

- (UIViewController *)hsm_viewControllerBaseOnClassName:(NSString *)className
{
    UIViewController *resultVC = nil;
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isKindOfClass:[NSClassFromString(className) class]]) {
            resultVC = vc;
        }
    }
    return resultVC;
}

@end
