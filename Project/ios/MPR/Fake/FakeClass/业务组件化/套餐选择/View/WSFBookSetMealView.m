//
//  WSFBookSetMealView.m
//  WinShare
//
//  Created by devRen on 2017/12/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFBookSetMealView.h"
#import "UILabel+WSF_LineSpacing.h"

NSInteger WSFBookSetMealViewDefaultHeight = 82;             // view的默认高度

@interface WSFBookSetMealView ()

@property (nonatomic, strong) UIView *line;                 // 分割线
@property (nonatomic, strong) UILabel *recommendLabel;      // “推荐”Label
@property (nonatomic, strong) UILabel *setMealNameLabel;    // 套餐名

@end

@implementation WSFBookSetMealView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.setMealButton.hidden = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.line.backgroundColor = HEX_COLOR_0xCCCCCC;
        [self noSetMeal];
    }
    return self;
}

#pragma mark - UI更新
- (void)recommendBestSetMeal:(NSString *)setMealName setMeal:(NSMutableAttributedString *)setMeal {
    self.recommendLabel.hidden = NO;
    self.recommendLabel.text = @"已推荐最优组合";
    self.recommendLabel.textColor = HEX_COLOR_0x2B84C6;
    self.setMealNameLabel.hidden = NO;
    self.setMealLabel.hidden = NO;
    self.setMealNameLabel.text = [NSString stringWithFormat:@"%@:",setMealName];
//    [self.setMealLabel wsf_setAttributedText:setMeal lineSpacing:6];
    self.setMealLabel.attributedText = setMeal;
    [_setMealNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_recommendLabel.mas_bottom).offset(7);
    }];
}

- (void)noSetMeal {
    self.recommendLabel.hidden = NO;
    self.recommendLabel.text = @"无可选套餐";
    self.recommendLabel.textColor = HEX_COLOR_0xCCCCCC;
    self.setMealNameLabel.hidden = YES;
    self.setMealLabel.hidden = YES;
}

- (void)noRecommendSetMeal:(NSString *)setMealName setMeal:(NSMutableAttributedString *)setMeal {
    self.recommendLabel.text = @"";
    self.recommendLabel.hidden = YES;
    self.setMealNameLabel.hidden = NO;
    self.setMealLabel.hidden = NO;
    self.setMealNameLabel.text = [NSString stringWithFormat:@"%@:",setMealName];
//    [self.setMealLabel wsf_setAttributedText:setMeal lineSpacing:6];
    self.setMealLabel.attributedText = setMeal;
    [_setMealNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(_line.mas_bottom).offset(15);
    }];
}

#pragma mark - 点击事件
- (void)setMealSelector {
    
}

#pragma mark - 懒加载
- (UIButton *)setMealButton {
    if (!_setMealButton) {
        _setMealButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_setMealButton setTitle:@"套餐" forState:UIControlStateNormal];
        [_setMealButton.titleLabel setFont:SYSTEMFONT_16];
        [_setMealButton setTitleColor:HEX_COLOR_0x1A1A1A forState:UIControlStateNormal];
        [_setMealButton setImage:[UIImage imageNamed:@"xiangyou"] forState:UIControlStateNormal];
        _setMealButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _setMealButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        _setMealButton.imageEdgeInsets = UIEdgeInsetsMake(11, SCREEN_WIDTH-20, 0, 0);
        _setMealButton.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 20);
        [self addSubview:_setMealButton];
        [_setMealButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 36));
        }];
    }
    return _setMealButton;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH-20, 1)];
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_setMealButton.mas_bottom);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 1));
        }];
    }
    return _line;
}

- (UILabel *)recommendLabel {
    if (!_recommendLabel) {
        _recommendLabel = [[UILabel alloc] init];
        _recommendLabel.font = SYSTEMFONT_12;
        [self addSubview:_recommendLabel];
        [_recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(_line.mas_bottom).offset(15);
        }];
    }
    return _recommendLabel;
}

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
            make.top.mas_equalTo(_recommendLabel.mas_bottom).offset(7);
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
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(_setMealNameLabel.mas_top);
        }];
    }
    return _setMealLabel;
}

@end
