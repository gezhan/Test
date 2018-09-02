//
//  WSFActivityPersonalInfoCell.m
//  WinShare
//
//  Created by GZH on 2018/2/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityPersonalInfoCell.h"

@interface WSFActivityPersonalInfoCell ()
@property (nonatomic, strong) UILabel *timeLabel;     //时间
@property (nonatomic, strong) UILabel *nameLabel;     //姓名
@property (nonatomic, strong) UILabel *phoneLabel;    //电话
@property (nonatomic, strong) UILabel *statusLabel;   //状态
@property (nonatomic, strong) UILabel *priceLabel;    //价钱
@end

@implementation WSFActivityPersonalInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupContentView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupContentView {
    self.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(15);
        make.left.bottom.right.mas_equalTo(self.contentView);
    }];
    
    _timeLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:@"" textFont:16 colorStr:@"#1a1a1a" aligment:NSTextAlignmentLeft];
    _timeLabel.text = @"报名时间 : 2018/1/10";
    [backView addSubview:_timeLabel];
    [_timeLabel sizeToFit];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(10);
        make.top.equalTo(backView).offset(15);
    }];
    
    _nameLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:@"" textFont:16 colorStr:@"#1a1a1a" aligment:NSTextAlignmentLeft];
    _nameLabel.text = @"姓名 : 王小二";
    [backView addSubview:_nameLabel];
    [_nameLabel sizeToFit];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLabel.mas_left);
        make.top.equalTo(_timeLabel.mas_bottom).offset(15);
    }];
    
    _phoneLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:@"" textFont:16 colorStr:@"#1a1a1a" aligment:NSTextAlignmentLeft];
    _phoneLabel.text = @"电话 : 138565089778";
    [backView addSubview:_phoneLabel];
    [_phoneLabel sizeToFit];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_timeLabel.mas_left);
        make.top.equalTo(_nameLabel.mas_bottom).offset(15);
        make.bottom.equalTo(backView).offset(-15);
    }];
    
    _statusLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:@"" textFont:16 colorStr:@"#1a1a1a" aligment:NSTextAlignmentRight];
    _statusLabel.text = @"已报名";
    [backView addSubview:_statusLabel];
    [_statusLabel sizeToFit];
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_right).offset(-10);
        make.top.equalTo(_timeLabel.mas_top);
    }];
    
    _priceLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:@"" textFont:16 colorStr:@"#1a1a1a" aligment:NSTextAlignmentRight];
    _priceLabel.text = @"免费";
    [backView addSubview:_priceLabel];
    [_priceLabel sizeToFit];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_statusLabel.mas_right);
        make.bottom.equalTo(_phoneLabel.mas_bottom);
    }];
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
