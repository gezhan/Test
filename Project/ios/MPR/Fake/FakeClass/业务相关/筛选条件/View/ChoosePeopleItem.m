//
//  ChoosePeopleItem.m
//  WinShare
//
//  Created by GZH on 2017/5/23.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ChoosePeopleItem.h"

@interface ChoosePeopleItem ()



@end

@implementation ChoosePeopleItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.button];
   
    }
    return self;
}



- (UIButton *)button {
    if (_button == nil) {
        _button  = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 36)];
        _button.layer.masksToBounds = YES;
        _button.layer.cornerRadius = 5.0;
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
    
        
        [_button setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithHexString:@"#ffffff"]] forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithHexString:@"#2b84c6"]] forState:UIControlStateSelected];
        
        
        [_button setTitleColor:[UIColor colorWithHexString:@"#1a1a1a"] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateSelected];
        
        
        //边框
        _button.layer.borderWidth = 0.5;
        _button.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
    }
    return _button;
}


@end
