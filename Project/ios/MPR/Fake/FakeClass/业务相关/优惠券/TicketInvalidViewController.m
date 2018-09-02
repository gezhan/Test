//
//  TicketInvalidViewController.m
//  WinShare
//
//  Created by GZH on 2017/8/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "TicketInvalidViewController.h"
#import "TicketModel.h"
#import "TicketVM.h"
#import "TicketInvalidTView.h"

@interface TicketInvalidViewController ()

@property (nonatomic, strong) TicketInvalidTView *ticketInvalidTView;
@property (nonatomic, strong) NSMutableArray <TicketModel *> *ticketArray;



@end

@implementation TicketInvalidViewController
{
    NSInteger _currentPageIndex;
    NSInteger _currentPageSize;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _currentPageIndex = 1;
    _currentPageSize = 15;
    
    [self setupNavigationContent];
    
    [self getTicketListDataFromWebWithPageIndex:_currentPageIndex pageSize:_currentPageSize];
}

- (void)getTicketListDataFromWebWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [TicketVM getTicketListDataWithOverdue:true orderId:@"" payWayType:0 pageIndex:pageIndex pageSize:pageSize type:687 success:^(BOOL isHaveDisableTicket, NSArray *ticketList) {
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"获取优惠券列表数据成功:%@", ticketList);
        
        NSArray *ticketArrayForPage = [TicketModel getModelArrayFromModelArray:ticketList];
        
        if (pageIndex == 1) {
            [self.ticketArray removeAllObjects];
            [self.ticketInvalidTView.mj_footer resetNoMoreData];
        }
        
        if (ticketArrayForPage.count == 0) {
            [self.ticketInvalidTView.mj_footer endRefreshingWithNoMoreData];
        } else {
            if ([self.ticketInvalidTView.mj_header isRefreshing]) {
                [self.ticketInvalidTView.mj_header endRefreshing];
            }
            if ([self.ticketInvalidTView.mj_footer isRefreshing]) {
                [self.ticketInvalidTView.mj_footer endRefreshing];
            }
        }
        
        [self.ticketArray addObjectsFromArray:ticketArrayForPage];
        
        [self.view addSubview:self.ticketInvalidTView];
        self.ticketInvalidTView.ticketArray = self.ticketArray;
        
    } failed:^(NSError *error) {
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([self.ticketInvalidTView.mj_header isRefreshing]) {
            [self.ticketInvalidTView.mj_header endRefreshing];
        }
        if ([self.ticketInvalidTView.mj_footer isRefreshing]) {
            [self.ticketInvalidTView.mj_footer endRefreshing];
        }
        
        
        [self.view viewDisplayNotFoundViewWithNetworkLoss:(kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
            
            [self getTicketListDataFromWebWithPageIndex:_currentPageIndex pageSize:_currentPageSize];
        }];
        NSLog(@"获取优惠券列表数据失败:%@", error);
    }];
}

- (void)setupNavigationContent
{
    self.navigationItem.title = @"失效券";
}

#pragma mark - 懒加载
- (TicketInvalidTView *)ticketInvalidTView
{
    if (!_ticketInvalidTView) {
        _ticketInvalidTView = [[TicketInvalidTView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        
        //上拉加载
        
        _ticketInvalidTView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            self->_currentPageIndex++;
            [self getTicketListDataFromWebWithPageIndex:self->_currentPageIndex pageSize:self->_currentPageSize];
        }];
    }
    return _ticketInvalidTView;
}

- (NSMutableArray<TicketModel *> *)ticketArray
{
    if (!_ticketArray) {
        _ticketArray = [NSMutableArray array];
    }
    return _ticketArray;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
