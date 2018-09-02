//
//  WSFShopListDetailFieldCell.m
//  WinShare
//
//  Created by QIjikj on 2018/1/11.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

/**
 1、对应的Model
 2、UI空间的属性名更改
 
 */

#import "WSFShopListDetailFieldCell.h"
#import "WSFBusinessBrDetailApiModel.h"
#import "HSFDotMessageView.h"
#import "WSFBusinessBrDetailApiModel.h"

@interface WSFShopListDetailFieldCell ()

@property (nonatomic, strong) UILabel *orderTimeLabel;//预定时间
@property (nonatomic, strong) UILabel *orderStateLabel;//订单状态
@property (nonatomic, strong) UILabel *yBeiLabel;//赢贝
@property (nonatomic, strong) UILabel *alipayLabel;//ZFB
@property (nonatomic, strong) UILabel *ticketLabel;//优惠券
@property (nonatomic, strong) HSFDotMessageView *setMealView;//用户使用的套餐
@property (nonatomic, strong) UIImageView *vipImage;//VIP标识
@property (nonatomic, strong) UILabel *userPhoneLabel;//用户手机号码
@property (nonatomic, strong) UILabel *handselAccountLabel;//定金

@end

@implementation WSFShopListDetailFieldCell

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
    
    //使用时间
    self.orderTimeLabel = [[UILabel alloc] init];
    self.orderTimeLabel.font = [UIFont systemFontOfSize:14];
    self.orderTimeLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.orderTimeLabel.text = @"使用日期:2017-7-6";
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
    
    //场次
    self.yBeiLabel = [[UILabel alloc] init];
    self.yBeiLabel.font = [UIFont systemFontOfSize:14];
    self.yBeiLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.yBeiLabel.text = @"场次：上午场（9:00-13:00）";
    [self.contentView addSubview:self.yBeiLabel];
    [self.yBeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.orderTimeLabel.mas_bottom).offset(10);
    }];
    
    //套餐
    self.alipayLabel = [[UILabel alloc] init];
    self.alipayLabel.font = [UIFont systemFontOfSize:14];
    self.alipayLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.alipayLabel.text = @"套餐：1000元/场";
    [self.contentView addSubview:self.alipayLabel];
    [self.alipayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.yBeiLabel.mas_bottom).offset(10);
    }];
    
    //优惠
    self.ticketLabel = [[UILabel alloc] init];
    self.ticketLabel.font = [UIFont systemFontOfSize:14];
    self.ticketLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.ticketLabel.text = @"优惠:-50元";
    [self.contentView addSubview:self.ticketLabel];
    [self.ticketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.alipayLabel.mas_bottom).offset(10);
    }];

    //灰条
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ticketLabel.mas_bottom).offset(10);
        make.top.mas_equalTo(self.alipayLabel.mas_bottom).offset(10).priority(250);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 0.5));
    }];
    
    //总价
    self.userPhoneLabel = [[UILabel alloc] init];
    self.userPhoneLabel.font = SYSTEMFONT_14;
    self.userPhoneLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.userPhoneLabel.text = @"总价：800.0元";
    [self.contentView addSubview:self.userPhoneLabel];
    [self.userPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(lineView.mas_bottom).offset(10);
    }];
    
    //定金
    self.handselAccountLabel = [[UILabel alloc] init];
    self.handselAccountLabel.font = SYSTEMFONT_14;
    self.handselAccountLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.handselAccountLabel.text = @"定金：0.00元";
    [self.contentView addSubview:self.handselAccountLabel];
    [self.handselAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(lineView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
}

- (void)setShopListDetailModel:(WSFBusinessBrDetailApiModel *)shopListDetailModel
{
    _shopListDetailModel = shopListDetailModel;
    
    //使用时间
    NSString *userTimeStr = [NSString dateStrWithNewFormatter:@"yyyy-MM-dd" oldStr:shopListDetailModel.useTime oldFormatter:@"yyyy-MM-dd"];
    
    self.orderTimeLabel.text = [NSString stringWithFormat:@"使用日期：%@", userTimeStr];
    NSMutableAttributedString * orderTimeLabelAttributedText = [[NSMutableAttributedString alloc] initWithString:self.orderTimeLabel.text];
    [orderTimeLabelAttributedText setAttributes:@{NSForegroundColorAttributeName :HEX_COLOR_0x808080} range:NSMakeRange(0, 5)];
    self.orderTimeLabel.attributedText = orderTimeLabelAttributedText;
    
    //订单状态
    self.orderStateLabel.text = shopListDetailModel.status;
    
    //场次
    self.yBeiLabel.text = [NSString stringWithFormat:@"场次：%@", shopListDetailModel.siteMeal];
    NSMutableAttributedString * yBeiLabelAttributedText = [[NSMutableAttributedString alloc] initWithString:self.yBeiLabel.text];
    [yBeiLabelAttributedText setAttributes:@{NSForegroundColorAttributeName :HEX_COLOR_0x808080} range:NSMakeRange(0, 3)];
    self.yBeiLabel.attributedText = yBeiLabelAttributedText;
    
    //套餐
    self.alipayLabel.text = [NSString stringWithFormat:@"套餐：%@", shopListDetailModel.setMeal];
    NSMutableAttributedString * alipayLabelAttributedText = [[NSMutableAttributedString alloc] initWithString:self.alipayLabel.text];
    [alipayLabelAttributedText setAttributes:@{NSForegroundColorAttributeName :HEX_COLOR_0x808080} range:NSMakeRange(0, 3)];
    self.alipayLabel.attributedText = alipayLabelAttributedText;
    
    //优惠
    self.ticketLabel.text = [NSString stringWithFormat:@"优惠：%0.2lf元", shopListDetailModel.discountsAmount];
    NSMutableAttributedString * ticketLabelAttributedText = [[NSMutableAttributedString alloc] initWithString:self.ticketLabel.text];
    [ticketLabelAttributedText setAttributes:@{NSForegroundColorAttributeName :HEX_COLOR_0x808080} range:NSMakeRange(0, 3)];
    self.ticketLabel.attributedText = ticketLabelAttributedText;
    
    //总价
    self.userPhoneLabel.text = [NSString stringWithFormat:@"总价：%0.2f", shopListDetailModel.totalAmount];
    
    //总价
    self.handselAccountLabel.text = [NSString stringWithFormat:@"定金：%0.2f", shopListDetailModel.payAmount];
}

@end
