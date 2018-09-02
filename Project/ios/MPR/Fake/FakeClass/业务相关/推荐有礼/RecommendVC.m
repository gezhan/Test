//
//  RecommendVC.m
//  WinShare
//
//  Created by QIjikj on 2017/8/22.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "RecommendVC.h"
#import "RecommendRoleVC.h"
#import "RecommendVM.h"
#import "RecommendActivityModel.h"
#import <UMSocialCore/UMSocialCore.h>

@interface RecommendVC ()

@property (nonatomic, strong) RecommendActivityModel *recommendActivityModel;

@end

@implementation RecommendVC
#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationContent];
    
    [self getRecommendDataFromWeb];
    
}

#pragma mark - 获取网络数据-推荐有礼的活动数据
- (void)getRecommendDataFromWeb
{
    
    [RecommendVM getRecommendDataSuccess:^(NSDictionary *recommendData) {
        
        NSLog(@"%@", recommendData);
        self.recommendActivityModel = [RecommendActivityModel modelFromDict:recommendData];
        [self setupViewContent];
        
    } failed:^(NSError *error) {
        
        NSLog(@"%@", error);
        
        
        BOOL showBool = (kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]);
        [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
            
            [self getRecommendDataFromWeb];
        }];
        
    }];
}

- (void)setupNavigationContent
{
    self.navigationItem.title = @"推荐有礼";
    
    //right按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 44);
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn setTitle:@"规则" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *rightBtnView = [[UIView alloc]initWithFrame:rightBtn.frame];
    [rightBtnView addSubview:rightBtn];
    UIBarButtonItem * rightBarbutton = [[UIBarButtonItem alloc]initWithCustomView:rightBtnView];
    
    UIBarButtonItem *rightSpaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightSpaceBarButton.width = -10;
    
    self.navigationItem.rightBarButtonItems = @[rightSpaceBarButton, rightBarbutton];
}

- (void)setupViewContent
{
    //活动背景图
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [bgImageView sd_setImageWithURL:[NSURL URLWithString:WSImgUrlWith(self.recommendActivityModel.activityPicture)] placeholderImage:[UIImage imageNamed:@"beijing"]];
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-171);
    }];

    // 活动背景图上面加一层半透明的白底
    CALayer *bgLayer = [CALayer layer];
    bgLayer.backgroundColor = [UIColor colorWithHexString:@"#ffffff" alpha:0.7].CGColor;
    bgLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 171);
    [bgImageView.layer addSublayer:bgLayer];
    //活动说明View
    UIView *messageBgView = [[UIView alloc] init];
    [messageBgView setBackgroundColor:[UIColor clearColor]];
    [bgImageView addSubview:messageBgView];
    [messageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView.mas_centerX);
        make.centerY.mas_equalTo(bgImageView.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH - 105);
        make.height.mas_equalTo(213);
    }];
    //活动说明文字
    UILabel *actionInfoLabel = [[UILabel alloc] init];
    actionInfoLabel.text = self.recommendActivityModel.activityTitle;
    actionInfoLabel.numberOfLines = 2;
    actionInfoLabel.textAlignment = NSTextAlignmentCenter;
    actionInfoLabel.font = [UIFont systemFontOfSize:16];
    [actionInfoLabel setTextColor:[UIColor colorWithHexString:@"#2b84c6"]];
    [messageBgView addSubview:actionInfoLabel];
    [actionInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(messageBgView.mas_top).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH - 105);
        make.centerX.mas_equalTo(messageBgView.mas_centerX);
    }];
    //面对面扫一扫
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"面对面扫一扫";
    tipLabel.font = [UIFont systemFontOfSize:14];
    [tipLabel setTextColor:[UIColor colorWithHexString:@"#1a1a1a"]];
    [messageBgView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(actionInfoLabel.mas_bottom).offset(32);
        make.centerX.mas_equalTo(messageBgView.mas_centerX);
    }];
    //二维码
    UIImageView *codeImageView = [[UIImageView alloc] init];
    codeImageView.image = [UIImage createQRCodeImageWithMessage:self.recommendActivityModel.activityCode size:120];
    [messageBgView addSubview:codeImageView];
    [codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(messageBgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    //更多方式
    UIView *moreTypeView = [[UIView alloc] init];
    [moreTypeView setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
    [self.view addSubview:moreTypeView];
    [moreTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgImageView.mas_bottom).offset(37);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH - 124);
        make.height.mas_equalTo(15);
    }];
    //
    UILabel *moreTypeLabel = [[UILabel alloc] init];
    moreTypeLabel.text = @"更多方式";
    moreTypeLabel.font = [UIFont systemFontOfSize:14];
    [moreTypeLabel setTextColor:[UIColor colorWithHexString:@"#1a1a1a"]];
    [moreTypeView addSubview:moreTypeLabel];
    [moreTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(moreTypeView.mas_centerX);
        make.centerY.mas_equalTo(moreTypeView.mas_centerY);
        make.width.mas_equalTo(60);
    }];
    //
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithHexString:@"#1a1a1a"];
    [moreTypeView addSubview: line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(moreTypeView.mas_left).offset(0);
        make.height.mas_equalTo(0.5);
        make.right.mas_equalTo(moreTypeLabel.mas_left).offset(-10);
        make.centerY.mas_equalTo(moreTypeView.mas_centerY);
    }];
    //
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithHexString:@"#1a1a1a"];
    [moreTypeView addSubview: line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(moreTypeLabel.mas_right).offset(10);
        make.height.mas_equalTo(0.5);
        make.centerY.mas_equalTo(moreTypeView.mas_centerY);
        make.right.mas_equalTo(moreTypeView.mas_right).offset(0);
    }];
    
    NSInteger gapW = (SCREEN_WIDTH - 160) / 5.0;

//    //分享到微信好友
//    UIButton *weixinBtn = [self factoryButtonWithImageName:@"weixinyou" text:@"微信好友"];
//    [weixinBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:weixinBtn];
//    [weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(gapW * 1 + 40 * 0);
//        make.top.mas_equalTo(moreTypeView.mas_bottom).offset(25);
//        make.size.mas_equalTo(CGSizeMake(40, 60));
//    }];
//    //分享到朋友圈
//    UIButton *pengyouquanBtn = [self factoryButtonWithImageName:@"pengyouquan" text:@"朋友圈"];
//    [pengyouquanBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:pengyouquanBtn];
//    [pengyouquanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(gapW * 2 + 40 * 1);
//        make.top.mas_equalTo(moreTypeView.mas_bottom).offset(25);
//        make.size.mas_equalTo(CGSizeMake(40, 60));
//    }];
    //分享到QQ
    UIButton *qqBtn = [self factoryButtonWithImageName:@"qq" text:@"QQ"];
    [qqBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqBtn];
    [qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gapW + 40 * 2);
        make.top.mas_equalTo(moreTypeView.mas_bottom).offset(25);
        make.size.mas_equalTo(CGSizeMake(40, 60));
    }];
    //分享到QQ空间
    UIButton *qqkongjianBtn = [self factoryButtonWithImageName:@"qqkongjian" text:@"QQ空间"];
    [qqkongjianBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqkongjianBtn];
    [qqkongjianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gapW * 2 + 40 * 3);
        make.top.mas_equalTo(moreTypeView.mas_bottom).offset(25);
        make.size.mas_equalTo(CGSizeMake(40, 60));
    }];
}

/** 分享按钮 */
- (void)shareAction:(UIButton *)btn
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString *descrString = [self.recommendActivityModel.shareContent componentsJoinedByString:@"\n"];
//    NSURL *shareImageUrl = [NSURL URLWithString:WSImgUrlWith(self.recommendActivityModel.sharePicture)];
//    UIImage *shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:shareImageUrl]];
  UIImage *shareImage = [UIImage imageNamed:@"logo"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.recommendActivityModel.shareTitle descr:descrString thumImage:shareImage];
    //设置网页地址
    shareObject.webpageUrl = self.recommendActivityModel.activityCode;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    UMSocialPlatformType selectedPlatform = UMSocialPlatformType_UnKnown;
    if ([btn.titleLabel.text isEqualToString:@"微信好友"]) {
        selectedPlatform = UMSocialPlatformType_WechatSession;
    }else if ([btn.titleLabel.text isEqualToString:@"朋友圈"]) {
        selectedPlatform = UMSocialPlatformType_WechatTimeLine;
    }else if ([btn.titleLabel.text isEqualToString:@"QQ"]) {
        selectedPlatform = UMSocialPlatformType_QQ;
    }else if ([btn.titleLabel.text isEqualToString:@"QQ空间"]) {
        selectedPlatform = UMSocialPlatformType_Qzone;
    }else {
    
    }
    [[UMSocialManager defaultManager] shareToPlatform:selectedPlatform messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            
            NSLog(@"************Share fail with error %@*********",error);
            
            if (error.code == 2008) {
                if (selectedPlatform == UMSocialPlatformType_WechatSession || selectedPlatform == UMSocialPlatformType_WechatTimeLine) {
                    [MBProgressHUD showMessage:@"请先安装微信"];
                }else if (selectedPlatform == UMSocialPlatformType_QQ || selectedPlatform == UMSocialPlatformType_Qzone) {
                    [MBProgressHUD showMessage:@"请先安装腾讯QQ"];
                }else {
                    [MBProgressHUD showMessage:@"请先安装相关应用"];
                }
            }
            
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

#pragma mark - 跳转到‘规则’界面
- (void)clickRightButton:(UIButton *)btn
{
    RecommendRoleVC *recommentRoleVC = [[RecommendRoleVC alloc] init];
    [self.navigationController pushViewController:recommentRoleVC animated:NO];
}

//工厂方法-图片在上，文字在下
- (UIButton *)factoryButtonWithImageName:(NSString *)imageName text:(NSString *)text
{
    UIButton *btnObj = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnObj setTitle:text forState:UIControlStateNormal];
    [btnObj.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [btnObj setTitleColor:[UIColor colorWithHexString:@"1a1a1a"] forState:UIControlStateNormal];
    [btnObj setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btnObj.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnObj.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    btnObj.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 20, 0);
    btnObj.titleEdgeInsets = UIEdgeInsetsMake(48, -40 + (40 - [HSMathod getSizeForText:text fontSize:10].width)/2.0, 0, -9);
    
    return btnObj;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
