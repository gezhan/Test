//
//  ShopListVC.m
//  WinShare
//
//  Created by QIjikj on 2017/7/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopListVC.h"
#import "ShopListTView.h"
#import "ShopDataVM.h"
#import "ShopListModel.h"
#import "AppDelegate.h"
#import "InvitationVC.h"
#import "ShopCardVC.h"
#import "MineMessageVM.h"
#import "WSFDrinkTicketReclaimListVC.h"

@interface ShopListVC ()

@property (nonatomic, strong) ShopListTView *shopListTView;
@property (nonatomic, strong) NSMutableArray *shopListModelArray;//我的空间列表



@end

@implementation ShopListVC
{
  NSInteger _currentPageIndex;
  NSInteger _currentPageSize;
  
  UIView *_coverView;//展开下拉框后的覆盖视图
  UIView *_nextView;//下拉框
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
  _currentPageIndex = 1;
  _currentPageSize = 10000;
  
  self.navigationItem.title = @"我的空间";
  
  // 每次进入当前界面需要更新当前登录用户的身份
  [self getUserIdentifyMessage];
}

- (void)getUserIdentifyMessage
{
  @weakify(self);
  [MineMessageVM getMineIdentifyDataSuccess:^(NSInteger identifyNumber) {
    @strongify(self);
    [WSFUserInfo saveIdentify:identifyNumber];
    
    [self setupNavigationContent];
    [self setupContentView];
    [self getShopListDataFromWebWithPageIndex:self->_currentPageIndex pageSize:self->_currentPageSize];
    
  } failed:^(NSError *error) {
    NSLog(@"获取当前登录用户的身份失败：%@", error);
    
    @weakify(self);
    BOOL showBool = (kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]);
    [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
      @strongify(self);
      [self getUserIdentifyMessage];
    }];
    
  }];
}

#pragma mark - 获取商铺列表数据
- (void)getShopListDataFromWebWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize
{
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  
  @weakify(self);
  [ShopDataVM getShopListDataWithPageIndex:pageIndex pageSize:pageSize success:^(NSArray *shopListDataArray) {
    @strongify(self);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    NSLog(@"获取商铺列表数据成功:%@", shopListDataArray);
    NSArray *shopListModelArrForPage = [ShopListModel getModelArrayFromModelArray:shopListDataArray];
    
    if (pageIndex == 1) {
      [self.shopListModelArray removeAllObjects];
      [self.shopListTView.mj_footer resetNoMoreData];
    }
    
    if (shopListModelArrForPage.count == 0) {
      [self.shopListTView.mj_footer endRefreshingWithNoMoreData];
    }
    
    [self.shopListModelArray addObjectsFromArray:shopListModelArrForPage];
    
    if ([self.shopListTView.mj_header isRefreshing]) {
      [self.shopListTView.mj_header endRefreshing];
    }
    if ([self.shopListTView.mj_footer isRefreshing]) {
      [self.shopListTView.mj_footer endRefreshing];
    }
    
    self.shopListTView.userIdentifyNum = [WSFUserInfo getIdentify];
    self.shopListTView.shopListArray = self.shopListModelArray;
    
  } failed:^(NSError *error) {
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    NSLog(@"获取商铺列表数据失败:%@", error);
    
    if ([self.shopListTView.mj_header isRefreshing]) {
      [self.shopListTView.mj_header endRefreshing];
    }
    if ([self.shopListTView.mj_footer isRefreshing]) {
      [self.shopListTView.mj_footer endRefreshing];
    }
    
    @weakify(self);
    BOOL showBool = (kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]);
    [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
      @strongify(self);
      [self getShopListDataFromWebWithPageIndex:pageIndex pageSize:pageSize];
    }];
    
  }];
}

#pragma mark - 基础界面搭建
- (void)setupNavigationContent
{
  self.navigationItem.title = @"我的空间";
  
  //right按钮
  UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  rightBtn.frame = CGRectMake(0, 0, 30, 30);
  [rightBtn setTitle:@"" forState:UIControlStateNormal];
  [rightBtn setImage:[UIImage imageNamed:@"more_white"] forState:UIControlStateNormal];
  [rightBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
  
  UIView *rightBtnView = [[UIView alloc]initWithFrame:rightBtn.frame];
  [rightBtnView addSubview:rightBtn];
  UIBarButtonItem * rightBarbutton = [[UIBarButtonItem alloc]initWithCustomView:rightBtnView];
  
  UIBarButtonItem *rightSpaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
  rightSpaceBarButton.width = -10;
  
  NSArray *titleArray = nil;
  NSArray *blockArray = nil;
  @weakify(self);
  if ([WSFUserInfo getIdentify] == WSFUserIdentifyType_User) {
    titleArray = @[];
    blockArray = @[];
    self.navigationItem.rightBarButtonItems = @[];
  }else if ([WSFUserInfo getIdentify] == WSFUserIdentifyType_Merchant) {
    titleArray = @[@"我的商铺卡", @"饮品券回收"];
    blockArray = @[^(UIButton *button) {
      @strongify(self);
      //1.隐藏菜单界面
      [self performSelector:@selector(hideTheMenuViewAction)];
      
      //2.跳转到商铺卡界面
      ShopCardVC *shopCardVC = [[ShopCardVC alloc] init];
      [self.navigationController pushViewController:shopCardVC animated:NO];
    }, ^(UIButton *button) {
      @strongify(self);
      //1.隐藏菜单界面
      [self performSelector:@selector(hideTheMenuViewAction)];
      
      //2.跳转到饮品券回收界面
      ShopCardVC *shopCardVC = [[ShopCardVC alloc] init];
      [self.navigationController pushViewController:shopCardVC animated:NO];
    }];
    self.navigationItem.rightBarButtonItems = @[rightSpaceBarButton, rightBarbutton];
  }else {
    titleArray = @[@"绑定VIP", @"我的商铺卡", @"饮品券回收"];
    blockArray = @[^(UIButton *button) {
      @strongify(self);
      //1.隐藏菜单界面
      [self performSelector:@selector(hideTheMenuViewAction)];
      
      //2.跳转到绑定商铺卡界面
      InvitationVC *invatationVC = [[InvitationVC alloc] init];
      [self.navigationController pushViewController:invatationVC animated:NO];
      
    }, ^(UIButton *button) {
      @strongify(self);
      //1.隐藏菜单界面
      [self performSelector:@selector(hideTheMenuViewAction)];
      
      //2.跳转到商铺卡界面
      ShopCardVC *shopCardVC = [[ShopCardVC alloc] init];
      [self.navigationController pushViewController:shopCardVC animated:NO];
    }, ^(UIButton *button) {
      @strongify(self);
      //1.隐藏菜单界面
      [self performSelector:@selector(hideTheMenuViewAction)];
      
      //2.跳转到饮品券回收界面
      WSFDrinkTicketReclaimListVC *reclaimDrinkTicketListVC = [[WSFDrinkTicketReclaimListVC alloc] init];
      [self.navigationController pushViewController:reclaimDrinkTicketListVC animated:NO];
    }];
    self.navigationItem.rightBarButtonItems = @[rightSpaceBarButton, rightBarbutton];
  }
  
  [self setupMenuViewWithTitleArray:titleArray blockArray:blockArray];
}

- (void)setupMenuViewWithTitleArray:(NSArray *)titleArray blockArray:(NSArray <void(^)(UIButton *button)>*)blockArray
{
  if (titleArray.count == 0) return;
  
  //菜单项上面的按钮
  NSArray *menuNameArr = titleArray;
  
  //
  AppDelegate *appDelelgate = (AppDelegate *)[UIApplication sharedApplication].delegate;
  _coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
  _coverView.hidden = YES;
  
  UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTheMenuViewAction)];
  [_coverView addGestureRecognizer:singleFingerTap];
  [appDelelgate.window addSubview:_coverView];
  
  //
  _nextView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-120-10, 64.5, 120, 40*menuNameArr.count+.5*(menuNameArr.count - 1))];
  _nextView.backgroundColor = [UIColor colorWithHexString:@"#2483C3"];
  _nextView.hidden = YES;
  [_coverView  addSubview:_nextView];
  
  //菜单上的按钮
  for (int i = 0; i < menuNameArr.count; i++) {
    HSBlockButton *uploadBtn = [HSBlockButton buttonWithType:UIButtonTypeCustom];
    uploadBtn.frame = CGRectMake(0, 40.5*i, 120, 40);
    [uploadBtn setTitle:[menuNameArr objectAtIndex:i] forState:UIControlStateNormal];
    [uploadBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    uploadBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [uploadBtn addTouchUpInsideBlock:[blockArray objectAtIndex:i]];
    [_nextView addSubview:uploadBtn];
  }
  
  //菜单项上的分隔线
  for (int i = 0; i < menuNameArr.count - 1; i ++) {
    UIView *separationLine = [[UIView alloc] initWithFrame:CGRectMake(15, (40.5+40*i), 90, 0.5)];
    separationLine.backgroundColor = [UIColor whiteColor];
    [_nextView addSubview:separationLine];
  }
  
}

- (void)clickRightButton:(UIButton *)btn
{
  if (_coverView.hidden) {
    [_coverView setHidden:NO];
    [_nextView setHidden:NO];
  }else {
    [_coverView setHidden:YES];
    [_nextView setHidden:YES];
  }
}

- (void)hideTheMenuViewAction
{
  [_coverView setHidden:YES];
  [_nextView setHidden:YES];
}

- (void)setupContentView
{
  [self.view addSubview:self.shopListTView];
}

#pragma mark - 懒加载
- (ShopListTView *)shopListTView
{
  if (!_shopListTView) {
    _shopListTView = [[ShopListTView alloc] init];
    _shopListTView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
  }
  return _shopListTView;
}

- (NSMutableArray *)shopListModelArray
{
  if (!_shopListModelArray) {
    _shopListModelArray = [NSMutableArray array];
  }
  return _shopListModelArray;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
