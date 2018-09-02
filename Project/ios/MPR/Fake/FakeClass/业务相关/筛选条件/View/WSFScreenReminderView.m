//
//  WSFScreenReminderView.m
//  WinShare
//
//  Created by devRen on 2017/11/17.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFScreenReminderView.h"

NSString * WSFScreenReminderViewResetButtonClickNotification = @"WSFScreenReminderViewResetButtonClickNotification";

@interface WSFScreenReminderView()

@property (nonatomic, strong) UILabel *reminderLabel;
@property (nonatomic, strong) UIButton *resetButton;

@end

@implementation WSFScreenReminderView

- (instancetype)initWithFrame:(CGRect)frame reminder:(NSString *)reminder{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HEXCOLOR(0x2B84C6, 0.6);
        self.resetButton.hidden = NO;
        self.reminderLabel.text = reminder;
        self.hidden = YES;
    }
    return self;
}

- (void)updateReminder:(NSString *)reminder {
    [self changeScreenReminderViewWithType:WSFScreenReminderViewType_Show];
    self.reminderLabel.text = reminder;
}

- (void)changeScreenReminderViewWithType:(WSFScreenReminderViewType)type {
    if (type == WSFScreenReminderViewType_Show) {
        self.hidden = NO;
    } else {
        self.hidden = YES;
    }
}

#pragma mark - 点击事件
- (void)resetButtonClick:(UIButton *)sender {
    self.hidden = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:WSFScreenReminderViewResetButtonClickNotification object:nil userInfo:nil];
}

#pragma mark - 懒加载
- (UILabel *)reminderLabel {
    if (!_reminderLabel) {
        _reminderLabel = [[UILabel alloc] init];
        _reminderLabel.textColor = [UIColor whiteColor];
        _reminderLabel.font = SYSTEMFONT_12;
        [self addSubview:_reminderLabel];
        [_reminderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).mas_offset(10);
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.resetButton.mas_left).mas_offset(-15);
        }];
    }
    return _reminderLabel;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        _resetButton = [[UIButton alloc] init];
        [_resetButton.layer setCornerRadius:5];
        _resetButton.layer.masksToBounds = YES;
        [_resetButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_resetButton.layer setBorderWidth:1.0];
        [_resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_resetButton setTitle:@"重置" forState:UIControlStateNormal];
        _resetButton.titleLabel.font = SYSTEMFONT_12;
        [_resetButton addTarget:self action:@selector(resetButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_resetButton];
        [_resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).mas_offset(-10);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(@21);
            make.width.equalTo(@40);
        }];
    }
    return _resetButton;
}

@end
