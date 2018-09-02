//
//  TicketViewController.m
//  WinShare
//
//  Created by GZH on 2017/5/8.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "TicketViewController.h"
#import "TicketModel.h"
#import "TicketVM.h"
#import "TicketTView.h"
#import "WSFDrinkTicketTView.h"
#import "WSFDrinkTicketNetwork.h"
#import "WSFDrinkTicketImmediateUseVC.h"
#import "WSFDrinkTicketNetwork.h"

@interface TicketViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *baseScrollView;
@property (nonatomic, strong) TicketTView *ticketTableView;
@property (nonatomic, strong) WSFDrinkTicketTView *drinkTicketTView;
@property (nonatomic, strong) NSMutableArray <TicketModel *> *ticketArray;
@property (nonatomic, strong) NSMutableArray <TicketModel *> *drinkticketArray;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, assign) NSInteger drinkTicketPageIndex;
@property (nonatomic, assign) NSInteger drinkTicketPageSize;
@property (nonatomic, assign) BOOL isFirstTimeClickSegmented;
@property (nonatomic, assign) BOOL isConfirmImmediateUse;



@end

@implementation TicketViewController
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
    
    _drinkTicketPageIndex = 1;
    _drinkTicketPageSize = 15;
    
    _isFirstTimeClickSegmented = YES;
    _isConfirmImmediateUse = NO;
    
    self.view.backgroundColor = HEX_COLOR_0xE6E6E6;
    [self.view addSubview:self.baseScrollView];
    
    if (!_skip) {
        [self.navigationItem setTitleView:self.segmentedControl];
    } else {
        self.navigationItem.title = @"优惠券";
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(confirmImmediateUse:) name:WSFDrinkTicketImmediateUseConfirmNotification object:nil];
    
    [self getTicketListDataFromWebWithPageIndex:_currentPageIndex pageSize:_currentPageSize];
    
}

#pragma mark - 获取网络数据
- (void)getTicketListDataFromWebWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    if (!self.skip) {
        [TicketVM getTicketListDataWithOverdue:false orderId:@"" payWayType:0 pageIndex:pageIndex pageSize:pageSize type:687 success:^(BOOL isHaveDisableTicket, NSArray *ticketList) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSLog(@"获取优惠券列表数据成功:%@", ticketList);
            
            NSArray *ticketArrayForPage = [TicketModel getModelArrayFromModelArray:ticketList];
            
            if (pageIndex == 1) {
                [self.ticketArray removeAllObjects];
                [self.ticketTableView.mj_footer resetNoMoreData];
            }
            
            [self.ticketArray addObjectsFromArray:ticketArrayForPage];
        
            if (ticketArrayForPage.count == 0) {
                [self.ticketTableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                if ([self.ticketTableView.mj_footer isRefreshing]) {
                    [self.ticketTableView.mj_footer endRefreshing];
                }
            }
            
            [_baseScrollView addSubview:self.ticketTableView];
            self.ticketTableView.previousTicketedId = self.previousTicketedId;
            self.ticketTableView.isHaveDisableTicket = isHaveDisableTicket;
            self.ticketTableView.ticketArray = self.ticketArray;
            
        } failed:^(NSError *error) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSLog(@"获取优惠券列表数据失败:%@", error);
            
            if ([self.ticketTableView.mj_footer isRefreshing]) {
                [self.ticketTableView.mj_footer endRefreshing];
            }
            
            
            BOOL showBool = (kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) && (self.ticketTableView.ticketArray.count == 0);
            [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
                
                [self getTicketListDataFromWebWithPageIndex:pageIndex pageSize:pageSize];
            }];
            
        }];
    }else {
        [TicketVM getTicketListDataWithOverdue:false orderId:self.orderId payWayType:self.payWayType pageIndex:pageIndex  pageSize:pageSize type:687 success:^(BOOL isHaveDisableTicket, NSArray *ticketList) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSArray *ticketArrayForPage = [TicketModel getModelArrayFromModelArray:ticketList];
            NSLog(@"获取优惠券列表数据成功:%@", ticketList);
            
            if (ticketArrayForPage.count == 0) {
                [self.ticketTableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                if ([self.ticketTableView.mj_footer isRefreshing]) {
                    [self.ticketTableView.mj_footer endRefreshing];
                }
            }
            
            [self.ticketArray addObjectsFromArray:ticketArrayForPage];
            
            [_baseScrollView addSubview:self.ticketTableView];
            self.ticketTableView.previousTicketedId = self.previousTicketedId;
            self.ticketTableView.isHaveDisableTicket = isHaveDisableTicket;
            self.ticketTableView.ticketArray = self.ticketArray;
            
        } failed:^(NSError *error) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSLog(@"获取优惠券列表数据失败:%@", error);
            
            if ([self.ticketTableView.mj_footer isRefreshing]) {
                [self.ticketTableView.mj_footer endRefreshing];
            }
            
            
            BOOL showBool = (kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) && (self.ticketTableView.ticketArray.count == 0);
            [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
                
                [self getTicketListDataFromWebWithPageIndex:pageIndex pageSize:pageSize];
            }];
            
        }];
    }
}

- (void)getDrinkTicketListDataFromWebWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [WSFDrinkTicketNetwork getDrinkTicketListDataWithOverdue:false orderId:@"" payWayType:0 pageIndex:pageIndex pageSize:pageSize type:565 success:^(BOOL isHaveDisableTicket, NSArray *ticketList) {
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"获取饮品券列表数据成功:%@", ticketList);
        
        NSArray *ticketArrayForPage = [TicketModel getModelArrayFromModelArray:ticketList];
        
        if (pageIndex == 1) {
            [self.drinkticketArray removeAllObjects];
            [self.drinkTicketTView.mj_footer resetNoMoreData];
        }
        
        [self.drinkticketArray addObjectsFromArray:ticketArrayForPage];
        
        if (ticketArrayForPage.count == 0) {
            [self.drinkTicketTView.mj_footer endRefreshingWithNoMoreData];
        } else {
            if ([self.drinkTicketTView.mj_footer isRefreshing]) {
                [self.drinkTicketTView.mj_footer endRefreshing];
            }
        }
        
        [_baseScrollView addSubview:self.drinkTicketTView];
        self.drinkTicketTView.isHaveDisableTicket = isHaveDisableTicket;
        self.drinkTicketTView.drinkTicketArray = self.drinkticketArray;
        _isFirstTimeClickSegmented = NO;
        
    } failed:^(NSError *error) {
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"获取饮品券列表数据失败:%@", error);
        
        if ([self.drinkTicketTView.mj_footer isRefreshing]) {
            [self.drinkTicketTView.mj_footer endRefreshing];
        }
        
//        
//        BOOL showBool = (kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) && (self.drinkTicketTView.drinkTicketArray.count == 0);
//        [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
//            
//            [self getTicketListDataFromWebWithPageIndex:pageIndex pageSize:pageSize];
//        }];
    }];
    
    
}

#pragma mark - 点击事件
- (void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender {
    switch(sender.selectedSegmentIndex){
        case 0:
            sender.selectedSegmentIndex = 0;
            [_baseScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            break;
        case 1:
            sender.selectedSegmentIndex = 1;
            [_baseScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
            if (_isFirstTimeClickSegmented) {
                [self getDrinkTicketListDataFromWebWithPageIndex:_drinkTicketPageIndex pageSize:_drinkTicketPageSize];
            }
            break;
            
        default:
            break;
    }
}

- (void)confirmImmediateUse:(NSNotification *)notification {
    NSString * couponCode = [notification object];
    _drinkTicketPageIndex = 1;
    _isConfirmImmediateUse = YES;
    
    [WSFDrinkTicketNetwork getDrinkTicketDetailWithCouponCode:couponCode success:^(id  _Nonnull data) {
        TicketModel *model = [[TicketModel alloc] initWithDict:data];
        if (model.isUsed) {
            [MBProgressHUD showMessage:@"使用成功"];
            [self getDrinkTicketListDataFromWebWithPageIndex:_drinkTicketPageIndex pageSize:_drinkTicketPageSize];
        }
    } failed:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ( scrollView.contentOffset.x < SCREEN_WIDTH - 20) {
        _segmentedControl.selectedSegmentIndex = 0;
    } else {
        _segmentedControl.selectedSegmentIndex = 1;
        if (_isFirstTimeClickSegmented) {
            [self getDrinkTicketListDataFromWebWithPageIndex:_drinkTicketPageIndex pageSize:_drinkTicketPageSize];
        }
    }
}

#pragma mark - 懒加载
- (TicketTView *)ticketTableView
{
    if (!_ticketTableView) {
        _ticketTableView = [[TicketTView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _ticketTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _ticketTableView.skip = self.skip;
        
        //上拉加载
        
        _ticketTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            self->_currentPageIndex++;
            [self getTicketListDataFromWebWithPageIndex:self->_currentPageIndex pageSize:self->_currentPageSize];
            
        }];
        
    }
    return _ticketTableView;
}

- (NSMutableArray<TicketModel *> *)ticketArray
{
    if (!_ticketArray) {
        _ticketArray = [NSMutableArray array];
    }
    return _ticketArray;
}

- (NSMutableArray<TicketModel *> *)drinkticketArray {
    if (!_drinkticketArray) {
        _drinkticketArray = [NSMutableArray array];
    }
    return _drinkticketArray;
}

- (UIScrollView *)baseScrollView {
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        if (!_skip) {
            _baseScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
        } else {
            _baseScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 0);
        }
        _baseScrollView.showsVerticalScrollIndicator = NO;
        _baseScrollView.showsHorizontalScrollIndicator = NO;
        _baseScrollView.pagingEnabled = YES;
        _baseScrollView.delegate = self;
    }
    return _baseScrollView;
}

- (WSFDrinkTicketTView *)drinkTicketTView {
    if (!_drinkTicketTView) {
        _drinkTicketTView = [[WSFDrinkTicketTView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _drinkTicketTView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        //上拉加载
        
        _drinkTicketTView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            self.drinkTicketPageIndex ++;
            [self getDrinkTicketListDataFromWebWithPageIndex:self.drinkTicketPageIndex pageSize:self.drinkTicketPageSize];
        }];
    }
    return _drinkTicketTView;
}

- (UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"优惠券",@"饮品券"]];
        _segmentedControl.frame = CGRectMake(0, 0, 140, 32);
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.tintColor = [UIColor whiteColor];
        _segmentedControl.layer.cornerRadius = 16;
        _segmentedControl.layer.masksToBounds = YES;
        _segmentedControl.layer.borderWidth = 1;
        _segmentedControl.layer.borderColor = [UIColor whiteColor].CGColor;
        [_segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

@end
