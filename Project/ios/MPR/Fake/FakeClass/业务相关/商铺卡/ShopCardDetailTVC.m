//
//  ShopCardDetailTVC.m
//  WinShare
//
//  Created by QIjikj on 2017/8/23.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopCardDetailTVC.h"
#import "ShopCardDetailCell.h"
#import "ShopCardDataVM.h"

@interface ShopCardDetailTVC ()

@property (nonatomic, assign) NSInteger totalDuration;// 总共的使用时长
@property (nonatomic, strong) NSMutableArray *useMessageArray;// 使用的详细记录数组

@end

@implementation ShopCardDetailTVC
{
    NSInteger _currentPageIndex;
    NSInteger _currentPageSize;
}

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentPageIndex = 1;
    _currentPageSize = 30;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->_currentPageIndex++;
        [self getShopCardDetailDataFromWebPageIndex:self->_currentPageIndex pageSize:self->_currentPageSize];
    }];
    
    [self getShopCardDetailDataFromWebPageIndex:_currentPageIndex pageSize:_currentPageSize];
    
}

#pragma mark - 获取网络数据
- (void)getShopCardDetailDataFromWebPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize
{
    [ShopCardDataVM getShopCardDetailDataWithRoomId:self.roomId monthString:self.monthNameString pageIndex:pageIndex pageSize:pageSize success:^(NSInteger totalDuration, NSArray *shopCardDetailAccount) {
        NSLog(@"获取商铺卡的一个月的使用详情成功：%ld~~~%@", totalDuration, shopCardDetailAccount);
        
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
        
        self.totalDuration = totalDuration;
        
        if (pageIndex == 1) {
            [self.useMessageArray removeAllObjects];
            [self.tableView.mj_footer resetNoMoreData];
        }
        
        NSArray *useMessageArrayForPage = shopCardDetailAccount;
        if (useMessageArrayForPage.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.useMessageArray addObjectsFromArray:useMessageArrayForPage];
        
        [self.tableView reloadData];
        
    } failed:^(NSError *error) {
        NSLog(@"获取商铺卡的一个月的使用详情失败：%@", error);
        
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
        
      BOOL showBool = (kCFHostReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) && (self.useMessageArray.count == 0);
        [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
            [self getShopCardDetailDataFromWebPageIndex:pageIndex pageSize:pageSize];
        }];
        
    }];
}

#pragma mark - tableViewDataSource,UITableViewDelegate
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.useMessageArray.count + 1;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"CELL1"];
        if (!cell1) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CELL1"];
        }
        cell1.textLabel.text = @"使用时长";
        
        NSInteger hoursNum = self.totalDuration / 60;
        NSInteger minsNum = self.totalDuration % 60;
        if (hoursNum > 0) {
            cell1.detailTextLabel.text = [NSString stringWithFormat:@"%ld小时%ld分钟", hoursNum, minsNum];
        }else if (hoursNum < 0) {
            cell1.detailTextLabel.text = [NSString stringWithFormat:@"-%ld小时%ld分钟", labs(hoursNum), labs(minsNum)];
        }else {
            if (minsNum < 0) {
                cell1.detailTextLabel.text = [NSString stringWithFormat:@"-%ld分钟", labs(minsNum)];
            }else {
                cell1.detailTextLabel.text = [NSString stringWithFormat:@"%ld分钟", minsNum];
            }
        }

        cell1.textLabel.font = [UIFont systemFontOfSize:14];
        cell1.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell1.textLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
        cell1.detailTextLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell1.contentView.width, 10)];
        lineView1.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
        [cell1.contentView addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 50, cell1.contentView.width, 10)];
        lineView2.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
        [cell1.contentView addSubview:lineView2];
        
        return cell1;
        
    }else {
        ShopCardDetailCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"CELL2"];
        if (!cell2) {
            cell2 = [[ShopCardDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL2"];
        }
        
        NSDictionary *detailDic = [self.useMessageArray objectAtIndex:indexPath.row - 1];
        
        cell2.textLabel.text = detailDic[@"UseType"];
        cell2.detailTextLabel.text = detailDic[@"CreteTime"];
        cell2.textLabel.font = [UIFont systemFontOfSize:14];
        cell2.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell2.textLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
        cell2.detailTextLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        
        NSInteger hoursNum = [detailDic[@"Duration"] integerValue] / 60;
        NSInteger minsNum = [detailDic[@"Duration"] integerValue] % 60;
        if (hoursNum > 0) {
            cell2.timeDetailString = [NSString stringWithFormat:@"%ld小时%ld分钟", hoursNum, minsNum];
        }else if (hoursNum < 0) {
            cell2.timeDetailString = [NSString stringWithFormat:@"-%ld小时%ld分钟", labs(hoursNum), labs(minsNum)];
        }else {
            if (minsNum < 0) {
                cell2.timeDetailString = [NSString stringWithFormat:@"-%ld分钟", labs(minsNum)];
            }else {
                cell2.timeDetailString = [NSString stringWithFormat:@"%ld分钟", minsNum];
            }
        }
        
        return cell2;
        
    }
}

// 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60;
    }
    return 50;
}

// 区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

//当已经点击cell时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - 懒加载
- (NSInteger)totalDuration
{
    if (!_totalDuration) {
        _totalDuration = 0;
    }
    return _totalDuration;
}

- (NSMutableArray *)useMessageArray
{
    if (!_useMessageArray) {
        _useMessageArray = [NSMutableArray array];
    }
    return _useMessageArray;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
