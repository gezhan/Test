//
//  ShopCardDetailCell.m
//  WinShare
//
//  Created by QIjikj on 2017/8/23.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopCardDetailCell.h"

@interface ShopCardDetailCell ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation ShopCardDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupContentView];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupContentView
{
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.text = @"-50分钟";
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.contentView.mas_width);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.contentView.mas_top).offset(49.5);
    }];
}

- (void)setTimeDetailString:(NSString *)timeDetailString
{
    _timeDetailString = timeDetailString;
    
    self.timeLabel.text = timeDetailString;
}

@end
