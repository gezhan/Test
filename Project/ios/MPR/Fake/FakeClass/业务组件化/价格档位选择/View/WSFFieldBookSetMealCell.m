//
//  WSFFieldBookSetMealCell.m
//  WinShare
//
//  Created by QIjikj on 2018/1/17.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldBookSetMealCell.h"

@implementation WSFFieldBookSetMealCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.priceStallLabel.hidden = NO;
        self.priceStallContentLabel.hidden = NO;
    }
    return self;
}

- (void)theSetMealIsSelected:(BOOL)isSelected {
    if (isSelected) {
        self.chooseImageView.image = [UIImage imageNamed:@"setmeal_choice_blue"];
    } else {
        self.chooseImageView.image = [UIImage imageNamed:@"setmeal_choice_gray"];
    }
}

#pragma mark - 懒加载
- (UILabel *)priceStallLabel {
    if (!_priceStallLabel) {
        _priceStallLabel = [[UILabel alloc] init];
        _priceStallLabel.font = SYSTEMFONT_14;
        _priceStallLabel.textColor = HEX_COLOR_0x1A1A1A;
        [self.contentView addSubview:_priceStallLabel];
        [_priceStallLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(self.contentView.mas_top).offset(5);
        }];
    }
    return _priceStallLabel;
}

- (UILabel *)priceStallContentLabel {
    if (!_priceStallContentLabel) {
        _priceStallContentLabel = [[UILabel alloc] init];
        _priceStallContentLabel.font = SYSTEMFONT_12;
        _priceStallContentLabel.textColor = HEX_COLOR_0x808080;
        _priceStallContentLabel.numberOfLines = 0;
        [self.contentView addSubview:_priceStallContentLabel];
        [_priceStallContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(SCREEN_WIDTH - 20 - 30);
            make.top.mas_equalTo(self.priceStallLabel.mas_bottom).offset(5);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        }];
    }
    return _priceStallContentLabel;
}

- (UIImageView *)chooseImageView {
    if (!_chooseImageView) {
        _chooseImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_chooseImageView];
        [_chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).mas_offset(-10);
            make.height.width.equalTo(@16);
            make.centerY.mas_equalTo(self.priceStallLabel.mas_centerY);
        }];
    }
    return _chooseImageView;
}

@end
