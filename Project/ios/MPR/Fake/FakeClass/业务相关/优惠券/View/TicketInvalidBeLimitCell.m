//
//  TicketInvalidBeLimitCell.m
//  WinShare
//
//  Created by GZH on 2017/8/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "TicketInvalidBeLimitCell.h"

@interface TicketInvalidBeLimitCell ()

@property (nonatomic, strong) UILabel *invalidLabel;

@end

@implementation TicketInvalidBeLimitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupViewContent
{
    [super setupViewContent];
    
    //失效
    if (!self.hindDetailMessage) {
        self.invalidLabel = [[UILabel alloc] init];
        [self.invalidLabel setText:@"(已失效)"];
        [self.invalidLabel setFont:[UIFont systemFontOfSize:12]];
        [self.invalidLabel setTextColor:[UIColor colorWithHexString:@"#cccccc"]];
        [self.bgRightImageView addSubview: self.invalidLabel];
    }
    
    //颜色的改变
    [self.ticketTypeLabel setTextColor:[UIColor colorWithHexString:@"#cccccc"]];
    [self.ticketNameLabel setTextColor:[UIColor colorWithHexString:@"#cccccc"]];
    [self.ticketLimitLabel setTextColor:[UIColor colorWithHexString:@"#cccccc"]];
    for (UILabel *tempLabel in self.ticketMessageLabelArray) {
        [tempLabel setTextColor:[UIColor colorWithHexString:@"#cccccc"]];
    }
    for (UIView *tempView in self.ticketDotViewLabelArray) {
        [tempView setBackgroundColor:[UIColor colorWithHexString:@"#cccccc"]];
    }
    
    [self layoutIfNeeded];
    
}

- (void)layoutSubviews
{
    [self.invalidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.ticketNameLabel.mas_centerY).offset(0);
        make.left.mas_equalTo(self.ticketNameLabel.mas_right).offset(2);
    }];
    
    [super layoutSubviews];
    
}

@end
