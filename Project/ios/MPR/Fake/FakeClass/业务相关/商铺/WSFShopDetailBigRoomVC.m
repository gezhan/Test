//
//  WSFShopDetailBigRoomVC.m
//  WinShare
//
//  Created by QIjikj on 2018/1/22.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFShopDetailBigRoomVC.h"
#import "WSFShopListDetailBigRoomTView.h"
#import "ShopDataVM.h"
#import "ShopListDetailHeadModel.h"
#import "ShopListDetailModel.h"
#import "WSFBusinessBrDetailApiModel.h"

@interface WSFShopDetailBigRoomVC ()

@property (nonatomic, strong) WSFShopListDetailBigRoomTView *shopListDetailTV;
@property (nonatomic, strong) NSMutableArray *shopListDetailArray;// 空间的订单列表数据

// 等待logo

@end

@implementation WSFShopDetailBigRoomVC
{
    NSInteger _currentPageIndex;
    NSInteger _currentPageSize;
}

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _currentPageIndex = 1;
    _currentPageSize = 15;
    
    [self setupNavigationContent];
    
    [self setupViewContent];
    
    [self getShopListDetailDataFromWebWithPageIndex:_currentPageIndex pageSize:_currentPageSize];
}

#pragma mark - SVR
/** 获取商铺详情 */
- (void)getShopListDetailDataFromWebWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [ShopDataVM getShopListDetailBigRoomDataWithRoomId:self.spaceId pageIndex:pageIndex pageSize:pageSize success:^(NSDictionary *shopIncomeDictionary, NSArray *shopListDetailArray) {
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"获取大场地详情成功:%@\n%@", shopIncomeDictionary, shopListDetailArray);
        ShopListDetailHeadModel *shopListDetailHeadModel = [ShopListDetailHeadModel modelFromDict:shopIncomeDictionary];
        NSArray *shopListDetailModelArrForPage = [WSFBusinessBrDetailApiModel getModelArrayFromModelArray:shopListDetailArray];
        
        if (pageIndex == 1) {
            [self.shopListDetailArray removeAllObjects];
            [self.shopListDetailTV.mj_footer resetNoMoreData];
        }
        
        if (shopListDetailModelArrForPage.count == 0) {
            [self.shopListDetailTV.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.shopListDetailArray addObjectsFromArray:shopListDetailModelArrForPage];
        
        if ([self.shopListDetailTV.mj_header isRefreshing]) {
            [self.shopListDetailTV.mj_header endRefreshing];
        }
        if ([self.shopListDetailTV.mj_footer isRefreshing]) {
            [self.shopListDetailTV.mj_footer endRefreshing];
        }
        
        self.shopListDetailTV.shopListDetailHeadModel = shopListDetailHeadModel;
        self.shopListDetailTV.shopListDetailModelArr = self.shopListDetailArray;
        
        
    } failed:^(NSError *error) {
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"获取商铺详情失败:%@", error);
        
        if ([self.shopListDetailTV.mj_header isRefreshing]) {
            [self.shopListDetailTV.mj_header endRefreshing];
        }
        if ([self.shopListDetailTV.mj_footer isRefreshing]) {
            [self.shopListDetailTV.mj_footer endRefreshing];
        }
        
        
        BOOL showBool = (kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) && (self.shopListDetailTV.shopListDetailModelArr.count == 0);
        [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
            
            [self getShopListDetailDataFromWebWithPageIndex:pageIndex pageSize:pageSize];
        }];
    }];
}

#pragma mark - 界面初始化
- (void)setupNavigationContent
{
    self.navigationItem.title = self.spaceName;
}

- (void)setupViewContent
{
    [self.view addSubview:self.shopListDetailTV];
}

#pragma mark - 懒加载
- (WSFShopListDetailBigRoomTView *)shopListDetailTV
{
    if (!_shopListDetailTV) {
        _shopListDetailTV = [[WSFShopListDetailBigRoomTView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        
        //下拉刷新
        __weak typeof(self) weakSelf = self;
        _shopListDetailTV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf->_currentPageIndex = 1;
            
            [weakSelf getShopListDetailDataFromWebWithPageIndex:strongSelf->_currentPageIndex pageSize:strongSelf->_currentPageSize];
        }];
        //上拉加载
        _shopListDetailTV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf->_currentPageIndex++;
            
            [weakSelf getShopListDetailDataFromWebWithPageIndex:strongSelf->_currentPageIndex pageSize:strongSelf->_currentPageSize];
        }];
        
    }
    return _shopListDetailTV;
}

- (NSMutableArray *)shopListDetailArray
{
    if (!_shopListDetailArray) {
        _shopListDetailArray = [NSMutableArray array];
    }
    return _shopListDetailArray;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
