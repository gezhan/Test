//
//  UIViewController+WSFTopViewController.h
//  WinShare
//
//  Created by GZH on 2017/11/22.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WSFTopViewController)

/**  当前最上层的视图控制器 */
+ (UIViewController *)wsf_topViewControlle;
/**  当前最上层的导航控制器  */
+ (UINavigationController *)wsf_navigationController;

@end
