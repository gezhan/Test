//
//  WSFBaseViewController.h
//  WinShare
//
//  Created by QIjikj on 2018/1/25.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSFBaseViewController : UIViewController

@property (nonatomic, strong) UIAlertController *alertVC;           //提示没有开启定位

//如果为YES，则模态返回；若果为NO，则通过导航控制器返回
@property (assign, nonatomic) BOOL dismiss;

//如果为YES，则模态返回；若果为NO，则通过导航控制器返回
- (void)doBackAction;

@end
