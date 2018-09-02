//
//  UIView+ShowMessageView.h
//  WinShare
//
//  Created by GZH on 2017/5/25.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ShowMessageView)

- (UIView *)viewDisplayNotFoundViewWithNetworkLoss:(BOOL)networkLoss withImageName:(NSString *)imageName clickString:(NSString *)clickString clickBlock:(void(^)())block;

@end
