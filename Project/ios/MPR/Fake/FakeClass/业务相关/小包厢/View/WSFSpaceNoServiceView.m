//
//  WSFSpaceNoServiceView.m
//  WinShare
//
//  Created by QIjikj on 2017/12/28.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFSpaceNoServiceView.h"

@implementation WSFSpaceNoServiceView

- (instancetype)initWithFrame:(CGRect)frame clickBlock:(void(^)())clickBlock
{
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        
        //1.添加图片
        UIImageView *notFoundImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        UIImage *failImage = [UIImage imageNamed:@"only_hangzhou"];
        notFoundImageView.width = failImage.size.width;
        notFoundImageView.height = failImage.size.height;
        notFoundImageView.top = (self.size.height - failImage.size.height)/2.f - 64;
        notFoundImageView.image = failImage;
        CGPoint center = notFoundImageView.center;
        center.x = self.center.x;
        notFoundImageView.center = center;
        [self addSubview:notFoundImageView];
        
        //2.添加按钮
        //底色
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor clearColor];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(notFoundImageView.mas_bottom).offset(45);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(100, 35));
        }];
        //按钮
        if (@"看一看") {
            HSBlockButton *clickBtn = [HSBlockButton buttonWithType:UIButtonTypeCustom];
            [clickBtn setBackgroundImage:[UIImage imageNamed:@"tuoyuan_blue"] forState:UIControlStateNormal];
            [clickBtn setTitle:@"看一看" forState:UIControlStateNormal];
            [clickBtn setTitleColor:[UIColor colorWithHexString:@"2b84c6"] forState:UIControlStateNormal];
            [clickBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [bottomView addSubview:clickBtn];
            [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(bottomView);
                make.centerX.equalTo(bottomView);
                make.size.mas_equalTo(CGSizeMake(100, 35));
            }];
            [clickBtn addTouchUpInsideBlock:^(UIButton *button) {
                
//                [self removeFromSuperview];
                clickBlock();
            }];
        }
        
        // 3.底部的更多信息
        UILabel *moreMessageLabel = [[UILabel alloc] init];
        moreMessageLabel.text = @"";
        moreMessageLabel.textColor = [UIColor lightGrayColor];
        moreMessageLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:moreMessageLabel];
        [moreMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX).offset(0);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
        }];
        
    }
    return self;
}

@end
