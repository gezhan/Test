//
//  WSFActivityListVC.m
//  WinShare
//
//  Created by QIjikj on 2018/2/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityListVC.h"
#import "WSFActivityListTV.h"
#import "MapPositionManager.h"
#import "WSFActivityListApi.h"
#import "WSFActivityLIstCarouselApi.h"
#import "WSFRPAppEventSearchQueryResModel.h"
#import "WSFActivityListVM.h"
#import "WSFRPCarouselSetApiModel.h"
#import "WSFActivityCarouselVM.h"

/**  临时 */
#import "WSFActivityHistoryVC.h"

@interface WSFActivityListVC ()<SDCycleScrollViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView; //轮播图
@property (nonatomic, strong) WSFActivityListTV *activityListTV;  //tableView

@property (nonatomic, assign) NSInteger currentPageIndex;           //网络请求数据的当前页数
@property (nonatomic, assign) NSInteger currentPageSize;            //网络请求数据的每页数据条数
@property (nonatomic, strong) WSFActivityListVM *listVM;
@property (nonatomic, strong) UIView *noNetView;
@property (nonatomic, strong) WSFActivityCarouselVM *carouselVM; //轮播图的VM
@end

@implementation WSFActivityListVC

- (WSFActivityListVM *)listVM {
    if (!_listVM) {
        _listVM = [[WSFActivityListVM alloc]init];
    }
    return _listVM;
}

- (WSFActivityListTV *)activityListTV {
    if (_activityListTV == nil) {
        _activityListTV = [[WSFActivityListTV alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
//        _activityListTV.tableHeaderView = self.cycleScrollView;
        [self.view addSubview:_activityListTV];
        [_activityListTV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
            if (_carouselVM.photosUrlArray.count == 0 || _carouselVM.photosUrlArray == nil) {
                make.top.equalTo(self.view).offset(-15);
            }
        }];
        //下拉刷新
        __weak typeof(self) weakSelf = self;
        _activityListTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.currentPageIndex = 1;
            [weakSelf netRequestWithPageIndex:weakSelf.currentPageIndex pageSize:weakSelf.currentPageSize];
        }];
        //上拉加载
        _activityListTV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.currentPageIndex++;
            [weakSelf netRequestWithPageIndex:weakSelf.currentPageIndex pageSize:weakSelf.currentPageSize];
        }];
    }
    return _activityListTV;
}

- (SDCycleScrollView *)cycleScrollView {
    if (_cycleScrollView == nil) {
        //轮播图片
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 9 / 16) delegate:self placeholderImage:[UIImage imageNamed:@"logo_big_bg"]];
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _cycleScrollView.imageURLStringsGroup = @[];
        _cycleScrollView.autoScrollTimeInterval = 4.0;
    }
    return _cycleScrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContentView];
    _currentPageIndex = 1;
    _currentPageSize = 10;
    [self netRequestWithPageIndex:_currentPageIndex pageSize:_currentPageSize];
}

- (void)netRequestWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  WSFActivityLIstCarouselApi *carouselApi = [[WSFActivityLIstCarouselApi alloc]init];
  [carouselApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
    NSData *jsonData = [request.responseObject dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSArray *carouselArray = [MTLJSONAdapter modelsOfClass:WSFRPCarouselSetApiModel.class fromJSONArray:messageDic[@"Data"] error:nil];
    WSFActivityCarouselVM *carouselVM = [[WSFActivityCarouselVM alloc]initWithCarouselModelArray:carouselArray];
    _carouselVM = carouselVM;
    [[MapPositionManager sharedLocationManager] getCoorinate:^(CLLocationCoordinate2D coordinate) {
      if (kNetworkNotReachability) [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
      WSFActivityListApi *listApi = [[WSFActivityListApi alloc]initWithTheContent:_currentPageIndex pageSize:_currentPageSize coor:coordinate];
      [listApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (_carouselVM.photosUrlArray.count > 0) {
          self.cycleScrollView.imageURLStringsGroup =  _carouselVM.photosUrlArray;
          self.activityListTV.tableHeaderView = self.cycleScrollView;
        }else {
          _activityListTV.tableHeaderView = [UIView new];
        }
        NSData *jsonData = [request.responseObject dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        WSFRPAppEventSearchQueryResModel *queryResModel = [MTLJSONAdapter modelOfClass:WSFRPAppEventSearchQueryResModel.class fromJSONDictionary:messageDic[@"Data"] error:nil];
        if (_currentPageIndex == 1) {
          [self.activityListTV.mj_header endRefreshing];
          [self.listVM refershActivityTModel:queryResModel];
        }else {
          [self.activityListTV.mj_footer endRefreshing];
          [self.listVM addActivityTModel:queryResModel];
        }
        self.activityListTV.listVM = self.listVM;
        
      } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
      }];
    } address:nil error:nil];
  } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    // 网络请求是否超时
    BOOL isRequestOutTime = [request.error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"];
    if (kNetworkNotReachability ||isRequestOutTime) {
      [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
    }
    @weakify(self);
    BOOL showBool = (kNetworkNotReachability || isRequestOutTime);
    _noNetView = [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
      @strongify(self);
      [self netRequestWithPageIndex:_currentPageIndex pageSize:_currentPageSize];
    }];
  }];
}

- (void)setupContentView {
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.navigationItem.title = @"活动";
    
    //right按钮
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame = CGRectMake(0, 0, 44, 44);
//    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    UIView *rightBtnView = [[UIView alloc]initWithFrame:rightBtn.frame];
//    [rightBtnView addSubview:rightBtn];
//    UIBarButtonItem * rightBarbutton = [[UIBarButtonItem alloc]initWithCustomView:rightBtnView];
//    UIBarButtonItem *rightSpaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    rightSpaceBarButton.width = -10;
//    self.navigationItem.rightBarButtonItems = @[rightSpaceBarButton, rightBarbutton];
//    rightBtn.backgroundColor = [UIColor cyanColor];
    
    //搜索框
//    UIView *titleView = [[UIView alloc] init];
//    UIColor *color = self.navigationController.navigationBar.backgroundColor;
//    titleView.backgroundColor = color;
//    self.navigationItem.titleView = titleView;
//    titleView.frame = CGRectMake(0, 0, 220, 30);
//    UISearchBar *searchBar = [[UISearchBar alloc] init];
//    searchBar.delegate = self;
//    searchBar.backgroundColor = color;
//    searchBar.placeholder = @"搜感兴趣的活动";
//    searchBar.layer.cornerRadius = 15;
//    searchBar.layer.masksToBounds = YES;
//    [titleView addSubview:searchBar];
//    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(titleView);
//    }];
    
}

- (void)rightBtnAction {
    WSFActivityHistoryVC *VC = [[WSFActivityHistoryVC alloc]init];
    [self.navigationController pushViewController:VC animated:NO];
}

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
