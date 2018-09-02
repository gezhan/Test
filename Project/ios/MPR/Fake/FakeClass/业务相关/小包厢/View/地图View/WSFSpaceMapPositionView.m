//
//  WSFSpaceMapPositionView.m
//  WinShare
//
//  Created by GZH on 2017/12/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFSpaceMapPositionView.h"

@interface WSFSpaceMapPositionView ()
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *borderLabel;
@end

@implementation WSFSpaceMapPositionView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _label = [UILabel new];
        _label.backgroundColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.font = [UIFont systemFontOfSize:12];
        _label.textColor = [UIColor colorWithHexString:@"#333333"];
        _label.text = @"不明地理位置";
        _label.numberOfLines = 0;
        [self addSubview:_label];
        
        
        _borderLabel = [UILabel new];
        _borderLabel.backgroundColor = [UIColor whiteColor];
        _borderLabel.layer.borderWidth  = 0.5f;
        _borderLabel.layer.borderColor  = [UIColor colorWithHexString:@"#cccccc"].CGColor;
        _borderLabel.layer.cornerRadius = 5.0f;
        _borderLabel.layer.masksToBounds = YES;
        [self addSubview:_borderLabel];
        
        
        _imageV = [[UIImageView alloc]init];
        _imageV.image = [UIImage imageNamed:@"map_jiao_white"];
        [self addSubview:_imageV];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [_label sizeToFit];
    if (_label.width <= self.width - 24) {
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.bottom.mas_equalTo(self).offset(-18);
        }];
    }else {
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.left.equalTo(self).equalTo(@12);
            make.right.equalTo(self).equalTo(@-12);
            make.bottom.mas_equalTo(self).offset(-18);
        }];
    }
    
    
    [_borderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.label).offset(-10);
        make.bottom.right.mas_equalTo(self.label).offset(10);
    }];
    
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(_borderLabel.mas_bottom).offset(-1);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(8);
    }];
    
    [self bringSubviewToFront:_label];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
