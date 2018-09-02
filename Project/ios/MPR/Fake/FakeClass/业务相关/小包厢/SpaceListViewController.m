//
//  SpaceListViewController.m
//  WinShare
//
//  Created by QIjikj on 2017/5/2.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "SpaceListViewController.h"
#import "MineViewController.h"
#import "SpaceMessageTView.h"
#import "BaiduMapVC.h"
#import "SpaceDataVM.h"
#import "SpaceMessageModel.h"
#import "SpaceModel.h"
#import "WSAboutVM.h"
#import "MineMessageVM.h"
#import "MapPositionManager.h"
#import "WSAlertAppVersionMethod.h"
#import "WSFSpaceListMapManager.h"
#import "WSFScreenReminderView.h"
#import "AppDelegate.h"
#import "TheLoginVC.h"
#import "WSFButton+HSF_Composition.h"
@interface SpaceListViewController ()

@property (nonatomic, strong) SpaceMessageTView *spaceMessageTV;    //展示空间列表
@property (nonatomic, strong) NSMutableArray *spaceMessageArray;    //展示空间列表数据的数组
@property (nonatomic, strong) BaiduMapVC *mapVC;                    //地图View
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSString *positionStr;
@property (nonatomic, assign) double currentLongitude;              //当前选择的纬度
@property (nonatomic, assign) double currentLatitude;               //当前选择的经度
@property (nonatomic, copy) NSString *currentTime;                  //当前选择的预定时间
@property (nonatomic, copy) NSNumber *currentDuration;              //当前选择的预定时长
@property (nonatomic, copy) NSNumber *currentMinPeople;             //当前选择的最少人数
@property (nonatomic, copy) NSNumber *currentMaxPeople;             //当前选择的最多人数
@property (nonatomic, assign) NSInteger currentPageIndex;           //网络请求数据的当前页数
@property (nonatomic, assign) NSInteger currentPageSize;            //网络请求数据的每页数据条数
@property (nonatomic, strong) WSFButton *titleBtn;

@property (nonatomic, copy) UIImageView *locateFailure;
@property (nonatomic, strong) UIButton *relocationButton;

@property (nonatomic, strong) UIView *noNetView;

@end

@implementation SpaceListViewController

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
    _currentPageIndex = 1;
    _currentPageSize = 10;
    
    // 更新当前登录用户的身份
    [self getMineIdentify];
  
    // 验证定位功能
    [self ryj_judgmentPositioning];
  
    [self setupNavigationContent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 获取信息
//    [self getAppPlatformPhoneNumberFromWeb];
  
    if (![self.view.subviews containsObject:[WSFSpaceListMapManager shareManager].reminderView]) {
        [self.view addSubview:[WSFSpaceListMapManager shareManager].reminderView];
    }
    [WSFSpaceListMapManager shareManager].resetBlock = ^{
        /*需要从展示第一个数据开始*/
        [self.spaceMessageTV.mj_header beginRefreshing];
    };
}

#pragma mark - 网络请求
- (void)getSpaceListDataWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  @weakify(self);
  [[MapPositionManager sharedLocationManager] judgePositionWithBlock:^(BOOL isOpen) {
    @strongify(self);
    if (isOpen) {
      @weakify(self);
      [WSFSpaceListMapManager getConditionsSpaceListDataWithPageIndex:pageIndex pageSize:pageSize success:^(NSArray *spaceListArray) {
        @strongify(self);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (pageIndex == 1) {
          [self.spaceMessageArray removeAllObjects];
          RYJMJFooterResetNoMoreData(self.spaceMessageTV);
        }
        NSArray *spaceListModelArrayForPage = [SpaceMessageModel getModelArrayFromModelArray:spaceListArray];
        [self.spaceMessageArray addObjectsFromArray:spaceListModelArrayForPage];
        self.spaceMessageTV.spaceListArray = self.spaceMessageArray;
        [[WSFSpaceListMapManager shareManager] saveScreeningSpaceListArray:self.spaceMessageArray];
        RYJCommonMJRefreshEndRefreshing(self.spaceMessageTV, spaceListModelArrayForPage.count);
        if([self.view.subviews containsObject:_noNetView])[_noNetView removeFromSuperview];
      } failed:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        RYJMJEndRefreshing(self.spaceMessageTV);
        @weakify(self);
        BOOL showBool = (kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) && (self.spaceMessageTV.spaceListArray.count == 0);
        _noNetView = [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
          @strongify(self);
          [self getSpaceListDataWithPageIndex:pageIndex pageSize:pageSize];
        }];
      }];
    } else {
      [self presentViewController:self.alertVC animated:NO completion:nil];
      self.locateFailure.hidden = NO;
      self.relocationButton.hidden = NO;
      self.spaceMessageTV.hidden = YES;
      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }
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

// 每次重启需要更新当前登录用户的身份
- (void)getMineIdentify {
    if ([WSFUserInfo getToken]) {
        [MineMessageVM getMineIdentifyDataSuccess:^(NSInteger identifyNumber) {
            [WSFUserInfo saveIdentify:identifyNumber];
        } failed:^(NSError *error) {
            NSLog(@"获取当前登录用户的身份失败：%@", error);
        }];
    }
}

#pragma mark - 设置导航栏UI
- (void)setupNavigationContent {
      self.navigationItem.title = @"小包厢";
    //right按钮
    // 切换地图
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn setImage:[UIImage imageNamed:@"map"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *rightBtnView = [[UIView alloc]initWithFrame:rightBtn.frame];
    [rightBtnView addSubview:rightBtn];
    UIBarButtonItem * rightBarbutton = [[UIBarButtonItem alloc]initWithCustomView:rightBtnView];
    // 占位
    UIBarButtonItem *rightSpaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightSpaceBarButton.width = -10;
    // 筛选
    UIButton *selectingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectingBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    selectingBtn.frame = CGRectMake(0, 0, 44, 44);
    [selectingBtn setImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
    [selectingBtn addTarget:self action:@selector(clickSelectingButton:) forControlEvents:UIControlEventTouchUpInside];
    UIView *rightBtnView2 = [[UIView alloc]initWithFrame:selectingBtn.frame];
    [rightBtnView2 addSubview:selectingBtn];
    UIBarButtonItem * rightBarbutton2 = [[UIBarButtonItem alloc]initWithCustomView:rightBtnView2];
    self.navigationItem.rightBarButtonItems = @[rightSpaceBarButton, rightBarbutton, rightSpaceBarButton, rightBarbutton2];
}

#pragma mark - 列表重新获取数据并刷新界面
- (void)refreshListTableView
{
    [self.spaceMessageTV.mj_header beginRefreshing];
}


// 跳转地图按钮
- (void)clickRightButton:(UIButton *)btn {
    if (self.locateFailure.hidden == YES) {
        __weak typeof(self) weakSelf = self;
        [[WSFSpaceListMapManager shareManager] pushToMapVCFormVC:self mapVCBack:^(NSArray<SpaceMessageModel *> *listArray) {
            weakSelf.spaceMessageTV.spaceListArray = listArray;
            weakSelf.spaceMessageArray = [[NSMutableArray alloc] initWithArray:listArray];
            RYJMJFooterResetNoMoreData(weakSelf.spaceMessageTV);
            weakSelf.currentPageIndex = listArray.count % 10 + 1;
            [weakSelf.spaceMessageTV scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        }];
    }else {
        [self presentViewController:self.alertVC animated:NO completion:nil];
    }
}

// 筛选按钮
- (void)clickSelectingButton:(UIButton *)btn {
    
    [[WSFSpaceListMapManager shareManager] pushToScreenVCFormVC:self completeBlock:^{
        
        /*需要从展示第一个数据开始
         _currentPageIndex = 1;
         [self getSpaceListDataWithPageIndex:_currentPageIndex pageSize:_currentPageSize];*/

        [self.spaceMessageTV.mj_header beginRefreshing];
    }];
}

// 重定位
- (void)relocationButtonClick:(UIButton *)sender {
    [self ryj_judgmentPositioning];
}

#pragma mark - 私有方法
- (void)ryj_judgmentPositioning {
    [[MapPositionManager sharedLocationManager] judgePositionWithBlock:^(BOOL isOpen) {
        if (isOpen) {
                [[WSFSpaceListMapManager shareManager] saveCurrentCityName:@"杭州市"];
                [_titleBtn setTitle:@"杭州市" forState:UIControlStateNormal];
                // 定位开启状态下 获取数据
                self.locateFailure.hidden = YES;
                self.relocationButton.hidden = YES;
                self.spaceMessageTV.hidden = NO;
                [self getSpaceListDataWithPageIndex:_currentPageIndex pageSize:_currentPageSize];
                [self.view addSubview:[WSFSpaceListMapManager shareManager].reminderView];
        } else {
            [self presentViewController:self.alertVC animated:YES completion:nil];
            self.locateFailure.hidden = NO;
            self.relocationButton.hidden = NO;
            self.spaceMessageTV.hidden = YES;
        }
    }];
}

- (void)doBackAction {
    [[NSNotificationCenter defaultCenter] postNotificationName:WSFScreenResetNotification object:nil userInfo:nil];
    [super doBackAction];
}

#pragma mark - 懒加载
- (SpaceMessageTView *)spaceMessageTV {
    if (!_spaceMessageTV) {
        _spaceMessageTV = [[SpaceMessageTView alloc] init];
        _spaceMessageTV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
        [self.view addSubview:_spaceMessageTV];
        //下拉刷新
        __weak typeof(self) weakSelf = self;
        _spaceMessageTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _currentPageIndex = 1;
            [weakSelf getSpaceListDataWithPageIndex:_currentPageIndex pageSize:_currentPageSize];
        }];
        //上拉加载
        _spaceMessageTV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            _currentPageIndex++;
            [weakSelf getSpaceListDataWithPageIndex:_currentPageIndex pageSize:_currentPageSize];
        }];
    }
    return _spaceMessageTV;
}

- (NSMutableArray *)spaceMessageArray {
    if (!_spaceMessageArray) {
        _spaceMessageArray = [NSMutableArray array];
    }
    return _spaceMessageArray;
}


- (UIImageView *)locateFailure {
    if (!_locateFailure) {
        _locateFailure = [[UIImageView alloc] init];
        _locateFailure.image = [UIImage imageNamed:@"dingweishibai"];
        [self.view addSubview:_locateFailure];
        [_locateFailure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view.mas_centerY).mas_offset(-40);
            make.centerX.equalTo(self.view.mas_centerX);
        }];
    }
    return _locateFailure;
}

- (UIButton *)relocationButton {
    if (!_relocationButton) {
        _relocationButton = [[UIButton alloc] init];
        [_relocationButton setTitle:@"重新定位" forState:UIControlStateNormal];
        _relocationButton.titleLabel.font = SYSTEMFONT_14;
        [_relocationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_relocationButton setBackgroundColor:HEX_COLOR_0x2B84C6];
        _relocationButton.layer.cornerRadius = 17;
        _relocationButton.layer.masksToBounds = YES;
        [_relocationButton addTarget:self action:@selector(relocationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_relocationButton];
        [_relocationButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.locateFailure.mas_bottom).mas_offset(20);
            make.height.equalTo(@34);
            make.width.equalTo(@100);
        }];
    }
    return _relocationButton;
}


@end
