//
//  ShopListDetailHeadCell.m
//  WinShare
//
//  Created by QIjikj on 2017/7/12.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopListDetailHeadCell.h"
#import "ShopListDetailHeadModel.h"

@interface ShopListDetailHeadCell ()

@property (nonatomic, strong) UILabel *incomeAccountLabel;//已收入金额
@property (nonatomic, strong) UILabel *processingAccountLabel;//未完成订单
@property (nonatomic, strong) UILabel *processedAccountLabel;//已完成订单
@property (nonatomic, strong) UILabel *handselAccountLabel;//定金收入

@end

@implementation ShopListDetailHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupViewContent];
        
    }
    return self;
}

- (void)setupViewContent
{
    //已收入标识
    UILabel *incomeLabel = [[UILabel alloc] init];
    incomeLabel.font = [UIFont systemFontOfSize:12];
    incomeLabel.textColor = [UIColor colorWithHexString:@"2b84c6"];
    incomeLabel.text = @"已收入";
    [self.contentView addSubview:incomeLabel];
    [incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_top).offset(25);
    }];
    
    //已收入金额
    self.incomeAccountLabel = [[UILabel alloc] init];
    self.incomeAccountLabel.font = [UIFont systemFontOfSize:18];
    self.incomeAccountLabel.textColor = [UIColor colorWithHexString:@"2b84c6"];
    self.incomeAccountLabel.text = @"5000元";
    [self.contentView addSubview:self.incomeAccountLabel];
    [self.incomeAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.mas_equalTo(incomeLabel.mas_bottom).offset(10);
    }];
    
    //未完成订单标识
    UILabel *processingLabel = [[UILabel alloc] init];
    processingLabel.font = [UIFont systemFontOfSize:12];
    processingLabel.textColor = [UIColor colorWithHexString:@"808080"];
    processingLabel.textAlignment = NSTextAlignmentCenter;
    processingLabel.text = @"未完成订单";
    [self.contentView addSubview:processingLabel];
    [processingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
        make.top.mas_equalTo(self.incomeAccountLabel.mas_bottom).offset(20);
    }];
    
    //未完成订单数
    self.processingAccountLabel = [[UILabel alloc] init];
    self.processingAccountLabel.font = [UIFont systemFontOfSize:14];
    self.processingAccountLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.processingAccountLabel.text = @"5单";
    [self.contentView addSubview:self.processingAccountLabel];
    [self.processingAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(processingLabel);
        make.top.mas_equalTo(processingLabel.mas_bottom).offset(10);
    }];
    
    //分割线
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"808080"];
    [self.contentView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(processingLabel.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-19);
    }];
    
    //已完成订单标识
    UILabel *processedLabel = [[UILabel alloc] init];
    processedLabel.font = [UIFont systemFontOfSize:12];
    processedLabel.textColor = [UIColor colorWithHexString:@"808080"];
    processedLabel.textAlignment = NSTextAlignmentCenter;
    processedLabel.text = @"已完成订单";
    [self.contentView addSubview:processedLabel];
    [processedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView1.mas_right).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
        make.top.mas_equalTo(self.incomeAccountLabel.mas_bottom).offset(20);
    }];
    
    //已完成订单数
    self.processedAccountLabel = [[UILabel alloc] init];
    self.processedAccountLabel.font = [UIFont systemFontOfSize:14];
    self.processedAccountLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.processedAccountLabel.text = @"20单";
    [self.contentView addSubview:self.processedAccountLabel];
    [self.processedAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(processedLabel);
        make.top.mas_equalTo(processedLabel.mas_bottom).offset(10);
    }];
    
    //分割线
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"808080"];
    [self.contentView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(processedLabel.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-19);
    }];
    
    //定金收入标识
    UILabel *handselLabel = [[UILabel alloc] init];
    handselLabel.font = [UIFont systemFontOfSize:12];
    handselLabel.textColor = [UIColor colorWithHexString:@"808080"];
    handselLabel.textAlignment = NSTextAlignmentCenter;
    handselLabel.text = @"定金收入";
    [self.contentView addSubview:handselLabel];
    [handselLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView2.mas_right).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
        make.top.mas_equalTo(self.incomeAccountLabel.mas_bottom).offset(20);
    }];
    
    //定金收入金额
    self.handselAccountLabel = [[UILabel alloc] init];
    self.handselAccountLabel.font = [UIFont systemFontOfSize:14];
    self.handselAccountLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.handselAccountLabel.text = @"5000元";
    [self.contentView addSubview:self.handselAccountLabel];
    [self.handselAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(handselLabel);
        make.top.mas_equalTo(handselLabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

- (void)setShopListDetailHeadModel:(ShopListDetailHeadModel *)shopListDetailHeadModel
{
    _shopListDetailHeadModel = shopListDetailHeadModel;
    
    //已收入金额
    self.incomeAccountLabel.text = [NSString stringWithFormat:@"%0.2f元", shopListDetailHeadModel.incomeAmount];
    //未完成订单
    self.processingAccountLabel.text = [NSString stringWithFormat:@"%ld单", shopListDetailHeadModel.ongoing];
    //已完成订单
    self.processedAccountLabel.text = [NSString stringWithFormat:@"%ld单", shopListDetailHeadModel.finished];
    //定金收入
    self.handselAccountLabel.text = [NSString stringWithFormat:@"%0.2f元", shopListDetailHeadModel.expectedAmount];
}

@end
