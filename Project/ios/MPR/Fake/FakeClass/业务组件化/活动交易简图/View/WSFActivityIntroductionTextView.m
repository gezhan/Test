//
//  WSFActivityIntroductionTextView.m
//  WinShare
//
//  Created by ZWL on 2018/3/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityIntroductionTextView.h"

@interface WSFActivityIntroductionTextView ()

@property (nonatomic, strong) UILabel *nameLabel;   // 活动名称
@property (nonatomic, strong) UILabel *timeLabel;   // 活动时间
@property (nonatomic, strong) UILabel *addressLabel;// 活动地址

@end

@implementation WSFActivityIntroductionTextView

- (instancetype)initWithActivityIntroductionVM:(WSFActivityDetailIntroductionVM *)activityIntroductionVM {
    if (self = [super init]) {
        self.backgroundColor = HEX_COLOR_0xF5F5F5;
        self.nameLabel.text = activityIntroductionVM.nameString;
        self.timeLabel.text = activityIntroductionVM.timeString;
        self.addressLabel.text = activityIntroductionVM.addressString;
    }
    return self;
}

#pragma mark - 懒加载
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = SYSTEMFONT_14;
        _nameLabel.textColor = HEX_COLOR_0x1A1A1A;
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self).offset(-2);
        }];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = SYSTEMFONT_14;
        _timeLabel.textColor = HEX_COLOR_0x1A1A1A;
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(8);
        }];
    }
    return _timeLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = SYSTEMFONT_14;
        _addressLabel.textColor = HEX_COLOR_0x1A1A1A;
        _addressLabel.numberOfLines = 3;
        [self addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(8);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
    }
    return _addressLabel;
}

@end
