//
//  ShopListDetailVC.m
//  WinShare
//
//  Created by QIjikj on 2017/7/12.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopListDetailVC.h"
#import "ShopListDetailTView.h"
#import "ShopDataVM.h"
#import "ShopListDetailHeadModel.h"
#import "ShopListDetailModel.h"
#import "WSFRPKeyInfo.h"
#import "WSFRPResultKeyInfo.h"
#import "WSFRPLockVersionInfo.h"

@interface ShopListDetailVC ()

@property (nonatomic, strong) ShopListDetailTView *shopListDetailTV;
@property (nonatomic, strong) NSMutableArray *shopListDetailArray;// 空间的订单列表数据

// 等待logo

@end

@implementation ShopListDetailVC
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
    
//    [self setupNavigationContent];
  
    [self setupViewContent];
    
    [self getShopListDetailDataFromWebWithPageIndex:_currentPageIndex pageSize:_currentPageSize];
}

#pragma mark - SVR
/** 获取商铺详情 */
- (void)getShopListDetailDataFromWebWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [ShopDataVM getShopListDetailDataWithRoomId:self.spaceId pageIndex:pageIndex pageSize:pageSize success:^(NSDictionary *shopIncomeDictionary, NSArray *shopListDetailArray) {
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"获取商铺详情成功:%@\n%@", shopIncomeDictionary, shopListDetailArray);
        ShopListDetailHeadModel *shopListDetailHeadModel = [ShopListDetailHeadModel modelFromDict:shopIncomeDictionary];
        NSArray *shopListDetailModelArrForPage = [ShopListDetailModel getModelArrayFromModelArray:shopListDetailArray];
        
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

/** 点击右上角的开锁按钮，网络请求钥匙信息，然后调用TTSDK开锁 */
//- (void)clickRightButton:(UIButton *)btn
//{
//    
//    [UnlockVM getUnlockVIPDataWithRoomId:self.spaceId success:^(NSDictionary *unlockDict) {
//        
//
//        NSLog(@"获取产业园的一键开锁信息成功：%@", unlockDict);
//
//        NSLog(@"[NSThread currentThread]~获取产业园的一键开锁信息成功~%@", [NSThread currentThread]);
//
//        if (![unlockDict[@"lockMac"] isEqual:[NSNull null]]) {
//            WSFRPKeyInfo *unlockKeyModel = [MTLJSONAdapter modelOfClass:WSFRPKeyInfo.class fromJSONDictionary:unlockDict error:nil];
//
//            NSDictionary *tempUnlockDict = @{
//                                             @"KeyBoardPwdId" : @0,
//                                             @"KeyBoardPwd" : @"",
//                                             @"LockId" : @(unlockKeyModel.lockId),
//                                             @"KeyId" : @(unlockKeyModel.keyId),
//                                             @"KeyStatus" : unlockKeyModel.keyStatus,
//                                             @"LockKey" : unlockKeyModel.lockKey,
//                                             @"LockMac" : unlockKeyModel.lockMac,
//                                             @"LockFlagPos" : @(unlockKeyModel.lockFlagPos),
//                                             @"AesKeyStr" : unlockKeyModel.aesKeyStr,
//                                             @"StartDate" : unlockKeyModel.startDate,
//                                             @"EndDate" : unlockKeyModel.endDate,
//                                             @"UserType" : unlockKeyModel.userType,
//                                             @"LockName" : unlockKeyModel.lockName,
//                                             @"LockAlias" : unlockKeyModel.lockAlias,
//                                             @"AdminPwd" : unlockKeyModel.adminPwd,
//                                             @"NoKeyPwd" : unlockKeyModel.noKeyPwd,
//                                             @"DeletePwd" : unlockKeyModel.deletePwd,
//                                             @"ElectricQuantity" : @(unlockKeyModel.electricQuantity),
//                                             @"Remarks" : unlockKeyModel.remarks,
//                                             @"TimezoneRawOffset" : unlockKeyModel.timezoneRawOffset,
//                                             @"LockVersion" : @{
//                                                     @"protocolType" : @(unlockKeyModel.lockVersion.protocolType),
//                                                     @"protocolVersion" : @(unlockKeyModel.lockVersion.protocolVersion),
//                                                     @"scene" : @(unlockKeyModel.lockVersion.scene),
//                                                     @"groupId" : @(unlockKeyModel.lockVersion.groupId),
//                                                     @"orgId" : @(unlockKeyModel.lockVersion.orgId)
//                                                     }
//                                             };
//
//            WSFRPResultKeyInfo *tTUnlockKeyModel = [MTLJSONAdapter modelOfClass:[WSFRPResultKeyInfo class] fromJSONDictionary:tempUnlockDict error:nil];
//
//            self.tTLockManager = [[WSFTTLockManager alloc] init];
//            [self.tTLockManager unlockPeripheralLockWithUnlockKey:tTUnlockKeyModel];
//        }
//
//    } failed:^(NSError *error) {
//
//        NSLog(@"获取产业园的一键开锁信息失败：%@", error);
//    }];
//}

#pragma mark - 界面初始化
//- (void)setupNavigationContent
//{
//    self.navigationItem.title = self.spaceName;
//
//    //right按钮
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.eventTimeInterval = WSFConstants_UnlockTimeInterval;
//    rightBtn.frame = CGRectMake(0, 0, 50, 44);
//    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [rightBtn setTitle:@"开锁" forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
//
//    UIView *rightBtnView = [[UIView alloc]initWithFrame:rightBtn.frame];
//    [rightBtnView addSubview:rightBtn];
//    UIBarButtonItem * rightBarbutton = [[UIBarButtonItem alloc]initWithCustomView:rightBtnView];
//
//    UIBarButtonItem *rightSpaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                                                                         target:nil
//                                                                                         action:nil];
//    rightSpaceBarButton.width = -10;
//
//    self.navigationItem.rightBarButtonItems = @[rightSpaceBarButton, rightBarbutton];
//}

- (void)setupViewContent
{
    [self.view addSubview:self.shopListDetailTV];
}

#pragma mark - 懒加载
- (ShopListDetailTView *)shopListDetailTV
{
    if (!_shopListDetailTV) {
        _shopListDetailTV = [[ShopListDetailTView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        
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
