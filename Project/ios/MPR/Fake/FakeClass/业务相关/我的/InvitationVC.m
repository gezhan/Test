//
//  InvitationVC.m
//  WinShare
//
//  Created by QIjikj on 2017/7/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "InvitationVC.h"
#import "ShopDataVM.h"

@interface InvitationVC ()

@property (nonatomic, strong) UILabel *codeTypeLabel;//二维码的种类
@property (nonatomic, strong) UIImageView *codeImage;//二维码
@property (nonatomic, strong) UILabel *codeMessageLabel;//二维码说明



@end

@implementation InvitationVC

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupNavigationContent];
    
    [self getShopQRCodeStringFromWeb];

}

#pragma mark - 获取邀请二维码的网络数据
- (void)getShopQRCodeStringFromWeb
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [ShopDataVM getShopQRCodeMessageSuccess:^(NSString *QRCodeString) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self setupViewContentWithQRCodeString:QRCodeString];
        
    } failed:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"获取商铺邀请二维码信息失败：%@", error);
        
        
        BOOL showBool = (kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]);
        [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
            
            [self getShopQRCodeStringFromWeb];
        }];
        
    }];
}

#pragma mark - 基础界面的搭建
- (void)setupNavigationContent
{
    self.navigationItem.title = @"邀请";
}

- (void)setupViewContentWithQRCodeString:(NSString *)QRCodeString
{
    //二维码种类
    self.codeTypeLabel = [[UILabel alloc] init];
    self.codeTypeLabel.font = [UIFont systemFontOfSize:16];
    self.codeTypeLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.codeTypeLabel.text = @"商铺邀请二维码";
    [self.view addSubview:self.codeTypeLabel];
    [self.codeTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(133);
    }];
    //二维码
    UIImage *QRCodeImage = [UIImage createQRCodeImageWithMessage:QRCodeString size:SCREEN_WIDTH - 208];
    
    self.codeImage = [[UIImageView alloc] init];
    self.codeImage.image = QRCodeImage;
    [self.view addSubview:self.codeImage];
    [self.codeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 208, SCREEN_WIDTH - 208));
        make.top.mas_equalTo(self.codeTypeLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
    }];
    //二维码说明
    self.codeMessageLabel = [[UILabel alloc] init];
    self.codeMessageLabel.font = [UIFont systemFontOfSize:12];
    self.codeMessageLabel.textColor = [UIColor colorWithHexString:@"2b84c6"];
    self.codeMessageLabel.text = @"扫描后，将成为您的VIP用户";
    [self.view addSubview:self.codeMessageLabel];
    [self.codeMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(self.codeImage.mas_bottom).offset(20);
    }];

}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
