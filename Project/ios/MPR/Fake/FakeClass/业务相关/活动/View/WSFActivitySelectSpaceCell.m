//
//  WSFActivitySelectSpaceCell.m
//  WinShare
//
//  Created by QIjikj on 2018/2/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivitySelectSpaceCell.h"

@interface WSFActivitySelectSpaceCell ()

@end

@implementation WSFActivitySelectSpaceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView {
    self.sapceImageView.hidden = NO;
    self.nameLabel.hidden = NO;
    self.addressLabel.hidden = NO;
    self.selectBtn.hidden = NO;
}

#pragma mark - 懒加载
- (UIImageView *)sapceImageView {
    if (!_sapceImageView) {
        _sapceImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_sapceImageView];
        [_sapceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(75, 75));
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        }];
    }
    return _sapceImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = SYSTEMFONT_14;
        _nameLabel.textColor = HEX_COLOR_0x1A1A1A;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.sapceImageView.mas_right).offset(10);
            make.top.mas_equalTo(self.sapceImageView.mas_top).offset(10);
        }];
    }
    return _nameLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = SYSTEMFONT_14;
        _addressLabel.textColor = HEX_COLOR_0x1A1A1A;
        [self.contentView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.sapceImageView.mas_right).offset(10);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        }];
    }
    return _addressLabel;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"setmeal_choice_gray"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"setmeal_choice_blue"] forState:UIControlStateSelected];
        [self.contentView addSubview:_selectBtn];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 10));
            make.centerY.mas_equalTo(self.sapceImageView.mas_centerY);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        }];
    }
    return _selectBtn;
}

@end
