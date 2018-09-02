//
//  UINavigationController+HSMViewController.h
//  WinShare
//
//  Created by GZH on 2017/10/17.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (HSMViewController)


/**
 根据VC的名字获取在栈中的控制器对象
 */
- (UIViewController *)hsm_viewControllerBaseOnClassName:(NSString *)className;

@end
