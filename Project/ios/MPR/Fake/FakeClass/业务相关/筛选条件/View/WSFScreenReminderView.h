//
//  WSFScreenReminderView.h
//  WinShare
//
//  Created by devRen on 2017/11/17.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WSFScreenReminderViewType) {
    WSFScreenReminderViewType_Show,     // 显示
    WSFScreenReminderViewType_Hidden    // 隐藏
};

@interface WSFScreenReminderView : UIView

/**
 初始化方法

 @param frame frame
 @param reminder 提示信息
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame reminder:(NSString *)reminder;

/**
 更新提示信息

 @param reminder 提示信息
 */
- (void)updateReminder:(NSString *)reminder;

/**
 更新显示状态

 @param type 显示状态
 */
- (void)changeScreenReminderViewWithType:(WSFScreenReminderViewType)type;

// 点击重置按钮通知
FOUNDATION_EXPORT NSString * WSFScreenReminderViewResetButtonClickNotification;

@end
