//
//  WSFFieldIntroductionTextView.m
//  WinShare
//
//  Created by QIjikj on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldIntroductionTextView.h"
#import "WSFFieldIntroductionVM.h"

@interface WSFFieldIntroductionTextView ()
@property (nonatomic, strong) UILabel *timeLabel;       // 使用时间
@property (nonatomic, strong) UILabel *durationLabel;   // 场次
@property (nonatomic, strong) UILabel *setMealLabel;    // 套餐
@end

@implementation WSFFieldIntroductionTextView

- (instancetype)initWithPlaygroundIntroductionVM:(WSFFieldIntroductionVM *)playgroundIntroductionVM {
    if (self = [super init]) {
        self.backgroundColor = HEX_COLOR_0xF5F5F5;
        self.timeLabel.text = playgroundIntroductionVM.timeString;
        self.durationLabel.text = playgroundIntroductionVM.durationString;
        self.setMealLabel.text = playgroundIntroductionVM.setMealString;
    }
    return self;
}

#pragma mark - 懒加载
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = SYSTEMFONT_14;
        _timeLabel.textColor = HEX_COLOR_0x1A1A1A;
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(-2);
        }];
    }
    return _timeLabel;
}

- (UILabel *)durationLabel {
    if (!_durationLabel) {
        _durationLabel = [[UILabel alloc] init];
        _durationLabel.font = SYSTEMFONT_14;
        _durationLabel.textColor = HEX_COLOR_0x1A1A1A;
        [self addSubview:self.durationLabel];
        [_durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(8);
        }];
    }
    return _durationLabel;
}

- (UILabel *)setMealLabel {
    if (!_setMealLabel) {
        _setMealLabel = [[UILabel alloc] init];
        _setMealLabel.font = SYSTEMFONT_14;
        _setMealLabel.textColor = HEX_COLOR_0x1A1A1A;
        _setMealLabel.numberOfLines = 3;
        [self addSubview:_setMealLabel];
        [_setMealLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self.durationLabel.mas_bottom).offset(8);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
    }
    return _setMealLabel;
}

@end
