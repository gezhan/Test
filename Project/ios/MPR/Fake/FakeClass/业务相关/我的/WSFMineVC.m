//
//  WSFMineVC.m
//  WinShare
//
//  Created by QIjikj on 2018/2/3.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFMineVC.h"
#import "WSFMineTView.h"
#import "PasswordModel.h"
#import "MineMessageVM.h"// 我的设置的VM
#import "WSFPersonalSetUpVC.h"// 个人设置
#import "ChinaByteViewController.h"
#import "TicketViewController.h"
#import "WSFRPProfileInfoResApiModel.h"
#import "WSAboutVM.h"

@interface WSFMineVC ()

@property (nonatomic, strong) UIView *headInfoView;

@property (nonatomic, strong) UIButton *yBeiBtn;
@property (nonatomic, strong) UIButton *ticketBtn;

@end

@implementation WSFMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = HEX_COLOR_0xF5F5F5;
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self setupBackgroundView];
    
    [self getCurrentChinaByteDataFromWeb];
  
    [self getAppPlatformPhoneNumberFromWeb];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //导航栏背景图片--该界面需要特殊展示
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"WSFMine_Bg_Blue_Top"] resizingImageState] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //导航栏背景图片--恢复到统一状态
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"background_blue_top"] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - 获取网络数据
/** 获取当前赢贝余额及优惠券张数 */
- (void)getCurrentChinaByteDataFromWeb
{
    NSString *url = [NSString stringWithFormat:@"%@/api/profile/amount_coupon?Token=%@", BaseUrl, [WSFUserInfo getToken]];

    [WSFNetworkClient GET_Path:url completed:^(NSData *stringData, id JSONDict) {

        if ([JSONDict[@"Code"] isEqual:@0]) {

            WSFRPProfileInfoResApiModel *profileInfoResApiModel = [MTLJSONAdapter modelOfClass:[WSFRPProfileInfoResApiModel class] fromJSONDictionary:JSONDict[@"Data"] error:nil];

            [self.yBeiBtn setTitle:[NSString stringWithFormat:@"%0.2f", profileInfoResApiModel.yBei] forState:UIControlStateNormal];
            [self.ticketBtn setTitle:[NSString stringWithFormat:@"%ld", (long)profileInfoResApiModel.coupons ] forState:UIControlStateNormal];
        }else {
            if ([JSONDict[@"Message"] length] > 0) {
                [MBProgressHUD showMessage:JSONDict[@"Message"]];
            }
        }

    } failed:^(NSError *error) {

    }];
}


//获取APP平台的客服电话
- (void)getAppPlatformPhoneNumberFromWeb {
  [WSAboutVM getAppPlatformPhoneNumberSuccess:^(NSString *appPlatformPhone) {
    [WSFAppInfo saveTelephone:appPlatformPhone];
    NSLog(@"获取app平台客服电话成功：%@", appPlatformPhone);
  } failed:^(NSError *error) {
    NSLog(@"获取app平台客服电话失败：%@", error);
  }];
}


- (void)setupBackgroundView
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.userInteractionEnabled = YES;
    bgView.image = [[UIImage imageNamed:@"WSFMine_Bg_Blue_End"] resizingImageState];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 76));
    }];

    self.headInfoView.hidden = NO;
    
    [self setupMenuTableViewContent];
}

//展示各种选项的tableview
- (void)setupMenuTableViewContent
{
    WSFMineTView *mineTV = [[WSFMineTView alloc] initWithFrame:CGRectMake(0, 180, SCREEN_WIDTH, SCREEN_HEIGHT-180-64) style:UITableViewStylePlain];
    [self.view addSubview:mineTV];
}

//开锁按钮
//- (void)scanAction
//{
//    UnlockListViewController *unlockListVC = [[UnlockListViewController alloc] init];
//    [self.navigationController pushViewController:unlockListVC animated:NO];
//}

//个人设置
- (void)personalSetUpAction
{
    WSFPersonalSetUpVC *personalVC = [[WSFPersonalSetUpVC alloc]init];
    [self.navigationController pushViewController:personalVC animated:NO];
}

#pragma mark - 懒加载
- (UIView *)headInfoView {
    if (!_headInfoView) {
        _headInfoView = [[UIView alloc] init];
        _headInfoView.backgroundColor = [UIColor whiteColor];
        _headInfoView.layer.cornerRadius = 10.f;
        [self.view addSubview:_headInfoView];
        [_headInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).offset(22);
            make.left.mas_equalTo(self.view.mas_left).offset(10);
            make.width.mas_equalTo(SCREEN_WIDTH - 20);
        }];
        
        // 圆形的logo
        UIButton *logoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [logoBtn setImage:[UIImage imageNamed:@"WSFMine_UserLogo"] forState:UIControlStateNormal];
        [logoBtn addTarget:self action:@selector(personalSetUpAction) forControlEvents:UIControlEventTouchUpInside];
        [_headInfoView addSubview:logoBtn];
        [logoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(_headInfoView).offset(15);
            make.size.mas_equalTo(CGSizeMake(39, 39));
        }];
        
        // 用户的电话号码
        UIButton *photoBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        [photoBtn setTitle:[WSFUserInfo getPhone] forState:UIControlStateNormal];
        [photoBtn setTitleColor:HEX_COLOR_0x1A1A1A forState:UIControlStateNormal];
        [photoBtn.titleLabel setFont:SYSTEMFONT_14];
        [photoBtn addTarget:self action:@selector(personalSetUpAction) forControlEvents:UIControlEventTouchUpInside];
        [_headInfoView addSubview:photoBtn];
        [photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(logoBtn.mas_right).offset(12);
            make.centerY.mas_equalTo(logoBtn.mas_centerY);
        }];
        
        
//        // 开锁按钮-进入开锁列表
//        UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [scanBtn setImage:[UIImage imageNamed:@"WSFMine_KaiSuo"] forState:UIControlStateNormal];
//        [scanBtn addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
//        [_headInfoView addSubview:scanBtn];
//        [scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_headInfoView).offset(15);
//            make.right.mas_equalTo(_headInfoView.mas_right).offset(-15);
//            make.size.mas_equalTo(CGSizeMake(39, 39));
//        }];
        
        // 赢贝按钮
        self.yBeiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.yBeiBtn setTitle:@"0.00" forState:UIControlStateNormal];
        [self.yBeiBtn.titleLabel setFont:SYSTEMFONT_18];
        [self.yBeiBtn setTitleColor:HEX_COLOR_0xFF5959 forState:UIControlStateNormal];
        [self.yBeiBtn addTarget:self action:@selector(yBeiBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_headInfoView addSubview:self.yBeiBtn];
        [self.yBeiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headInfoView.mas_left).offset(65);
            make.top.mas_equalTo(logoBtn.mas_bottom).offset(20);
        }];
        
        // 赢贝
        UILabel *yBeiLabel = [[UILabel alloc] init];
        yBeiLabel.text = @"赢贝";
        [yBeiLabel setTextColor:HEX_COLOR_0x1A1A1A];
        [yBeiLabel setFont:[UIFont systemFontOfSize:14]];
        [_headInfoView addSubview:yBeiLabel];
        [yBeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.yBeiBtn.mas_bottom).offset(0);
            make.centerX.mas_equalTo(self.yBeiBtn.mas_centerX);
        }];
        
        // 优惠券按钮
        self.ticketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.ticketBtn setTitle:@"0" forState:UIControlStateNormal];
        [self.ticketBtn.titleLabel setFont:SYSTEMFONT_18];
        [self.ticketBtn setTitleColor:HEX_COLOR_0xFF5959 forState:UIControlStateNormal];
        [self.ticketBtn addTarget:self action:@selector(ticketBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_headInfoView addSubview:self.ticketBtn];
        [self.ticketBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_headInfoView.mas_right).offset(-65);
            make.top.mas_equalTo(logoBtn.mas_bottom).offset(20);
        }];
        
        // 优惠券
        UILabel *ticketLabel = [[UILabel alloc] init];
        ticketLabel.text = @"优惠券";
        [ticketLabel setTextColor:HEX_COLOR_0x1A1A1A];
        [ticketLabel setFont:[UIFont systemFontOfSize:14]];
        [_headInfoView addSubview:ticketLabel];
        [ticketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.ticketBtn.mas_bottom).offset(0);
            make.centerX.mas_equalTo(self.ticketBtn.mas_centerX);
            make.bottom.mas_equalTo(_headInfoView.mas_bottom).offset(-15);
        }];
    }
    return _headInfoView;
}

- (void)yBeiBtnAction {
    ChinaByteViewController *chinaByteVC = [[ChinaByteViewController alloc] init];
    [self.navigationController pushViewController:chinaByteVC animated:NO];
}

- (void)ticketBtnAction {
    TicketViewController *ticketVC = [[TicketViewController alloc] init];
    [self.navigationController pushViewController:ticketVC animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
