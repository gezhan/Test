//
//  MineViewController.m
//  WinShare
//
//  Created by QIjikj on 2017/5/2.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "MineViewController.h"
#import "MineTView.h"
#import "PasswordModel.h"
#import "MineMessageVM.h"// 我的设置的VM
#import "WSFPersonalSetUpVC.h"// 个人设置

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupBackgroundView];
    
    [self setupMenuTableViewContent]; 
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //导航栏背景图片--该界面需要特殊展示
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"background_long_top"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //导航栏背景图片--恢复到统一状态
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"background_blue_top"] forBarMetrics:UIBarMetricsDefault];
}

- (void)setupBackgroundView
{
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 101)];
    bgView.userInteractionEnabled = YES;
    bgView.image = [UIImage imageNamed:@"background_long_under"];
    [self.view addSubview:bgView];
    
    // 圆形的logo
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60)/2, 0, 60, 60)];
    logoView.image = [UIImage imageNamed:@"logo_yuan"];
    logoView.userInteractionEnabled = YES;
    [bgView addSubview:logoView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personalSetUpAction)];
    [logoView addGestureRecognizer:tap];
    
    // 用户的电话号码
    UILabel *photoNum = [[UILabel alloc] init];
    photoNum.text = [WSFUserInfo getPhone];
    [photoNum setTextColor:[UIColor colorWithHexString:@"ffffff"]];
    [photoNum setFont:[UIFont systemFontOfSize:14]];
    [bgView addSubview:photoNum];
    [photoNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.mas_equalTo(logoView.mas_bottom).offset(10);
    }];
    
    // 开锁按钮-进入开锁列表
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanBtn setImage:[UIImage imageNamed:@"kaisuo"] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:scanBtn];
    [scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 27));
        make.left.mas_equalTo(logoView.mas_right).offset(50);
        make.top.mas_equalTo(3);
    }];
    
    // 开锁按钮下面的‘开锁’文字
    UILabel *scanLabel = [[UILabel alloc] init];
    scanLabel.text = @"开锁";
    [scanLabel setTextColor:[UIColor colorWithHexString:@"ffffff"]];
    [scanLabel setFont:[UIFont systemFontOfSize:14]];
    [bgView addSubview:scanLabel];
    [scanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scanBtn.mas_bottom).offset(10);
        make.centerX.equalTo(scanBtn);
    }];

}

//展示各种选项的tableview
- (void)setupMenuTableViewContent
{
    MineTView *mineTV = [[MineTView alloc] initWithFrame:CGRectMake(0, 101, SCREEN_WIDTH, SCREEN_HEIGHT-101-64) style:UITableViewStylePlain];
    [self.view addSubview:mineTV];
}

//开锁按钮
- (void)scanAction
{
//    UnlockListViewController *unlockListVC = [[UnlockListViewController alloc] init];
//    [self.navigationController pushViewController:unlockListVC animated:NO];
}

//个人设置
- (void)personalSetUpAction
{
    WSFPersonalSetUpVC *personalVC = [[WSFPersonalSetUpVC alloc]init];
    [self.navigationController pushViewController:personalVC animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
