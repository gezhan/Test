//
//  UIViewController+WSFTopViewController.m
//  WinShare
//
//  Created by GZH on 2017/11/22.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "UIViewController+WSFTopViewController.h"

@implementation UIViewController (WSFTopViewController)


+ (UIViewController *)wsf_topViewControlle {
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController)
    {
        vc = vc.presentedViewController;
        
        if ([vc isKindOfClass:[UINavigationController class]])
        {
            vc = [(UINavigationController *)vc visibleViewController];
        }
        else if ([vc isKindOfClass:[UITabBarController class]])
        {
            vc = [(UITabBarController *)vc selectedViewController];
        }
    }
    return vc;
}

+ (UINavigationController *)wsf_navigationController {
    return [self wsf_topViewControlle].navigationController;
}


@end
