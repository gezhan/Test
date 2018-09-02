//
//  WSFHomePageCItem.m
//  WinShare
//
//  Created by GZH on 2018/1/11.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFHomePageCItem.h"

@interface WSFHomePageCItem()
@property (nonatomic, strong) UIImageView *spaceImage;
@property (nonatomic, strong) UILabel *spaceNameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@end

@implementation WSFHomePageCItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.spaceNameLabel.hidden = NO;
//        self.spaceImage.hidden = NO;
        
    }
    return self;
}

- (void)setHotRoomVM:(WSFHomePageHotRoomVM *)hotRoomVM {
    _hotRoomVM = hotRoomVM;
    
    self.spaceNameLabel.text = hotRoomVM.roomName;
    [self.spaceImage sd_setImageWithURL:[NSURL URLWithString:hotRoomVM.picture] placeholderImage:[UIImage imageNamed:@"logo_qian_bg"]];
    self.priceLabel.text = hotRoomVM.price;
}

- (UILabel *)spaceNameLabel {
    if (_spaceNameLabel == nil) {
        _spaceNameLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:@"42号咖啡" textFont:13 colorStr:@"1a1a1a" aligment:NSTextAlignmentLeft];
        [self.contentView addSubview:_spaceNameLabel];
        [_spaceNameLabel sizeToFit];
        [_spaceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
    }
    return _spaceNameLabel;
}

- (UIImageView *)spaceImage {
    if (_spaceImage == nil) {
        _spaceImage = [[UIImageView alloc]init];
//        _spaceImage.backgroundColor = [UIColor cyanColor];
        [self addSubview:_spaceImage];
        [_spaceImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.bottom.equalTo(self.spaceNameLabel.mas_top).offset(-10);
        }];
        
        UILabel *priceLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:@"￥100/h" textFont:11 colorStr:@"#ffffff" aligment:NSTextAlignmentCenter];
        _priceLabel = priceLabel;
        priceLabel.layer.masksToBounds = YES;
        priceLabel.layer.cornerRadius = 5.0;
        priceLabel.backgroundColor = [UIColor colorWithHexString:@"#1a1a1a" alpha:0.6];
//        priceLabel.alpha = 0.6;
        
        [_spaceImage addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_spaceImage.mas_bottom).offset(-5);
            make.right.equalTo(_spaceImage.mas_right).offset(-5);
            make.size.mas_equalTo(CGSizeMake(55, 24));
        }];
        
    }
    return _spaceImage;
}

@end
