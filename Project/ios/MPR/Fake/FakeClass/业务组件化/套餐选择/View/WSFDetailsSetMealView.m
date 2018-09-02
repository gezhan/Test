//
//  WSFDetailsSetMealView.m
//  WinShare
//
//  Created by devRen on 2017/12/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDetailsSetMealView.h"
#import "WSFDetailsSetMealViewModel.h"
#import "UILabel+WSF_LineSpacing.h"

@interface WSFDetailsSetMealView ()

@property (nonatomic, strong) UILabel *setMealLabel;      // “套餐”Label
@property (nonatomic, strong) UIView *line;               // 分割线
@property (nonatomic, strong) UILabel *dotsLabel;         // “...”

@end

@implementation WSFDetailsSetMealView

- (instancetype)initWithDetailsSetMealViewModel:(WSFDetailsSetMealViewModel *)detailsSetMealViewModel {
    self = [super init];
    if (self) {
        self.setMealLabel.text = @"套餐";
        self.line.hidden = NO;
        self.bottomView = self.line;
        
        for (NSInteger i = 0; i < detailsSetMealViewModel.setNoArray.count; i ++) {
            UILabel *setNoLabel = [[UILabel alloc] init];
            setNoLabel.font = SYSTEMFONT_12;
            setNoLabel.text = detailsSetMealViewModel.setNoArray[i];
            setNoLabel.textColor = HEX_COLOR_0x808080;
            [self addSubview:setNoLabel];
            [setNoLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [setNoLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [setNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10);
                make.top.mas_equalTo(_bottomView.mas_bottom).offset(7);
            }];

            UILabel *contentLabel = [[UILabel alloc] init];
            contentLabel.numberOfLines = 3;
            contentLabel.font = SYSTEMFONT_12;
            contentLabel.attributedText = detailsSetMealViewModel.setContentArray[i];
//            [contentLabel wsf_setAttributedText:detailsSetMealViewModel.setContentArray[i] lineSpacing:6];
            [contentLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
            [self addSubview:contentLabel];
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(setNoLabel.mas_right);
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(setNoLabel.mas_top);
            }];

            self.bottomView = contentLabel;
            
            if (i == detailsSetMealViewModel.setNoArray.count - 1) {
                [self mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(10);
                }];
            }
        }
        
        if (detailsSetMealViewModel.isHaveDots) {
            self.dotsLabel.text = @"...";
            self.bottomView = _dotsLabel;
            
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(10);
            }];
        }
    }
    
    return self;
}

#pragma mark - 懒加载
- (UILabel *)setMealLabel {
    if (!_setMealLabel) {
        _setMealLabel = [[UILabel alloc] init];
        _setMealLabel.font = SYSTEMFONT_16;
        [self addSubview:_setMealLabel];
        [_setMealLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@10);
            make.height.mas_equalTo(@40);
            make.top.mas_equalTo(self.mas_top);
        }];
    }
    return _setMealLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = HEX_COLOR_0xE5E5E5;
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_setMealLabel.mas_bottom);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 1));
        }];
    }
    return _line;
}

- (UILabel *)dotsLabel {
    if (!_dotsLabel) {
        _dotsLabel = [[UILabel alloc] init];
        _dotsLabel.font = SYSTEMFONT_12;
        [self addSubview:_dotsLabel];
        [_dotsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@10);
            make.top.mas_equalTo(self.bottomView.mas_bottom);
        }];
    }
    return _dotsLabel;
}

@end
