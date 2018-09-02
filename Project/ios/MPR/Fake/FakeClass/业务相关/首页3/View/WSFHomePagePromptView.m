//
//  WSFHomePagePromptView.m
//  WinShare
//
//  Created by GZH on 2018/1/11.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFHomePagePromptView.h"

@implementation WSFHomePagePromptView

- (instancetype)initWithFrame:(CGRect)frame
                   signString:(NSString *)signString {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
        UIImageView *signImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_ju"]];
        [self addSubview:signImage];
        [signImage sizeToFit];
        [signImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.left.equalTo(self).offset(10);
            make.height.equalTo(@19);
        }];
        UILabel *hotSpaceLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:signString textFont:16 colorStr:@"#1a1a1a" aligment:NSTextAlignmentLeft];
        [self addSubview:hotSpaceLabel];
        [hotSpaceLabel sizeToFit];
        [hotSpaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(signImage.mas_top);
            make.left.equalTo(signImage.mas_right).offset(5);
        }];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
