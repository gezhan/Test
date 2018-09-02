//
//  WSFFieldVC.m
//  WinShare
//
//  Created by GZH on 2018/1/11.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldVC.h"
#import "WSFFieldTView.h"
#import "WSFFieldApi.h"
#import "WSFFieldModel.h"
#import "WSFFieldVM.h"
#import "MapPositionManager.h"
@interface WSFFieldVC ()
@property (nonatomic, strong) WSFFieldTView *playgroundTView;
@property (nonatomic, assign) NSInteger currentPageIndex;           //网络请求数据的当前页数
@property (nonatomic, assign) NSInteger currentPageSize;            //网络请求数据的每页数据条数
@property (nonatomic, strong) WSFFieldVM *playgroundVM;
@property (nonatomic, strong) UIView *noNetView;
@end

@implementation WSFFieldVC

- (WSFFieldTView *)playgroundTView {
    if (_playgroundTView == nil) {
        _playgroundTView = [[WSFFieldTView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        //下拉刷新
        __weak typeof(self) weakSelf = self;
        _playgroundTView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.currentPageIndex = 1;
            [weakSelf netRequestWithPageIndex:weakSelf.currentPageIndex pageSize:weakSelf.currentPageSize];
        }];
        //上拉加载
        _playgroundTView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.currentPageIndex++;
            [weakSelf netRequestWithPageIndex:weakSelf.currentPageIndex pageSize:weakSelf.currentPageSize];
        }];
    }
    return _playgroundTView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
    _currentPageIndex = 1;
    _currentPageSize = 10;
    [self netRequestWithPageIndex:_currentPageIndex pageSize:_currentPageSize];
}

- (void)setContentView {
    self.navigationItem.title = @"大场地";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.playgroundTView];
}

- (void)netRequestWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [[MapPositionManager sharedLocationManager] getCoorinate:^(CLLocationCoordinate2D coordinate) {
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    if (kNetworkNotReachability) [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
    WSFFieldApi *playgroundApi = [[WSFFieldApi alloc] initWithTheContent:pageIndex pageSize:pageSize coor:coor];
    [playgroundApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
      NSData *jsonData = [request.responseObject dataUsingEncoding:NSUTF8StringEncoding];
      NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
      WSFFieldModel *playgroundModel = [MTLJSONAdapter modelOfClass:WSFFieldModel.class fromJSONDictionary:messageDic[@"Data"] error:nil];
      if (_currentPageIndex == 1) {
        [self.playgroundTView.mj_header endRefreshing];
        [self.playgroundVM refershHomePageTModel:playgroundModel];
      }else {
        [self.playgroundTView.mj_footer endRefreshing];
        [self.playgroundVM addHomePageTModel:playgroundModel];
      }
      self.playgroundTView.playgroundVM = self.playgroundVM;
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
      [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
      RYJMJEndRefreshing(self.playgroundTView);
      
      // 网络请求是否超时
      BOOL isRequestOutTime = [request.error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"];
      
      if (kNetworkNotReachability ||isRequestOutTime) {
        [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
      }
      
      @weakify(self);
      BOOL showBool = (kNetworkNotReachability || isRequestOutTime) && (self.playgroundTView.playgroundVM.dataSource.count == 0);
      _noNetView = [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
        @strongify(self);
        [self netRequestWithPageIndex:_currentPageIndex pageSize:_currentPageSize];
      }];
    }];
  } address:nil error:nil];
}

#pragma mark -  懒加载
- (WSFFieldVM *)playgroundVM {
    if (!_playgroundVM) {
        _playgroundVM = [[WSFFieldVM alloc] init];
    }
    return _playgroundVM;
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
