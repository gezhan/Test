//
//  WSFSpaceIntroductionTextView.m
//  WinShare
//
//  Created by devRen on 2017/12/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFSpaceIntroductionTextView.h"
#import "UILabel+WSF_LineSpacing.h"
#import "WSFSpaceIntroductionViewModel.h"

@interface WSFSpaceIntroductionTextView ()

@property (nonatomic, strong) UILabel *timeLabel;       // 预定时间
@property (nonatomic, strong) UILabel *priceLabel;      // 单价
@property (nonatomic, strong) UILabel *durationLabel;   // 时长
@property (nonatomic, strong) UILabel *setMealLabel;    // 套餐

@end

@implementation WSFSpaceIntroductionTextView

- (instancetype)initWithIntroductionViewModel:(WSFSpaceIntroductionViewModel *)introductionViewModel {
    self = [super init];
    if (self) {
        self.backgroundColor = HEX_COLOR_0xF5F5F5;
        self.timeLabel.text = introductionViewModel.timeString;
        self.priceLabel.text = introductionViewModel.priceString;
        self.durationLabel.text = introductionViewModel.durationString;
        if (introductionViewModel.isHaveSetMeal) {
            [self.setMealLabel wsf_setText:introductionViewModel.setMealString lineSpacing:6];
            self.bottomLabel = self.setMealLabel;
        } else {
            self.bottomLabel = self.durationLabel;
        }
        
    }
    return self;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = SYSTEMFONT_14;
        _timeLabel.textColor = HEX_COLOR_0x1A1A1A;
        [self addSubview:self.timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self.mas_top).offset(-2);
        }];
    }
    return _timeLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = SYSTEMFONT_14;
        _priceLabel.textColor = HEX_COLOR_0x1A1A1A;
        [self addSubview:self.priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(8);
        }];
        
    }
    return _priceLabel;
}

- (UILabel *)durationLabel {
    if (!_durationLabel) {
        _durationLabel = [[UILabel alloc] init];
        _durationLabel.font = SYSTEMFONT_14;
        _durationLabel.textColor = HEX_COLOR_0x1A1A1A;
        [self addSubview:self.durationLabel];
        [_durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self.priceLabel.mas_bottom).offset(8);
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
        }];
    }
    return _setMealLabel;
}

@end
