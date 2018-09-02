//
//  WSFFieldOrderIntroductionView.m
//  WinShare
//
//  Created by QIjikj on 2018/1/17.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldOrderIntroductionView.h"
#import "WSFFieldOrderIntroductionVM.h"
#import "WSFFieldIntroductionView.h"

@interface WSFFieldOrderIntroductionView ()

// -----初始化数据
@property (nonatomic, assign) WSFFieldOrderIntroductionViewType currentPlaygroundOrderIntroductionViewType;
@property (nonatomic, strong) WSFFieldOrderIntroductionVM *currentPlaygroundOrderIntroductionVM;

@property (nonatomic, strong) UIButton *skipBtn;
@property (nonatomic, strong) UILabel *skipLabel;
@property (nonatomic, strong) UILabel *setMealPriceLabel;
@property (nonatomic, strong) UILabel *setMealPriceNumLabel;
@property (nonatomic, strong) UILabel *ticketLabel;
@property (nonatomic, strong) UILabel *ticketNumLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *totlePriceLabel;
@property (nonatomic, strong) UILabel *totlePriceNumLabel;
@property (nonatomic, strong) UILabel *prontPriceLabel;
@property (nonatomic, strong) UILabel *prontPriceNumLabel;
@property (nonatomic, strong) WSFFieldIntroductionView *playgroundIntroductionView;

@end

@implementation WSFFieldOrderIntroductionView

- (instancetype)initWithPlaygroundOrderIntroductionVM:(WSFFieldOrderIntroductionVM *)playgroundOrderIntroductionVM playgroundOrderIntroductionViewType:(WSFFieldOrderIntroductionViewType)playgroundOrderIntroductionViewType {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.currentPlaygroundOrderIntroductionVM = playgroundOrderIntroductionVM;
        self.currentPlaygroundOrderIntroductionViewType = playgroundOrderIntroductionViewType;
        
        [self setupViewContent];
    }
    return self;
}

- (void)setupViewContent {
    if (self.currentPlaygroundOrderIntroductionViewType == WSFFieldOrderIntroductionViewType_Longitudinal) {
        // 跳转到空间详情的按钮
        self.skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.skipBtn setTitle:self.currentPlaygroundOrderIntroductionVM.name forState:UIControlStateNormal];
        [self.skipBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.skipBtn setTitleColor:[UIColor colorWithHexString:@"1a1a1a"] forState:UIControlStateNormal];
        [self.skipBtn setImage:[UIImage imageNamed:@"xiangyou"] forState:UIControlStateNormal];
        self.skipBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.skipBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        self.skipBtn.imageEdgeInsets = UIEdgeInsetsMake(11, SCREEN_WIDTH-20, 0, 0);
        self.skipBtn.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 20);
        [self.skipBtn addTarget:self action:@selector(skipToSpaceDetailVC) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.skipBtn];
        [self.skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, HeightForFontSize(16)+20));
        }];
    }else {
        self.skipLabel = [[UILabel alloc] init];
        self.skipLabel.font = SYSTEMFONT_16;
        self.skipLabel.textColor = HEX_COLOR_0x1A1A1A;
        self.skipLabel.text = self.currentPlaygroundOrderIntroductionVM.name;
        [self addSubview:self.skipLabel];
        [self.skipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 35));
        }];
    }
    
    // 大场地简介图
    if (self.currentPlaygroundOrderIntroductionViewType == WSFFieldOrderIntroductionViewType_Longitudinal) {
        self.playgroundIntroductionView = [[WSFFieldIntroductionView alloc] initWithPlaygroundIntroductionVM:self.currentPlaygroundOrderIntroductionVM.playgroundIntroductionVM playgroundIntroductionViewType:WSFFieldIntroductionViewType_Longitudinal];
        [self addSubview:self.playgroundIntroductionView];
        [self.playgroundIntroductionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.skipBtn.mas_bottom).offset(0);
            make.left.right.equalTo(self);
        }];
    }else {
        self.playgroundIntroductionView = [[WSFFieldIntroductionView alloc] initWithPlaygroundIntroductionVM:self.currentPlaygroundOrderIntroductionVM.playgroundIntroductionVM playgroundIntroductionViewType:WSFFieldIntroductionViewType_Transverse];
        [self addSubview:self.playgroundIntroductionView];
        [self.playgroundIntroductionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.skipLabel.mas_bottom).offset(0);
            make.left.right.equalTo(self);
        }];
    }
    
    // 套餐价格
    self.setMealPriceLabel = [[UILabel alloc] init];
    self.setMealPriceLabel.font = SYSTEMFONT_14;
    self.setMealPriceLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.setMealPriceLabel.text = self.currentPlaygroundOrderIntroductionVM.setMealString;
    [self addSubview:self.setMealPriceLabel];
    [self.setMealPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.playgroundIntroductionView.mas_bottom).offset(10);
    }];
    
    self.setMealPriceNumLabel = [[UILabel alloc] init];
    self.setMealPriceNumLabel.font = SYSTEMFONT_14;
    self.setMealPriceNumLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.setMealPriceNumLabel.text = self.currentPlaygroundOrderIntroductionVM.setMealNumString;
    [self addSubview:self.setMealPriceNumLabel];
    [self.setMealPriceNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.playgroundIntroductionView.mas_bottom).offset(10);
    }];
    
    // 优惠
    self.ticketLabel = [[UILabel alloc] init];
    self.ticketLabel.font = SYSTEMFONT_14;
    self.ticketLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.ticketLabel.text = self.currentPlaygroundOrderIntroductionVM.ticketString;
    [self addSubview:self.ticketLabel];
    [self.ticketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.setMealPriceLabel.mas_bottom).offset(10);
    }];
    
    self.ticketNumLabel = [[UILabel alloc] init];
    self.ticketNumLabel.font = SYSTEMFONT_14;
    self.ticketNumLabel.textColor = [UIColor redColor];
    self.ticketNumLabel.text = self.currentPlaygroundOrderIntroductionVM.ticketNumString;
    [self addSubview:self.ticketNumLabel];
    [self.ticketNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.setMealPriceLabel.mas_bottom).offset(10);
    }];
    
    // 分割线
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"cccccc" alpha:0.5];
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ticketLabel.mas_bottom).offset(10);
        make.top.mas_equalTo(self.setMealPriceLabel.mas_bottom).offset(10).priority(250);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 1));
    }];
    
    // 总价
    self.totlePriceNumLabel = [[UILabel alloc] init];
    self.totlePriceNumLabel.font = SYSTEMFONT_14;
    self.totlePriceNumLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.totlePriceNumLabel.text = self.currentPlaygroundOrderIntroductionVM.totelNumString;
    [self addSubview:self.totlePriceNumLabel];
    [self.totlePriceNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(10);
    }];
    
    self.totlePriceLabel = [[UILabel alloc] init];
    self.totlePriceLabel.font = SYSTEMFONT_14;
    self.totlePriceLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.totlePriceLabel.text = self.currentPlaygroundOrderIntroductionVM.totelString;
    [self addSubview:self.totlePriceLabel];
    [self.totlePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.totlePriceNumLabel.mas_left).offset(-5);
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(10);
    }];
    
    // 定金
    self.prontPriceNumLabel = [[UILabel alloc] init];
    self.prontPriceNumLabel.font = SYSTEMFONT_14;
    self.prontPriceNumLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.prontPriceNumLabel.text = self.currentPlaygroundOrderIntroductionVM.prontNumString;
    [self addSubview:self.prontPriceNumLabel];
    [self.prontPriceNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.totlePriceLabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
    
    self.prontPriceLabel = [[UILabel alloc] init];
    self.prontPriceLabel.font = SYSTEMFONT_14;
    self.prontPriceLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.prontPriceLabel.text = self.currentPlaygroundOrderIntroductionVM.prontString;
    [self addSubview:self.prontPriceLabel];
    [self.prontPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.prontPriceNumLabel.mas_left).offset(-5);
        make.top.mas_equalTo(self.totlePriceLabel.mas_bottom).offset(10);
    }];
    
    if ([self.currentPlaygroundOrderIntroductionVM.ticketNumString hasPrefix:@"不享优惠"]) {
        [self.ticketLabel removeFromSuperview];
        [self.ticketNumLabel removeFromSuperview];
        [self layoutIfNeeded];
    }
}

- (void)skipToSpaceDetailVC {
    
    if ([_delegate respondsToSelector:@selector(delegate_skipToSpaceDetailViewController)]) {
        [_delegate delegate_skipToSpaceDetailViewController];
    }
}

@end
