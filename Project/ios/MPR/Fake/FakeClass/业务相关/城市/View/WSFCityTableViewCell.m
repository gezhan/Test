//
//  WSFCityTableViewCell.m
//  WinShare
//
//  Created by GZH on 2017/12/25.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFCityTableViewCell.h"
#import "UIButton+WSF_ContentVertical.h"

@interface WSFCityTableViewCell()
/**  当前所在城市 */
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UIButton *positionBtn;
/**  热门城市 */
@property (nonatomic, strong) UILabel *hotLabel;
@property (nonatomic, strong) UIButton *hotBtn;
@property (nonatomic, strong) UILabel *lineLabel;
@end

@implementation WSFCityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        
    }
    return self;
}

- (void)layoutSubviews {
    if (self.tag == 1024) {
        self.positionLabel.hidden = NO;
        self.positionBtn.hidden = NO;
    }else {
        self.hotLabel.hidden = NO;
        self.hotBtn.hidden = NO;
        self.lineLabel.hidden = NO;
    }
    if(_placemark.locality.length > 0)[_positionBtn setTitle:[NSString stringWithFormat:@"%@", _placemark.locality] forState:UIControlStateNormal];
}

- (UILabel *)positionLabel {
    if (_positionLabel == nil) {
        _positionLabel = [[UILabel alloc]init];
        _positionLabel.textColor = [UIColor colorWithHexString:@"#808080"];
        _positionLabel.font = [UIFont systemFontOfSize:14];
        _positionLabel.text = @"您当前所在的城市";
        [_positionLabel sizeToFit];
        [self addSubview:_positionLabel];
        [_positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).equalTo(@10);
            make.top.equalTo(self).equalTo(@15);
        }];
    }
    return _positionLabel;
}
- (UIButton *)positionBtn {
    if (_positionBtn == nil) {
        _positionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_positionBtn setTitle:@"..." forState:UIControlStateNormal];
        [_positionBtn setImage:[UIImage imageNamed:@"position_city_gray"] forState:UIControlStateNormal];
        _positionBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_positionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_positionBtn wsf_horizontalImageAndTitleWithSpacing:6];
        [_positionBtn addTarget:self action:@selector(positionCity) forControlEvents:UIControlEventTouchUpInside];
        [_positionBtn.layer setBorderColor:[UIColor colorWithHexString:@"#cccccc"].CGColor];
        [_positionBtn.layer setBorderWidth:1.0];
        [_positionBtn.layer setMasksToBounds:YES];
        [_positionBtn.layer setCornerRadius:6.0];
        _positionBtn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [self addSubview:_positionBtn];
        [_positionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).equalTo(@10);
            make.top.equalTo(_positionLabel.mas_bottom).offset(10);
            make.width.equalTo(@74);
            make.height.equalTo(@37);
        }];
    }
    return _positionBtn;
}
- (UILabel *)hotLabel {
    if (_hotLabel == nil) {
        _hotLabel = [[UILabel alloc]init];
        _hotLabel.textColor = [UIColor colorWithHexString:@"#808080"];
        _hotLabel.font = [UIFont systemFontOfSize:14];
        _hotLabel.text = @"热门城市";
        [_hotLabel sizeToFit];
        [self addSubview:_hotLabel];
        [_hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).equalTo(@10);
            make.top.equalTo(self).equalTo(@20);
        }];
    }
    return _hotLabel;
}

- (UIButton *)hotBtn {
    if (_hotBtn == nil) {
        _hotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hotBtn setTitle:@"杭州市" forState:UIControlStateNormal];
        _hotBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_hotBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_hotBtn addTarget:self action:@selector(hotCity) forControlEvents:UIControlEventTouchUpInside];
        [_hotBtn.layer setBorderColor:[UIColor colorWithHexString:@"#cccccc"].CGColor];
        [_hotBtn.layer setBorderWidth:1.0];
        [_hotBtn.layer setMasksToBounds:YES];
        [_hotBtn.layer setCornerRadius:6.0];
        _hotBtn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [self addSubview:_hotBtn];
        [_hotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).equalTo(@10);
            make.top.equalTo(_hotLabel.mas_bottom).offset(10);
            make.width.equalTo(@74);
            make.height.equalTo(@37);
        }];
    }
    return _hotBtn;
}
- (UILabel *)lineLabel {
    if (_lineLabel == nil) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        [self addSubview:_lineLabel];
        [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.mas_bottom);
            make.height.equalTo(@0.5);
        }];
    }
    return _lineLabel;
}

/**  当前城市 */
- (void)positionCity {
    if(_cityNameBlack)_cityNameBlack(@"杭州市");
}


/**  热门城市 */
- (void)hotCity {
    if(_cityNameBlack)_cityNameBlack(@"杭州市");
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
