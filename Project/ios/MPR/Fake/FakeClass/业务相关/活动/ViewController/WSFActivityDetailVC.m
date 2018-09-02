//
//  WSFActivityDetailVC.m
//  WinShare
//
//  Created by GZH on 2018/3/2.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityDetailVC.h"
#import "WSFNavigationView.h"
#import "WSFActivityDetailUpView.h"
#import "WSFActivityDetailDownView.h"
#import "WSFActivitySignUpVC.h"
#import "WSFActivityDetailApi.h"
#import "WSFActivityDetailVM.h"
#import "WSFRPAppEventApiResModel.h"
#import "WSFShareView.h"

@interface WSFActivityDetailVC ()<SDCycleScrollViewDelegate, WSFNavigationViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *baseScrollView;
@property (nonatomic, strong) UILabel *currentNum;
@property (nonatomic, strong) WSFNavigationView *customNavgationView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) WSFActivityDetailVM *detailVM;
@property (nonatomic, strong) UIView *noNetView;

@property (nonatomic, strong) WSFRPAppEventApiResModel *resModel;
@end

@implementation WSFActivityDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor colorWithHexString:@"1a1a1a" alpha:0.4];
        statusBar.backgroundColor = [UIColor clearColor];
    }
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor clearColor];
    }
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
  
    [self netRequest];
}

- (void)netRequest {
  WSFActivityDetailApi *detailApi = [[WSFActivityDetailApi alloc] initWithTheEventId:_eventId];
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [detailApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    NSData *jsonData = [request.responseObject dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    self.resModel = [MTLJSONAdapter modelOfClass:WSFRPAppEventApiResModel.class fromJSONDictionary:messageDic[@"Data"] error:nil];
    WSFActivityDetailVM *detailVM = [[WSFActivityDetailVM alloc] initWithAppEventResMode:self.resModel];
    
    _detailVM = detailVM;
    [self setContentView];
    if([self.view.subviews containsObject:_noNetView])[_noNetView removeFromSuperview];
  } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    // 网络请求是否超时
//    BOOL isRequestOutTime = [request.error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"];
    if (kNetworkNotReachability) {
      [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
    }
    @weakify(self);
    BOOL showBool = (kNetworkNotReachability);
    _noNetView = [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
      @strongify(self);
      [self netRequest];
    }];
    //回退按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (isPhoneX) {
      leftBtn.frame = CGRectMake(0, 40, 30, 30);
    }else {
      leftBtn.frame = CGRectMake(0, 20, 30, 30);
    }
    leftBtn.backgroundColor = [UIColor colorWithHexString:@"#2483C3" alpha:0.5];
    leftBtn.layer.cornerRadius = 15;
    [leftBtn setImage:[UIImage imageNamed:@"Arrow-white"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(doBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
  }];
}


- (void)setContentView {
//    //报名按钮
//    UIButton *signUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    if (_detailVM.stateSign == 1 || _detailVM.stateSign == 3) {
//        [signUpBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithHexString:@"#cccccc"]] forState:UIControlStateNormal];
//        signUpBtn.userInteractionEnabled = NO;
//    }else if (_detailVM.stateSign == 2) {
//        [signUpBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithHexString:@"#2b84c6"]] forState:UIControlStateNormal];
//        signUpBtn.userInteractionEnabled = YES;
//    }
//    [signUpBtn setTitle:_detailVM.btnTitle forState:UIControlStateNormal];
//    [signUpBtn addTarget:self action:@selector(signUpAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:signUpBtn];
//    [signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.equalTo(self.view);
//        make.height.mas_equalTo(50);
//    }];
    //下层的scroolView
    self.baseScrollView = [[UIScrollView alloc] init];
    self.baseScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.baseScrollView.delegate = self;
    self.baseScrollView.scrollEnabled = YES;
    self.baseScrollView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    [self.view addSubview: self.baseScrollView];
    //contentView
    UIView *contentView = [[UIView alloc]init];
    [self.baseScrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.baseScrollView);
        make.width.equalTo(self.baseScrollView);
        make.bottom.equalTo(self.baseScrollView.mas_bottom);
    }];
    
    // 导航栏View
    self.customNavgationView = [[WSFNavigationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.customNavgationView.bgImageView.backgroundColor = [UIColor colorWithHexString:@"#3086C5"];
    self.customNavgationView.titleColor = [UIColor whiteColor];
    self.customNavgationView.leftBackgroundImage = @"Arrow-white";
//    self.customNavgationView.rightBackgroundImage = @"icon_share";
    self.customNavgationView.rightBackgroundImage = nil;
    self.customNavgationView.delegate = self;
    [self.view addSubview:self.customNavgationView];
    //轮播图片
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220) delegate:self placeholderImage:[UIImage imageNamed:@"logo_big_bg"]];
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    self.cycleScrollView.imageURLStringsGroup = _detailVM.photoArray;
    self.cycleScrollView.autoScrollTimeInterval = 4.0;
    [contentView addSubview:self.cycleScrollView];
    //当前显示的图片页数
    self.currentNum = [[UILabel alloc] init];
    self.currentNum.font = [UIFont systemFontOfSize:14];
    self.currentNum.textColor = [UIColor colorWithHexString:@"ffffff" alpha:1];
    if (self.cycleScrollView.imageURLStringsGroup.count > 0) {
        self.currentNum.text = [NSString stringWithFormat:@"1/%lu", (unsigned long)self.cycleScrollView.imageURLStringsGroup.count];
    }else {
        self.currentNum.text = [NSString stringWithFormat:@"0/%lu", (unsigned long)self.cycleScrollView.imageURLStringsGroup.count];
    }
    [self.cycleScrollView addSubview:self.currentNum];
    [self.currentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.cycleScrollView.mas_right).offset(-10);
        make.bottom.mas_equalTo(-10);
    }];
    
    WSFActivityDetailUpView *detailUpView = [[WSFActivityDetailUpView alloc]initWithVM:_detailVM];
    [contentView addSubview:detailUpView];
    [detailUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom);
        make.left.right.mas_equalTo(contentView);
    }];
    
    WSFActivityDetailDownView *detailDownView = [[WSFActivityDetailDownView alloc]initWithVM:_detailVM];
    [contentView addSubview:detailDownView];
    [detailDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_detailVM.introductionArray.count > 0) {
            make.top.mas_equalTo(detailUpView.mas_bottom).offset(15);
        }else {
            make.top.mas_equalTo(detailUpView.mas_bottom).offset(0);
        }
        make.left.right.mas_equalTo(contentView);
    }];
    
    //拨打电话
    UIButton *telephoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    telephoneBtn.backgroundColor = [UIColor whiteColor];
    [telephoneBtn setTitle:@"联系电话" forState:UIControlStateNormal];
    [telephoneBtn setTitleColor:[UIColor colorWithHexString:@"1a1a1a"] forState:UIControlStateNormal];
    [telephoneBtn setImage:[UIImage imageNamed:@"dianhua"] forState:UIControlStateNormal];
    telephoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    telephoneBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    telephoneBtn.imageEdgeInsets = UIEdgeInsetsMake(15, SCREEN_WIDTH-30, 0, 0);
    telephoneBtn.titleEdgeInsets = UIEdgeInsetsMake(15, -10, 0, 0);
    telephoneBtn.eventTimeInterval = 1;
    [telephoneBtn addTarget:self action:@selector(callPhoneAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:telephoneBtn];
    [telephoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.mas_left);
        make.right.mas_equalTo(contentView.mas_right);
        make.top.mas_equalTo(detailDownView.mas_bottom).offset(15);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(contentView.mas_bottom).offset(-15);
    }];
}

/**  报名 */
//- (void)signUpAction {
//    NSLog(@"--------报名" );
//    WSFActivitySignUpVC *activitySignUpVC = [[WSFActivitySignUpVC alloc] init];
//    activitySignUpVC.activityPrice = _detailVM.price;
//    activitySignUpVC.activityId = _eventId;
//    activitySignUpVC.roomId = self.resModel.roomId;
//    [self.navigationController pushViewController:activitySignUpVC animated:NO];
//}

/**  打电话-- 联系商家 */
- (void)callPhoneAction {
    [HSMathod callPhoneWithNumber:_detailVM.tel];
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    self.currentNum.text = [NSString stringWithFormat:@"%ld/%ld", (long)index+1, (long)cycleScrollView.imageURLStringsGroup.count];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = self.baseScrollView.contentOffset;
    if (point.y < 0) {
        //不可以向下滑动
        self.baseScrollView.contentOffset = CGPointMake(0, 0);
    }
    
    if (scrollView.contentOffset.y <= (220-64)) {
        self.customNavgationView.bgImageView.alpha = scrollView.contentOffset.y / (220-64);
        self.customNavgationView.leftBackgroundImage = @"Arrow-white";
//        self.customNavgationView.rightBackgroundImage = @"icon_share";
        self.customNavgationView.titleName = @"";
        self.customNavgationView.titleColor = [UIColor whiteColor];
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }else{
        self.customNavgationView.bgImageView.alpha = 1;
        self.customNavgationView.leftBackgroundImage = @"Arrow-white";
//        self.customNavgationView.rightBackgroundImage = @"icon_share";
//        self.customNavgationView.titleName = self.spaceNameLabel.text;
        self.customNavgationView.titleColor = [UIColor whiteColor];
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}

#pragma mark - WSFNavigationdelegate
- (void)navigationBarButtonLeftAction {
    [self doBackAction];
}

//- (void)navigationBarButtonRightAction {
//    WSFShareMessageModel *model = [[WSFShareMessageModel alloc] init];
//    model.shareTitle = @"我在这里发现了一个好地方，你也看看吧~";
//    model.shareDescr = @"面基、团建、见客户，妈妈再也不用担心我找不到好去处了！";
//    model.shareURL = _detailVM.roomShareUrl;
//    model.shareThumImage = [UIImage imageNamed:@"logo"];
//    model.shareReminder = @"分享可获得专属红包";
//    model.shareViewType = WSFShareViewType_Normal;
//    [WSFShareView showWithShareMessageModel:model];
//}

#pragma mark -  懒加载



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
