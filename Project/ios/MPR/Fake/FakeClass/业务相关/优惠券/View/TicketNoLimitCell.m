//
//  TicketNoLimitCell.m
//  WinShare
//
//  Created by GZH on 2017/8/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "TicketNoLimitCell.h"
#import "TicketModel.h"

@interface TicketNoLimitCell ()

@property (nonatomic, strong) UILabel *tempLastLabel;
@property (nonatomic, assign) NSInteger limitCount;

@end

@implementation TicketNoLimitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier limitCount:(NSInteger)limitCount
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.limitCount = limitCount;
        [self setupViewContent];
    }
    return self;
}

- (void)setTicketModel:(TicketModel *)ticketModel
{
    _ticketModel = ticketModel;
    
    self.ticketTypeLabel.text = [NSString stringWithFormat:@"%0.1f%@", self.ticketModel.amount, self.ticketModel.amountType];
    self.ticketNameLabel.text = self.ticketModel.couponName;
    for (int i = 0; i < self.limitCount; i++) {
        UILabel *tempLabel = [self.ticketMessageLabelArray objectAtIndex:i];
        tempLabel.text = [self.ticketModel.limits objectAtIndex:i];
    }
    
    if (!ticketModel.isCanUse) {
        //颜色的改变
        [self.ticketTypeLabel setTextColor:[UIColor colorWithHexString:@"#cccccc"]];
        [self.ticketNameLabel setTextColor:[UIColor colorWithHexString:@"#cccccc"]];
        for (UILabel *tempLabel in self.ticketMessageLabelArray) {
            [tempLabel setTextColor:[UIColor colorWithHexString:@"#cccccc"]];
        }
        for (UIView *tempView in self.ticketDotViewLabelArray) {
            [tempView setBackgroundColor:[UIColor colorWithHexString:@"#cccccc"]];
        }
    }
}

- (void)setupViewContent
{
    //baseView
    self.baseView = [[UIView alloc] init];
    [self.contentView addSubview:self.baseView];
    //背景图案-左
    self.bgLeftImageView = [[UIImageView alloc] init];
    self.bgLeftImageView.image = [[UIImage imageNamed:@"youhuiquan_white_left"] resizingImageState];
    self.bgLeftImageView.userInteractionEnabled = NO;
    [self.baseView addSubview:self.bgLeftImageView];
    //背景图案-右
    self.bgRightImageView = [[UIImageView alloc] init];
    self.bgRightImageView.image = [[UIImage imageNamed:@"youhuiquan_white_right"] resizingImageState];
    self.bgRightImageView.userInteractionEnabled = NO;
    [self.baseView addSubview:self.bgRightImageView];
    //优惠方式
    self.ticketTypeLabel = [[UILabel alloc] init];
    self.ticketTypeLabel.text = [NSString stringWithFormat:@"%0.1f%@", self.ticketModel.amount, self.ticketModel.amountType];
    self.ticketTypeLabel.textColor = [UIColor colorWithHexString:@"#ff3142"];
    self.ticketTypeLabel.font = [UIFont systemFontOfSize:16];
    [self.bgLeftImageView addSubview:self.ticketTypeLabel];
    //选中标识
    self.selectedLogo = [[UIImageView alloc] init];
    self.selectedLogo.image = [UIImage imageNamed:@"xuanzhong"];
    self.selectedLogo.hidden = YES;
    [self.bgRightImageView addSubview:self.selectedLogo];
    //优惠券名称
    self.ticketNameLabel = [[UILabel alloc] init];
    self.ticketNameLabel.text = self.ticketModel.couponName;
    self.ticketNameLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
    self.ticketNameLabel.font = [UIFont systemFontOfSize:16];
    [self.bgRightImageView addSubview:self.ticketNameLabel];
    //使用说明
    self.tempLastLabel = [[UILabel alloc] init];
    //
    self.ticketMessageLabel = [[UILabel alloc] init];
    self.ticketMessageLabel.text = [self.ticketModel.limits firstObject];
    self.ticketMessageLabel.textColor = [UIColor colorWithHexString:@"#808080"];
    self.ticketMessageLabel.font = [UIFont systemFontOfSize:12];
    self.ticketMessageLabel.numberOfLines = 0;
    [self.bgRightImageView addSubview:self.ticketMessageLabel];
    self.tempLastLabel = self.ticketMessageLabel;
    
    [self.ticketMessageLabelArray addObject:self.ticketMessageLabel];
    
    //
    self.dotView = [[UIView alloc] init];
    self.dotView.backgroundColor = [UIColor colorWithHexString:@"808080"];
    [self.bgRightImageView addSubview:self.dotView];
    
    [self.ticketDotViewLabelArray addObject:self.dotView];
    
    for (int i = 1; i < self.limitCount; i ++) {
        //
        self.ticketMessageOtherLabel = [[UILabel alloc] init];
        self.ticketMessageOtherLabel.text = [self.ticketModel.limits objectAtIndex:i];
        self.ticketMessageOtherLabel.textColor = [UIColor colorWithHexString:@"#808080"];
        self.ticketMessageOtherLabel.font = [UIFont systemFontOfSize:12];
        self.ticketMessageOtherLabel.numberOfLines = 0;
        [self.bgRightImageView addSubview:self.ticketMessageOtherLabel];
        
        [self.ticketMessageLabelArray addObject:self.ticketMessageOtherLabel];
        
        [self.ticketMessageOtherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgRightImageView.mas_left).offset(17);
            make.right.mas_equalTo(self.bgRightImageView.mas_right).offset(-10);
            make.top.mas_equalTo(self.tempLastLabel.mas_bottom).offset(10);
            self.tempLastLabel = self.ticketMessageOtherLabel;
        }];
        //
        self.dotOtherView = [[UIView alloc] init];
        self.dotOtherView.backgroundColor = [UIColor colorWithHexString:@"808080"];
        [self.bgRightImageView addSubview:self.dotOtherView];
        
        [self.ticketDotViewLabelArray addObject:self.dotOtherView];
        
        [self.dotOtherView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgRightImageView.mas_left).offset(10);
            make.top.mas_equalTo(self.ticketMessageOtherLabel.mas_top).offset(6);
            make.size.mas_equalTo(CGSizeMake(2, 2));
        }];
    }
    
    [self layoutIfNeeded];
    
}

- (void)layoutSubviews
{
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(25);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-25);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
    [self.bgLeftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.baseView.mas_left).offset(0);
        make.width.mas_equalTo(83);
        make.top.mas_equalTo(self.baseView.mas_top).offset(0);
        make.bottom.mas_equalTo(self.baseView.mas_bottom).offset(0);
    }];
    
    [self.bgRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgLeftImageView.mas_right).offset(0);
        make.right.mas_equalTo(self.baseView.mas_right).offset(0);
        make.top.mas_equalTo(self.baseView.mas_top).offset(0);
        make.bottom.mas_equalTo(self.baseView.mas_bottom).offset(0);
    }];
    
    [self.ticketTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgLeftImageView.mas_centerX);
        make.centerY.mas_equalTo(self.bgLeftImageView.mas_centerY);
        
    }];
    
    [self.selectedLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgRightImageView.mas_top).offset(0);
        make.right.mas_equalTo(self.bgRightImageView.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.ticketNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgRightImageView.mas_left).offset(10);
        make.top.mas_equalTo(self.bgRightImageView.mas_top).offset(15);
    }];
    
    [self.ticketMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgRightImageView.mas_left).offset(17);
        make.right.mas_equalTo(self.bgRightImageView.mas_right).offset(-10);
        make.top.mas_equalTo(self.ticketNameLabel.mas_bottom).offset(10);
    }];
    
    [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgRightImageView.mas_left).offset(10);
        make.top.mas_equalTo(self.ticketMessageLabel.mas_top).offset(6);
        make.size.mas_equalTo(CGSizeMake(2, 2));
    }];
    
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.tempLastLabel.mas_bottom).offset(15);
    }];
    
    [super layoutSubviews];
    
}

#pragma mark - 懒加载
- (NSMutableArray *)ticketMessageLabelArray
{
    if (!_ticketMessageLabelArray) {
        _ticketMessageLabelArray = [NSMutableArray array];
    }
    return _ticketMessageLabelArray;
}

- (NSMutableArray *)ticketDotViewLabelArray
{
    if (!_ticketDotViewLabelArray) {
        _ticketDotViewLabelArray = [NSMutableArray array];
    }
    return _ticketDotViewLabelArray;
}

@end
