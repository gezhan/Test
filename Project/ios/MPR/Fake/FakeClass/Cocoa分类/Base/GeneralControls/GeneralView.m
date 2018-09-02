//
//  FootView.m
//  XiaoYing
//
//  Created by GZH on 2017/2/27.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "GeneralView.h"

@implementation GeneralView

- (UIButton *)generalBtn {

    if (_generalBtn == nil) {
        self.generalBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//        [self.generalBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
//        self.generalBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.generalBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _generalBtn;
}



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.generalBtn];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        [self addSubview:lineView];
        
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
