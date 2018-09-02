//
//  WSFActivitySignUpInfoView.m
//  WinShare
//
//  Created by GZH on 2018/2/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivitySignUpInfoView.h"
#import "NSMutableAttributedString+WSF_AdjustString.h"

@implementation WSFActivitySignUpInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupContentView];
    }
    return self;
}


- (void)setupContentView {
    self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    NSArray *remindArray = @[@"活动名额", @"报名人数",@"有效报名"];
    NSArray *numberArray = @[@"88", @"66",@"22"];
    
    CGFloat blockWidth = (SCREEN_WIDTH - 2) / 3;
    CGFloat blockLeft;
    for (int i = 0; i < remindArray.count; i++) {
        UILabel *label = [UILabel Z_createLabelWithFrame:CGRectZero title:remindArray[i] textFont:15 colorStr:@"#1a1a1a" aligment:NSTextAlignmentCenter];
         [self addSubview:label];
        blockLeft = (blockWidth + 1) * i;
        [label sizeToFit];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_centerY).offset(-2);
            make.left.mas_equalTo(blockLeft);
            make.width.mas_equalTo(blockWidth);
        }];
        
        UILabel *numberLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:numberArray[i] textFont:19 colorStr:@"#1a1a1a" aligment:NSTextAlignmentCenter];
        [self addSubview:numberLabel];
        [numberLabel sizeToFit];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_centerY).offset(3);
            make.left.mas_equalTo(label.mas_left);
            make.width.mas_equalTo(label.mas_width);
        }];
        
        if (i < 2) {
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
            [self addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(label.mas_right);
                make.top.mas_equalTo(self.mas_top).offset(26);
                make.bottom.mas_equalTo(self.mas_bottom).offset(-26);
                make.width.mas_equalTo(1);
            }];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
