//
//  WSFHomePageVC.m
//  WinShare
//
//  Created by GZH on 2018/1/10.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFHomePageVC.h"
#import "MineViewController.h"
#import "WSFSpaceListMapManager.h"
#import "WSFButton.h"
#import "TheLoginVC.h"
#import "WSFButton+HSF_Composition.h"
#import "WSFHomePageTableView.h"
#import "WSFHomePageTHView.h"
#import "WSFHomePageApi.h"
#import "WSFHomePageHotModel.h"
#import "WSFHomePageVM.h"
#import "WSFHomePageTVApi.h"
#import "WSFHomePageTVModel.h"
#import "WSFHomePageTVVM.h"
#import "MapPositionManager.h"
#import "WSFSpaceNoServiceView.h"
#import "WSFMineVC.h"

// 测试用
#import "WSFActivitySelectSpaceVC.h"
#import "WSFActivitySignUpVC.h"
#import "WSFActivityIntroduceListVC.h"

@interface WSFHomePageVC ()
/**  导航栏上的button */
@property (nonatomic, strong) WSFButton *titleBtn;
@property (nonatomic, strong) WSFHomePageTableView *homeTableView;
@property (nonatomic, strong) WSFHomePageTHView *tHeadView;

@property (nonatomic, assign) NSInteger currentPageIndex;           //网络请求数据的当前页数
@property (nonatomic, assign) NSInteger currentPageSize;            //网络请求数据的每页数据条数
@property (nonatomic, strong) WSFHomePageTVVM *tableViewVM;
@property (nonatomic, strong) UIImageView *locateFailure;
@property (nonatomic, strong) UIButton *relocationButton;
@property (nonatomic, strong) UIView *noNetView;
@property (nonatomic, strong) WSFSpaceNoServiceView *noServiceView;
@end

@implementation WSFHomePageVC

- (WSFHomePageTHView *)tHeadView {
    if (_tHeadView == nil) {
        _tHeadView = [[WSFHomePageTHView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 9 / 16 + 115 + 171 + 30)];
    }
    return _tHeadView;
}

- (WSFHomePageTableView *)homeTableView {
    if (_homeTableView == nil) {
        _homeTableView = [[WSFHomePageTableView alloc]init];
        _homeTableView.tableHeaderView = self.tHeadView;
        [self.view addSubview:_homeTableView];
        [_homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        //下拉刷新
        __weak typeof(self) weakSelf = self;
        _homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.currentPageIndex = 1;
            [weakSelf netRequestWithPageIndex:weakSelf.currentPageIndex pageSize:weakSelf.currentPageSize];
        }];
        //上拉加载
        _homeTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.currentPageIndex++;
            [weakSelf netRequestWithPageIndex:weakSelf.currentPageIndex pageSize:weakSelf.currentPageSize];
        }];
    }
    return _homeTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPageIndex = 1;
    _currentPageSize = 10;
  self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationContent];
    [self netRequestWithPageIndex:_currentPageIndex pageSize:_currentPageSize];
}

- (void)netRequestWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  @weakify(self);
  [[MapPositionManager sharedLocationManager] judgePositionWithBlock:^(BOOL isOpen) {
    @strongify(self);
    if (isOpen) {
      @weakify(self);
      [[MapPositionManager sharedLocationManager] getCoorinate:^(CLLocationCoordinate2D coordinate) {
//        NSLog(@"----------------------------------------%f-----%f", coordinate.latitude, coordinate.longitude);
        @strongify(self);
        if (kNetworkNotReachability) [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
        WSFHomePageApi *homeApi = [[WSFHomePageApi alloc]init];
        [homeApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
          NSData *jsonData = [request.responseObject dataUsingEncoding:NSUTF8StringEncoding];
          NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
          WSFHomePageHotModel *hotModeel = [MTLJSONAdapter modelOfClass:WSFHomePageHotModel.class fromJSONDictionary:messageDic[@"Data"] error:nil];
          WSFHomePageVM *homePageVM = [[WSFHomePageVM alloc]initWithHomePageModel:hotModeel];
          self.tHeadView.homePageVM = homePageVM;
          CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
          WSFHomePageTVApi *tVApi = [[WSFHomePageTVApi alloc]initWithTheContent:pageIndex pageSize:pageSize coor:coor];
          [tVApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSData *jsonData = [request.responseObject dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            WSFHomePageTVModel *homePageTVModel = [MTLJSONAdapter modelOfClass:WSFHomePageTVModel.class fromJSONDictionary:messageDic[@"Data"] error:nil];
            if (_currentPageIndex == 1) {
              [self.homeTableView.mj_header endRefreshing];
              [self.tableViewVM refershHomePageTModel:homePageTVModel coordinate:coordinate];
            }else {
              [self.homeTableView.mj_footer endRefreshing];
              [self.tableViewVM addHomePageTModel:homePageTVModel coordinate:coordinate];
            }
            self.homeTableView.tableViewVM = self.tableViewVM;
            if([self.view.subviews containsObject:_noNetView])[_noNetView removeFromSuperview];
          } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            RYJMJEndRefreshing(self.homeTableView);

            // 网络请求是否超时
            BOOL isRequestOutTime = [request.error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"];

            if (kNetworkNotReachability ||isRequestOutTime) {
              [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
            }

            @weakify(self);
            BOOL showBool = (kNetworkNotReachability || isRequestOutTime) && (self.homeTableView.tableViewVM.dataSource.count == 0);
            _noNetView = [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
              @strongify(self);
              [self netRequestWithPageIndex:pageIndex pageSize:pageSize];
            }];
          }];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
          RYJMJEndRefreshing(self.homeTableView);
          
          // 网络请求是否超时
          BOOL isRequestOutTime = [request.error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"];
          
          if (kNetworkNotReachability ||isRequestOutTime) {
            [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
          }
          
          @weakify(self);
          BOOL showBool = (kNetworkNotReachability || isRequestOutTime) && (self.homeTableView.tableViewVM.dataSource.count == 0);
          _noNetView = [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
            @strongify(self);
            [self netRequestWithPageIndex:pageIndex pageSize:pageSize];
          }];
        }];
      } address:nil error:nil];
    }else {
      //定位未开启
      [self switchCity:@""];
      [self presentViewController:self.alertVC animated:NO completion:nil];
      self.locateFailure.hidden = NO;
      self.relocationButton.hidden = NO;
      self.homeTableView.hidden = YES;
      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }
  }];
}

- (void)switchCity:(NSString *)cityName{
    [[WSFSpaceListMapManager shareManager] saveCurrentCityName:cityName];
    [self.titleBtn setTitle:cityName forState:UIControlStateNormal];
    [self.titleBtn hsf_layoutButtonWithEdgeInsetsStyle:WSFButtonEdgeInsetsType_ImageRight imageTitleSpace:2];
    if (cityName.length > 0) {
        self.navigationItem.titleView = self.titleBtn;
    }else {
        self.navigationItem.titleView = nil;
    }
}


// 重定位
- (void)relocationButtonClick:(UIButton *)sender {
    NSLog(@"--------重新定位" );
    [self resetPositioning];
}

- (void)resetPositioning {
    [[MapPositionManager sharedLocationManager] judgePositionWithBlock:^(BOOL isOpen) {
        if (isOpen) {
            [self switchCity:@"杭州市"];
            // 定位开启状态下 获取数据
            self.locateFailure.hidden = YES;
            self.relocationButton.hidden = YES;
            self.homeTableView.hidden = NO;
            [self.homeTableView.mj_header beginRefreshing];
        } else {
            [self presentViewController:self.alertVC animated:YES completion:nil];
            self.locateFailure.hidden = NO;
            self.relocationButton.hidden = NO;
            self.homeTableView.hidden = YES;
        }
    }];
}


#pragma mark - 设置导航栏UI
- (void)setupNavigationContent {
    //left按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn setImage:[UIImage imageNamed:@"me"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    UIView *leftBtnView = [[UIView alloc]initWithFrame:leftBtn.frame];
    [leftBtnView addSubview:leftBtn];
    UIBarButtonItem * leftBarbutton = [[UIBarButtonItem alloc]initWithCustomView:leftBtnView];
    UIBarButtonItem *leftSpaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftSpaceBarButton.width = -10;
    self.navigationItem.leftBarButtonItems = @[leftSpaceBarButton, leftBarbutton];
    
    //标题View
    self.titleBtn = [WSFButton buttonWithType:UIButtonTypeCustom];
    self.titleBtn.frame = CGRectMake(0, 0, 44, 44);
    [self.titleBtn setImage:[UIImage imageNamed:@"xiangxia_samll"] forState:UIControlStateNormal];
    [self.titleBtn setTitle:@"杭州市" forState:UIControlStateNormal];
    [self.titleBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.titleBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [self.titleBtn hsf_layoutButtonWithEdgeInsetsStyle:WSFButtonEdgeInsetsType_ImageRight imageTitleSpace:2];
    [self.titleBtn addTarget:self action:@selector(clickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.titleBtn;
}


#pragma mark - 点击事件
// 跳转我的设置
- (void)clickLeftButton:(UIButton *)btn {
    if ([WSFUserInfo getToken]) {
        WSFMineVC *mineVC = [[WSFMineVC alloc] init];
        [self.navigationController pushViewController:mineVC animated:NO];
    }else {
        TheLoginVC *vc = [[TheLoginVC alloc] init];
        vc.tempVC = self;
        [self.navigationController pushViewController:vc animated:NO];
    }
}

// 城市切换按钮
- (void)clickTitleButton:(UIButton *)btn {
    NSString *beforeSelectedcity = [WSFSpaceListMapManager shareManager].selectedCityName;
    [[WSFSpaceListMapManager shareManager] pushToCityVCFormVC:self cityVCBack:^(NSString * _Nonnull cityName) {
        if ([cityName isEqualToString:beforeSelectedcity]) return ;
        [_titleBtn setTitle:cityName forState:UIControlStateNormal];
        [_titleBtn hsf_layoutButtonWithEdgeInsetsStyle:WSFButtonEdgeInsetsType_ImageRight imageTitleSpace:2];
        if ([cityName isEqualToString:@"杭州市"]) {
            self.noServiceView.hidden = YES;
            self.homeTableView.hidden = NO;
        }else {
            self.homeTableView.hidden = YES;
            self.noServiceView.hidden = NO;
        }
    }];
}

#pragma mark -  懒加载
- (WSFHomePageTVVM *)tableViewVM {
    if (!_tableViewVM) {
        _tableViewVM = [[WSFHomePageTVVM alloc]init];
    }
    return _tableViewVM;
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
- (WSFSpaceNoServiceView *)noServiceView {
    if (!_noServiceView) {
        __weak typeof(self) weakSelf = self;
        _noServiceView = [[WSFSpaceNoServiceView alloc] initWithFrame:self.view.bounds clickBlock:^{
            NSLog(@"联系有个空间了解更多:yingxiang@yinglai.ren");
            weakSelf.noServiceView.hidden = YES;
            weakSelf.homeTableView.hidden = NO;
            [self switchCity:@"杭州市"];
            [weakSelf.homeTableView.mj_header beginRefreshing];
        }];
        [self.view addSubview:_noServiceView];
        [_noServiceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _noServiceView;
}




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
