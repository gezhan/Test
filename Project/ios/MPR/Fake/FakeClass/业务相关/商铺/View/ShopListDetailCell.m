//
//  ShopListDetailCell.m
//  WinShare
//
//  Created by QIjikj on 2017/7/12.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopListDetailCell.h"
#import "ShopListDetailModel.h"
#import "HSFDotMessageView.h"

@interface ShopListDetailCell ()

@property (nonatomic, strong) UILabel *orderTimeLabel;//预定时间
@property (nonatomic, strong) UILabel *orderStateLabel;//订单状态
@property (nonatomic, strong) UILabel *yBeiLabel;//赢贝
@property (nonatomic, strong) UILabel *alipayLabel;//ZFB
@property (nonatomic, strong) UILabel *ticketLabel;//优惠券
@property (nonatomic, strong) HSFDotMessageView *setMealView;//用户使用的套餐
@property (nonatomic, strong) UIImageView *vipImage;//VIP标识
@property (nonatomic, strong) UILabel *userPhoneLabel;//用户手机号码

@end


@implementation ShopListDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupViewContent];
    }
    return self;
}

#pragma mark - 基础界面搭建
- (void)setupViewContent
{
    //灰条1
    UIView *grayView = [[UIView alloc] init];
    grayView.backgroundColor = HEX_COLOR_0xE5E5E5;
    [self.contentView addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 15));
    }];
    
    //预定时间
    self.orderTimeLabel = [[UILabel alloc] init];
    self.orderTimeLabel.font = [UIFont systemFontOfSize:14];
    self.orderTimeLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.orderTimeLabel.text = @"预定时间:2017-7-6 8:00-10:00";
    [self.contentView addSubview:self.orderTimeLabel];
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(grayView.mas_bottom).offset(10);
    }];
    
    //订单状态
    self.orderStateLabel = [[UILabel alloc] init];
    self.orderStateLabel.font = [UIFont systemFontOfSize:12];
    self.orderStateLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.orderStateLabel.text = @"已预订";
    [self.contentView addSubview:self.orderStateLabel];
    [self.orderStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(grayView.mas_bottom).offset(10);
    }];

    //赢贝
    self.yBeiLabel = [[UILabel alloc] init];
    self.yBeiLabel.font = [UIFont systemFontOfSize:14];
    self.yBeiLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.yBeiLabel.text = @"赢贝:200元";
    [self.contentView addSubview:self.yBeiLabel];
    [self.yBeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.orderTimeLabel.mas_bottom).offset(10);
    }];
    
    //ZFB
    self.alipayLabel = [[UILabel alloc] init];
    self.alipayLabel.font = [UIFont systemFontOfSize:14];
    self.alipayLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.alipayLabel.text = @"ZFB:200元";
    [self.contentView addSubview:self.alipayLabel];
    [self.alipayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.yBeiLabel.mas_bottom).offset(10);
    }];
    
    //优惠券
    self.ticketLabel = [[UILabel alloc] init];
    self.ticketLabel.font = [UIFont systemFontOfSize:14];
    self.ticketLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.ticketLabel.text = @"优惠券:-50元";
    [self.contentView addSubview:self.ticketLabel];
    [self.ticketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.alipayLabel.mas_bottom).offset(10);
    }];
    
    // 用户使用的套餐View
    self.setMealView = [[HSFDotMessageView alloc] initWithContentArray:@[@""] contentfont:14 contentColor:[UIColor colorWithHexString:@"1a1a1a"] titleArray:@[@""] titleFont:14 titleColor:[UIColor colorWithHexString:@"1a1a1a"] groupHeight:0];
    [self.contentView addSubview:self.setMealView];
    [self.setMealView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.ticketLabel.mas_bottom).offset(10);
    }];
    
    //灰条
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.setMealView.mas_bottom).offset(10);
        make.top.mas_equalTo(self.ticketLabel.mas_bottom).offset(10).priority(250);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 0.5));
    }];
    
    //VIP标识
    self.vipImage = [[UIImageView alloc] init];
    self.vipImage.image = [UIImage imageNamed:@"vip"];
    [self.contentView addSubview:self.vipImage];
    [self.vipImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 12));
        make.top.mas_equalTo(lineView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
    }];
    
    //用户手机号码
    self.userPhoneLabel = [[UILabel alloc] init];
    self.userPhoneLabel.font = [UIFont systemFontOfSize:12];
    self.userPhoneLabel.textColor = [UIColor colorWithHexString:@"808080"];
    self.userPhoneLabel.text = @"12345678901用户预订";
    [self.contentView addSubview:self.userPhoneLabel];
    [self.userPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.vipImage.mas_right).offset(10);
        make.top.mas_equalTo(lineView.mas_bottom).offset(10);
    }];
    
    //拨打电话
    UIButton *cellPhoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cellPhoneBtn.eventTimeInterval = 1;
    [cellPhoneBtn setImage:[UIImage imageNamed:@"dianhua_blue"] forState:UIControlStateNormal];
    [cellPhoneBtn addTarget:self action:@selector(cellPhoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cellPhoneBtn];
    [cellPhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(lineView.mas_bottom).offset(1);
        make.size.mas_equalTo(CGSizeMake(25, 29));
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];

}

- (void)setShopListDetailModel:(ShopListDetailModel *)shopListDetailModel
{
    _shopListDetailModel = shopListDetailModel;
    
    //预定时间
    NSDateFormatter *beginDateFormatter = [[NSDateFormatter alloc] init];
    [beginDateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    NSString *beginTimeStr = [beginDateFormatter stringFromDate:shopListDetailModel.beginTime];
    
    NSDateFormatter *endDateFormatter = [[NSDateFormatter alloc] init];
    [endDateFormatter setDateFormat: @"HH:mm"];
    NSString *endTimeStr = [endDateFormatter stringFromDate:shopListDetailModel.endTime];
    
    self.orderTimeLabel.text = [NSString stringWithFormat:@"预定时间：%@-%@", beginTimeStr, endTimeStr];
    NSMutableAttributedString * orderTimeLabelAttributedText = [[NSMutableAttributedString alloc] initWithString:self.orderTimeLabel.text];
    [orderTimeLabelAttributedText setAttributes:@{NSForegroundColorAttributeName :HEX_COLOR_0x808080} range:NSMakeRange(0, 5)];
    self.orderTimeLabel.attributedText = orderTimeLabelAttributedText;
    
    //订单状态
    self.orderStateLabel.text = shopListDetailModel.state;
    //赢贝
    self.yBeiLabel.text = [NSString stringWithFormat:@"赢贝：%0.2f元", shopListDetailModel.yBei];
    NSMutableAttributedString * yBeiLabelAttributedText = [[NSMutableAttributedString alloc] initWithString:self.yBeiLabel.text];
    [yBeiLabelAttributedText setAttributes:@{NSForegroundColorAttributeName :HEX_COLOR_0x808080} range:NSMakeRange(0, 3)];
    self.yBeiLabel.attributedText = yBeiLabelAttributedText;
    //ZFB
    self.alipayLabel.text = [NSString stringWithFormat:@"ZFB：%0.2f元", shopListDetailModel.zFB];
    NSMutableAttributedString * alipayLabelAttributedText = [[NSMutableAttributedString alloc] initWithString:self.alipayLabel.text];
    [alipayLabelAttributedText setAttributes:@{NSForegroundColorAttributeName :HEX_COLOR_0x808080} range:NSMakeRange(0, 4)];
    self.alipayLabel.attributedText = alipayLabelAttributedText;
    //优惠券
    self.ticketLabel.text = [NSString stringWithFormat:@"优惠券：%@元", shopListDetailModel.coupon];
    NSMutableAttributedString * ticketLabelAttributedText = [[NSMutableAttributedString alloc] initWithString:self.ticketLabel.text];
    [ticketLabelAttributedText setAttributes:@{NSForegroundColorAttributeName :HEX_COLOR_0x808080} range:NSMakeRange(0, 4)];
    self.ticketLabel.attributedText = ticketLabelAttributedText;
    // 用户使用的套餐
    if ([self.shopListDetailModel.setMealNo isEqualToString:@""]) {
        [self.setMealView removeFromSuperview];
        [self layoutIfNeeded];
    }else {
        [self.setMealView resetContentArray:@[self.shopListDetailModel.setMealContent] contentfont:14 contentColor:[UIColor colorWithHexString:@"1a1a1a"] titleArray:@[[self.shopListDetailModel.setMealNo stringByAppendingString:@"："]] titleFont:14 titleColor:HEX_COLOR_0x808080 groupHeight:0];
    }
    //VIP标识
    if (!shopListDetailModel.isVip) {
        [self.vipImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 12));
        }];
        [self.userPhoneLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.vipImage.mas_right).offset(0);
        }];
    }
    //用户手机号码
    self.userPhoneLabel.text = [NSString stringWithFormat:@"%@用户预定", shopListDetailModel.mobile];
}

- (void)cellPhoneAction
{
    [HSMathod callPhoneWithNumber:self.shopListDetailModel.mobile];
}

@end
