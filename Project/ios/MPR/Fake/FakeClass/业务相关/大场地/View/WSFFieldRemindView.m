//
//  WSFFieldRemindView.m
//  WinShare
//
//  Created by GZH on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldRemindView.h"
@interface WSFFieldRemindView ()
@property (nonatomic, strong) UIImageView *remindImage;
@end

@implementation WSFFieldRemindView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.remindImage.hidden = NO;
        self.remindLabel.hidden = NO;
        
    }
    return self;
}

- (UIImageView *)remindImage {
    if (!_remindImage) {
        _remindImage = [[UIImageView alloc]init];
        _remindImage.image = [UIImage imageNamed:@"home_tishi"];
        [self addSubview:_remindImage];
        [_remindImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.bottom.equalTo(self.mas_bottom).offset(-13);
            make.size.mas_equalTo(CGSizeMake(15,  17));
        }];
    }
    return _remindImage;
}

- (UILabel *)remindLabel {
    if (!_remindLabel) {
        _remindLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:@"线下可消费价格档位内商家提供的任意商品" textFont:14 colorStr:@"#ffa304" aligment:NSTextAlignmentLeft];
        [self addSubview:_remindLabel];
        [_remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_remindImage.mas_right).offset(7);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(_remindImage.mas_top);
            make.bottom.equalTo(_remindImage.mas_bottom);
        }];
    }
    return _remindLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
