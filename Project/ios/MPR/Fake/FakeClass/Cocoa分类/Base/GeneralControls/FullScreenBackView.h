//
//  FullScreenBackView.h
//  WinShare
//
//  Created by GZH on 2017/5/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFBaseViewController.h"

@interface FullScreenBackView : WSFBaseViewController

@property (nonatomic, strong) UIView *showView;
@property (nonatomic, assign, getter=isShowCloseSymbol) BOOL showCloseSymbol;//是否显示右上角的关闭按钮

@end
