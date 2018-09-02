//
//  AlertVersionView.m
//  WinShare
//
//  Created by GZH on 2017/8/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "AlertVersionView.h"
#import "WSAppVersionModel.h"

typedef void(^BtnBlock)();

@interface AlertVersionView ()<UITextViewDelegate>

@property (nonatomic, copy) BtnBlock block1;
@property (nonatomic, copy) BtnBlock block2;

@end

@implementation AlertVersionView

- (instancetype)initWithFrame:(CGRect)frame versionInfo:(WSAppVersionModel *)versionInfo block1:(void(^)())block1 block2:(void(^)())block2
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupViewContent2WithVersionInfo:versionInfo];
        [self setupBlock1:block1 block2:block2];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame versionInfo:(WSAppVersionModel *)versionInfo block1:(void(^)())block1
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupViewContent1WithVersionInfo:versionInfo];
        [self setupBlock1:nil block2:block1];
    }
    return self;
}

- (void)setupViewContent2WithVersionInfo:(WSAppVersionModel *)versionInfo
{
    //白色的背景
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 10;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.mas_top);
        make.height.mas_equalTo(self);
        make.width.mas_equalTo(self);
    }];
    //下载图标
    UIImageView *downImageView = [[UIImageView alloc] init];
    downImageView.image = [UIImage imageNamed:@"xiazai"];
    [self addSubview:downImageView];
    [downImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top).offset(15);
    }];
    //更新提醒文字
    UILabel *remindLabel = [[UILabel alloc] init];
    remindLabel.text = @"软件更新提醒";
    remindLabel.font = [UIFont systemFontOfSize:14];
    remindLabel.textColor = [UIColor colorWithHexString:@"#2b84c6"];
    [self addSubview:remindLabel];
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(downImageView.mas_centerX);
        make.top.mas_equalTo(downImageView.mas_bottom).offset(8);
    }];
    //新特性标识
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.text = @"新版特性：";
    detailLabel.font = [UIFont systemFontOfSize:14];
    detailLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
    [self addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(remindLabel.mas_bottom).offset(15);
    }];
    //新特性文字
    UITextView *detailTextView = [[UITextView alloc] init];
    detailTextView.delegate = self;
    detailTextView.userInteractionEnabled = YES;
    [self addSubview:detailTextView];
    //新特性文字--富文本设置
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    detailTextView.attributedText =[[NSAttributedString alloc] initWithString: versionInfo.iteration attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.f], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#1a1a1a"], NSParagraphStyleAttributeName: paragraphStyle}];
    //新特性文字--约束关系
    [detailTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.top.mas_equalTo(detailLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(123);//153
    }];
    //下次再说按钮
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"下次再说" forState:UIControlStateNormal];
    [nextBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [nextBtn setTitleColor:[UIColor colorWithHexString:@"#1a1a1a"] forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"tuoyuan_black"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((SCREEN_WIDTH - 80 - 190)/3);
        make.top.mas_equalTo(detailTextView.mas_bottom).offset(13);
        make.size.mas_equalTo(CGSizeMake(95, 35));
    }];
    //立即更新按钮
    UIButton *immediateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [immediateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
    [immediateBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [immediateBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [immediateBtn setBackgroundImage:[UIImage imageNamed:@"anniu_blue_small"] forState:UIControlStateNormal];
    [immediateBtn addTarget:self action:@selector(immediateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:immediateBtn];
    [immediateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nextBtn.mas_right).offset((SCREEN_WIDTH - 80 - 190)/3);
        make.top.mas_equalTo(detailTextView.mas_bottom).offset(13);
        make.size.mas_equalTo(CGSizeMake(95, 35));
    }];
}

- (void)setupViewContent1WithVersionInfo:(WSAppVersionModel *)versionInfo
{
    //白色的背景
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 10;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.mas_top);
        make.height.mas_equalTo(self);
        make.width.mas_equalTo(self);
    }];
    //下载图标
    UIImageView *downImageView = [[UIImageView alloc] init];
    downImageView.image = [UIImage imageNamed:@"xiazai"];
    [self addSubview:downImageView];
    [downImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top).offset(15);
    }];
    //更新提醒文字
    UILabel *remindLabel = [[UILabel alloc] init];
    remindLabel.text = @"软件更新提醒";
    remindLabel.font = [UIFont systemFontOfSize:14];
    remindLabel.textColor = [UIColor colorWithHexString:@"#2b84c6"];
    [self addSubview:remindLabel];
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(downImageView.mas_centerX);
        make.top.mas_equalTo(downImageView.mas_bottom).offset(8);
    }];
    //新特性标识
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.text = @"新版特性：";
    detailLabel.font = [UIFont systemFontOfSize:14];
    detailLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
    [self addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(remindLabel.mas_bottom).offset(15);
    }];
    //新特性文字
    UITextView *detailTextView = [[UITextView alloc] init];
    detailTextView.delegate = self;
    detailTextView.userInteractionEnabled = YES;
    [self addSubview:detailTextView];
    //新特性文字--富文本设置
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    detailTextView.attributedText =[[NSAttributedString alloc] initWithString: versionInfo.iteration attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.f], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#1a1a1a"], NSParagraphStyleAttributeName: paragraphStyle}];
    //新特性文字--约束关系
    [detailTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.top.mas_equalTo(detailLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(123);//153
    }];
    //一条分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self);
        make.top.mas_equalTo(detailTextView.mas_bottom).offset(13);
        make.height.mas_equalTo(1);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    //立即更新按钮
    UIButton *immediateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [immediateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
    [immediateBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [immediateBtn setTitleColor:[UIColor colorWithHexString:@"#2b84c6"] forState:UIControlStateNormal];
    [immediateBtn addTarget:self action:@selector(immediateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:immediateBtn];
    [immediateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(1);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(35);
    }];
}

- (void)setupBlock1:(void(^)())block1 block2:(void(^)())block2
{
    _block1 = block1;
    _block2 = block2;
}

- (void)nextBtnAction
{
    if (_block1) {
        self.block1();
    }
}

- (void)immediateBtnAction
{
    if (_block2) {
        self.block2();
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

@end
