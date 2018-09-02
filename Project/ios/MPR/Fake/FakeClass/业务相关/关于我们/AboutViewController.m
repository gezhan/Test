//
//  AboutViewController.m
//  WinShare
//
//  Created by GZH on 2017/5/3.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutTView.h"
#import "WSAboutVM.h"

@interface AboutViewController ()

@property (nonatomic, strong) AboutTView *aboutTableView;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"关于我们";
    
    [self setupViewContent];
    
    [self getAppPlatformPhoneNumberFromWeb];
}

- (void)getAppPlatformPhoneNumberFromWeb
{
    @weakify(self);
    [WSAboutVM getAppPlatformPhoneNumberSuccess:^(NSString *appPlatformPhone) {
        @strongify(self);
      [WSFAppInfo saveTelephone:appPlatformPhone];
        self.aboutTableView.appPlatformPhoneNumber = appPlatformPhone;
        
    } failed:^(NSError *error) {
        NSLog(@"获取app平台客服电话失败：%@", error);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    //导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"background_long_top"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"background_blue_top"] forBarMetrics:UIBarMetricsDefault];
}

- (void)setupViewContent
{
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 101)];
    bgView.image = [UIImage imageNamed:@"background_long_under"];
    [self.view addSubview:bgView];
    
//    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-42)/2, 0, 42, 42)];
//    logoView.image = [UIImage imageNamed:@"logo_white"];
//    [bgView addSubview:logoView];
//
    //app应用信息的获取字典类型
    NSDictionary * dicInfo =[[NSBundle mainBundle] infoDictionary];
    //当前应用名称
    NSString * appNameStr =[dicInfo objectForKey:@"CFBundleDisplayName"];
    //当前应用版本号
    NSString * appVersionStr =[dicInfo objectForKey:@"CFBundleShortVersionString"];
    
    UILabel *versionNum = [[UILabel alloc] init];
    versionNum.text = [NSString stringWithFormat:@"%@%@",appNameStr, appVersionStr];
    [versionNum setTextColor:[UIColor colorWithHexString:@"ffffff"]];
    [versionNum setFont:[UIFont systemFontOfSize:14]];
    [bgView addSubview:versionNum];
    [versionNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.mas_equalTo(bgView.mas_bottom).offset(-30);
    }];
    
    self.aboutTableView = [[AboutTView alloc] initWithFrame:CGRectMake(0, bgView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-101-64) style:UITableViewStylePlain];
    [self.view addSubview:self.aboutTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
