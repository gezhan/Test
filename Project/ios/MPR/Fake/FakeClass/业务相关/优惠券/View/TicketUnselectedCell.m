//
//  TicketUnselectedCell.m
//  WinShare
//
//  Created by GZH on 2017/8/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "TicketUnselectedCell.h"

@interface TicketUnselectedCell ()

@end

@implementation TicketUnselectedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupViewContent];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setupViewContent
{
    //
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    bgView.layer.cornerRadius = 3;
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.height.mas_equalTo(35);
        make.left.mas_equalTo(self.contentView.mas_left).offset(25);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-25);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
    //
    UILabel *unSelectedLabel = [[UILabel alloc] init];
    unSelectedLabel.text = @"不使用优惠券";
    [unSelectedLabel setTextColor: [UIColor colorWithHexString:@"#1a1a1a"]];
    [unSelectedLabel setFont:[UIFont systemFontOfSize:14]];
    [bgView addSubview:unSelectedLabel];
    [unSelectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView.mas_centerX).offset(0);
        make.centerY.mas_equalTo(bgView.mas_centerY).offset(0);

    }];
    
    //
    //选中标识
    self.selectedLogo = [[UIImageView alloc] init];
    self.selectedLogo.image = [UIImage imageNamed:@"xuanzhong"];
    self.selectedLogo.hidden = YES;
    [bgView addSubview:self.selectedLogo];
    [self.selectedLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_top).offset(0);
        make.right.mas_equalTo(bgView.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
}

@end
