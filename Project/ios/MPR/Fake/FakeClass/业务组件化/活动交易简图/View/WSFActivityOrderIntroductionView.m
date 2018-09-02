//
//  WSFActivityOrderIntroductionView.m
//  WinShare
//
//  Created by ZWL on 2018/3/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityOrderIntroductionView.h"
#import "WSFActivityOrderIntroductionVM.h"
#import "WSFActivityIntroductionView.h"
#import "Masonry.h"

@interface WSFActivityOrderIntroductionView ()

// -----初始化数据
@property (nonatomic, assign) WSFActivityOrderIntroductionViewType currentActivityOrderIntroductionViewType;
@property (nonatomic, strong) WSFActivityOrderIntroductionVM *currentActivityOrderIntroductionVM;

@property (nonatomic, strong) UIButton *skipBtn;
@property (nonatomic, strong) UILabel *skipLabel;

@property (nonatomic, strong) WSFActivityIntroductionView *activityIntroductionView;

@end

@implementation WSFActivityOrderIntroductionView

- (instancetype)initWithActivityOrderIntroductionVM:(WSFActivityOrderIntroductionVM *)activityOrderIntroductionVM activityOrderIntroductionViewType:(WSFActivityOrderIntroductionViewType)activityOrderIntroductionViewType {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.currentActivityOrderIntroductionViewType = activityOrderIntroductionViewType;
        self.currentActivityOrderIntroductionVM = activityOrderIntroductionVM;
        
        [self setupViewContent];
    }
    return self;
}

- (void)setupViewContent {
    if (self.currentActivityOrderIntroductionViewType == WSFActivityOrderIntroductionViewType_Longitudinal) {
        // 跳转到空间详情的按钮
        self.skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.skipBtn setTitle:self.currentActivityOrderIntroductionVM.name forState:UIControlStateNormal];
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
        self.skipLabel.text = self.currentActivityOrderIntroductionVM.name;
        [self addSubview:self.skipLabel];
        [self.skipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 35));
        }];
    }
    
    // 大场地简介图
    if (self.currentActivityOrderIntroductionViewType == WSFActivityOrderIntroductionViewType_Longitudinal) {
        self.activityIntroductionView = [[WSFActivityIntroductionView alloc] initWithPlaygroundIntroductionVM:self.currentActivityOrderIntroductionVM.activityIntroductionVM playgroundIntroductionViewType:WSFActivityIntroductionViewType_Longitudinal];
        [self addSubview:self.activityIntroductionView];
        [self.activityIntroductionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.skipBtn.mas_bottom).offset(0);
            make.left.right.equalTo(self);
        }];
    }else {
        self.activityIntroductionView = [[WSFActivityIntroductionView alloc] initWithPlaygroundIntroductionVM:self.currentActivityOrderIntroductionVM.activityIntroductionVM playgroundIntroductionViewType:WSFActivityIntroductionViewType_Transverse];
        [self addSubview:self.activityIntroductionView];
        [self.activityIntroductionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.skipLabel.mas_bottom).offset(0);
            make.left.right.equalTo(self);
        }];
    }
    
    // 实付：¥60.00
    UILabel *realPayLabel = [[UILabel alloc] init];
    realPayLabel.text = self.currentActivityOrderIntroductionVM.realPayString;
    realPayLabel.font = [UIFont systemFontOfSize:18];
    realPayLabel.textColor = [UIColor blackColor];
    [self addSubview:realPayLabel];
    [realPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.activityIntroductionView.mas_bottom).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
    }];
    
    UILabel *realPayTitleLabel = [[UILabel alloc] init];
    realPayTitleLabel.text = self.currentActivityOrderIntroductionVM.realPayTitle;
    realPayTitleLabel.font = [UIFont systemFontOfSize:14];
    realPayTitleLabel.textColor = [UIColor blackColor];
    [self addSubview:realPayTitleLabel];
    [realPayTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(realPayLabel.mas_bottom).offset(0);
        make.right.mas_equalTo(realPayLabel.mas_left).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];

}

- (void)skipToSpaceDetailVC {
    
    if ([_delegate respondsToSelector:@selector(delegate_skipToSpaceDetailViewController)]) {
        [_delegate delegate_skipToSpaceDetailViewController];
    }
}
@end
