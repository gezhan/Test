//
//  WSFFieldMealView.m
//  WinShare
//
//  Created by GZH on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldMealView.h"
#import "UILabel+WSF_LineSpacing.h"
#import "WSFFieldMealVM.h"
@interface WSFFieldMealView ()

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *setMealLabel;
@property (nonatomic, strong) UIView *line;

@end
@implementation WSFFieldMealView

- (instancetype)initWithDetailsSetMealViewModel:(WSFFieldMealVM *)mealVM {
    self = [super init];
    if (self) {
        self.setMealLabel.text = @"场次";
        self.line.hidden = NO;
        self.bottomView = self.line;
        
        for (NSInteger i = 0; i < mealVM.behindArray.count; i ++) {
            UILabel *setNoLabel = [[UILabel alloc] init];
            setNoLabel.font = [UIFont systemFontOfSize:12];
            setNoLabel.text = [NSString stringWithFormat:@"%@ : ", mealVM.frontArray[i]];
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
            contentLabel.text = [NSString stringWithFormat:@"%@", mealVM.behindArray[i]];
//            contentLabel.text = @"kjsfdpoijowjfjij";
            [contentLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
            [self addSubview:contentLabel];
            [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(setNoLabel.mas_right);
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(setNoLabel.mas_top);
            }];
            
            self.bottomView = contentLabel;
            
            if (i == mealVM.behindArray.count - 1) {
                [self mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(10);
                }];
            }
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
