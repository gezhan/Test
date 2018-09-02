//
//  WSFDrinkTicketInvalidVC.m
//  WinShare
//
//  Created by devRen on 2017/10/27.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDrinkTicketInvalidVC.h"
#import "WSFDrinkTicketInvalidTView.h"
#import "TicketModel.h"
#import "TicketVM.h"

@interface WSFDrinkTicketInvalidVC ()

@property (nonatomic, strong) WSFDrinkTicketInvalidTView *invalidDrinkTicketTView;
@property (nonatomic, strong) NSMutableArray <TicketModel *> *drinkTicketArray;
@property (nonatomic, assign) NSInteger drinkTicketPageIndex;
@property (nonatomic, assign) NSInteger drinkTicketPageSize;



@end

@implementation WSFDrinkTicketInvalidVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"失效的饮品券";
    self.view.backgroundColor = HEX_COLOR_0xE6E6E6;
    
    _drinkTicketPageIndex = 1;
    _drinkTicketPageSize = 15;
    [self getTicketListDataFromWebWithPageIndex:_drinkTicketPageIndex pageSize:_drinkTicketPageSize];
}

- (void)getTicketListDataFromWebWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [TicketVM getTicketListDataWithOverdue:true orderId:@"" payWayType:0 pageIndex:pageIndex pageSize:pageSize type:565 success:^(BOOL isHaveDisableTicket, NSArray *ticketList) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"获取优惠券列表数据成功:%@", ticketList);
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (pageIndex == 1) {
            [strongSelf.drinkTicketArray removeAllObjects];
            [strongSelf.invalidDrinkTicketTView.mj_footer resetNoMoreData];
        }
        
        NSArray *ticketArrayForPage = [TicketModel getModelArrayFromModelArray:ticketList];
        
        if (ticketArrayForPage.count == 0) {
            [strongSelf.invalidDrinkTicketTView.mj_footer endRefreshingWithNoMoreData];
        } else {
            if ([strongSelf.invalidDrinkTicketTView.mj_footer isRefreshing]) {
                [strongSelf.invalidDrinkTicketTView.mj_footer endRefreshing];
            }
        }
        
        [self.drinkTicketArray addObjectsFromArray:ticketArrayForPage];
        self.invalidDrinkTicketTView.drinkTicketArray = self.drinkTicketArray;
        [self.view addSubview:self.invalidDrinkTicketTView];
        
    } failed:^(NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([weakSelf.invalidDrinkTicketTView.mj_header isRefreshing]) {
            [weakSelf.invalidDrinkTicketTView.mj_header endRefreshing];
        }
        if ([weakSelf.invalidDrinkTicketTView.mj_footer isRefreshing]) {
            [weakSelf.invalidDrinkTicketTView.mj_footer endRefreshing];
        }
        
        [weakSelf.view viewDisplayNotFoundViewWithNetworkLoss:(kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
            [weakSelf getTicketListDataFromWebWithPageIndex:_drinkTicketPageIndex pageSize:_drinkTicketPageSize];
        }];
        NSLog(@"获取优惠券列表数据失败:%@", error);
    }];
}

#pragma mark - 懒加载
- (WSFDrinkTicketInvalidTView *)invalidDrinkTicketTView {
    if (!_invalidDrinkTicketTView) {
        _invalidDrinkTicketTView = [[WSFDrinkTicketInvalidTView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        
        
        _invalidDrinkTicketTView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            self->_drinkTicketPageIndex++;
            [self getTicketListDataFromWebWithPageIndex:self->_drinkTicketPageIndex pageSize:self->_drinkTicketPageSize];
        }];
    }
    return _invalidDrinkTicketTView;
}

- (NSMutableArray *)drinkTicketArray {
    if (!_drinkTicketArray) {
        _drinkTicketArray = [[NSMutableArray alloc] init];
    }
    return _drinkTicketArray;
}

@end
