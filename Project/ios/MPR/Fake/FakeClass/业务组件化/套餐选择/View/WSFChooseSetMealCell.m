//
//  WSFChooseSetMealCell.m
//  WinShare
//
//  Created by devRen on 2017/12/4.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFChooseSetMealCell.h"

@interface WSFChooseSetMealCell ()

@end

@implementation WSFChooseSetMealCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.setMealNameLabel.hidden = NO;
        self.setMealLabel.hidden = NO;
        self.dissatisfyLabel.hidden = YES;
    }
    return self;
}

- (void)theSetMealIsSelected:(BOOL)isSelected {
    if (isSelected) {
        self.chooseImageView.image = [UIImage imageNamed:@"setmeal_choice_blue"];
    } else {
        self.chooseImageView.image = [UIImage imageNamed:@"setmeal_choice_gray"];
    }
}
#pragma mark - 懒加载
- (UILabel *)setMealNameLabel {
    if (!_setMealNameLabel) {
        _setMealNameLabel = [[UILabel alloc] init];
        _setMealNameLabel.font = SYSTEMFONT_12;
        _setMealNameLabel.textColor = HEX_COLOR_0x808080;
        [self addSubview:_setMealNameLabel];
        [_setMealNameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_setMealNameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_setMealNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.mas_top).offset(7.5);
        }];
    }
    return _setMealNameLabel;
}

- (UILabel *)setMealLabel {
    if (!_setMealLabel) {
        _setMealLabel = [[UILabel alloc] init];
        _setMealLabel.numberOfLines = 3;
        _setMealLabel.font = SYSTEMFONT_12;
        _setMealLabel.textColor = HEX_COLOR_0x1A1A1A;
        [self addSubview:_setMealLabel];
        [_setMealLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [_setMealLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_setMealNameLabel.mas_right);
            make.right.mas_equalTo(-85);
            make.top.mas_equalTo(_setMealNameLabel.mas_top);
            make.bottom.equalTo(self.mas_bottom).mas_offset(-7.5);
        }];
    }
    return _setMealLabel;
}

- (UILabel *)dissatisfyLabel {
    if (!_dissatisfyLabel) {
        _dissatisfyLabel = [[UILabel alloc] init];
        _dissatisfyLabel.text = @"不满足条件";
        _dissatisfyLabel.font = SYSTEMFONT_12;
        _dissatisfyLabel.textColor = HEX_COLOR_0xCCCCCC;
        [self addSubview:_dissatisfyLabel];
        [_dissatisfyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return _dissatisfyLabel;
}

- (UIImageView *)chooseImageView {
    if (!_chooseImageView) {
        _chooseImageView = [[UIImageView alloc] init];
        [self addSubview:_chooseImageView];
        [_chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).mas_offset(-10);
            make.height.width.equalTo(@16);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return _chooseImageView;
}

@end
