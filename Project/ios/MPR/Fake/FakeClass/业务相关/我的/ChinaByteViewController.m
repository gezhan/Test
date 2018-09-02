//
//  ChinaByteViewController.m
//  WinShare
//
//  Created by QIjikj on 2017/5/8.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ChinaByteViewController.h"
#import "MineMessageVM.h"
#import "ByteRecordModel.h"

@interface ChinaByteViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <ByteRecordModel *> *recordArray;
@property (nonatomic, strong) UITableView *recordTableView;

@property (nonatomic, strong) UILabel *moneyLabel;



@end

@implementation ChinaByteViewController
{
    NSInteger _currentPageIndex;
    NSInteger _currentPageSize;
}

#pragma mark - 控制器的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _currentPageIndex = 1;
    _currentPageSize = 30;
    
    self.navigationItem.title = @"赢贝";
    
    UIImageView *groundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36)];
    groundImage.image = [UIImage imageNamed:@"background_short_under"];
    [self.view addSubview:groundImage];
    
    self.moneyLabel = [[UILabel alloc] init];
    self.moneyLabel.text = @"***";
    self.moneyLabel.font = [UIFont systemFontOfSize:16];
    self.moneyLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    [groundImage addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(groundImage.mas_bottom).offset(-20);
        make.centerX.mas_equalTo(groundImage.mas_centerX);
    }];
    
    [self.view addSubview:self.recordTableView];

    [self getCurrentChinaByteDataFromWeb];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"background_short_top"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"background_blue_top"] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - 获取网络数据
/** 获取用户剩余赢贝 */
- (void)getCurrentChinaByteDataFromWeb
{
    
    [MineMessageVM getMineCurrentBalanceWithSuccess:^(NSString *balanceMoney) {
        
        NSLog(@"获取用户剩余赢贝成功:%@", balanceMoney);
        self.moneyLabel.text = balanceMoney;
        [self getChinaByteRecordDataFromWebPageIndex:self->_currentPageIndex pageSize:self->_currentPageSize];
    } failed:^(NSError *error) {
        NSLog(@"获取用户剩余赢贝失败:%@", error);
        
        
        BOOL showBool = (kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]);
        [self.recordTableView viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
            
            [self getCurrentChinaByteDataFromWeb];
        }];
        
    }];
}

/** 获取用户赢贝使用记录 */
- (void)getChinaByteRecordDataFromWebPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [MineMessageVM getMineMoneyUsedRecordWithPageIndex:pageIndex pageSize:pageSize success:^(NSArray *moneyUsedRecord) {
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"获取用户赢贝使用记录成功:%@", moneyUsedRecord);
        
        if (pageIndex == 1) {
            [self.recordArray removeAllObjects];
            [self.recordTableView.mj_footer resetNoMoreData];
        }
        
        NSArray *recordArrayForPage = [ByteRecordModel getModelArrayFromModelArray:moneyUsedRecord];
        
        if (recordArrayForPage.count == 0) {
            [self.recordTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.recordArray addObjectsFromArray:recordArrayForPage];
        
        if ([self.recordTableView.mj_header isRefreshing]) {
            [self.recordTableView.mj_header endRefreshing];
        }
        if ([self.recordTableView.mj_footer isRefreshing]) {
            [self.recordTableView.mj_footer endRefreshing];
        }
        
        [self.recordTableView tableViewDisplayNotFoundViewWithRowCount:self.recordArray.count withImageName:@"yingbei_none"];
        [self.recordTableView reloadData];
        
    } failed:^(NSError *error) {
        
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"获取用户赢贝使用记录失败:%@", error);

        if ([self.recordTableView.mj_header isRefreshing]) {
            [self.recordTableView.mj_header endRefreshing];
        }
        if ([self.recordTableView.mj_footer isRefreshing]) {
            [self.recordTableView.mj_footer endRefreshing];
        }
        
        
        BOOL showBool = (kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) && (self.recordArray.count == 0);
        [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
            
            [self getChinaByteRecordDataFromWebPageIndex:pageIndex pageSize:pageSize];
        }];
        
    }];
}

#pragma mark - tableViewDataSource,UITableViewDelegate
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recordArray.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordCell_none"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RecordCell"];
    }
    
    ByteRecordModel *byteRecordModel = [self.recordArray objectAtIndex:indexPath.row];
    
    UILabel *stateLabel = [[UILabel alloc] init];
    stateLabel.text = byteRecordModel.operationType;
    stateLabel.font = [UIFont systemFontOfSize:14];
    stateLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    [cell.contentView addSubview:stateLabel];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
    }];
    
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.text = [NSString dateStrWithNewFormatter:@"yyyy.MM.dd" oldStr: byteRecordModel.operationTime oldFormatter:@"yyyy-MM-dd HH:mm:ss"];
    dateLabel.font = [UIFont systemFontOfSize:12];
    dateLabel.textColor = [UIColor colorWithHexString:@"808080"];
    [cell.contentView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(stateLabel.mas_bottom).offset(6);
        make.left.mas_equalTo(10);
    }];
    
    UILabel *earningLabel = [[UILabel alloc] init];
    if (byteRecordModel.operationAmount < 0) {
        earningLabel.text = [NSString stringWithFormat:@"%0.2f", byteRecordModel.operationAmount];
    }else {
        earningLabel.text = [NSString stringWithFormat:@"+%0.2f", byteRecordModel.operationAmount];
    }
    earningLabel.font = [UIFont systemFontOfSize:14];
    earningLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    [cell.contentView addSubview:earningLabel];
    [earningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12.5);
        make.right.mas_equalTo(-10);
    }];
    
    UIView *LineView = [[UIView alloc] init];
    LineView.backgroundColor = [UIColor colorWithHexString:@"cccccc" alpha:0.5];
    [cell.contentView addSubview:LineView];
    [LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cell.contentView.mas_bottom).offset(-1);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    
    return cell;
}

// 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

#pragma mark - UIScrollViewDelegate
/** UIScrollViewDelegate */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = self.recordTableView.contentOffset;
    if (point.y < 0) {
        //不可以向下滑动
        self.recordTableView.contentOffset = CGPointMake(0, 0);
    }
}

#pragma mark - 懒加载

- (NSMutableArray *)recordArray
{
    if (!_recordArray) {
        _recordArray = [NSMutableArray array];
    }
    return _recordArray;
}

- (UITableView *)recordTableView
{
    if (!_recordTableView) {
        _recordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 36, SCREEN_WIDTH, SCREEN_HEIGHT-64-36)];
        _recordTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _recordTableView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        _recordTableView.delegate = self;
        _recordTableView.dataSource = self;
        _recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _recordTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            self->_currentPageIndex++;
            [self getChinaByteRecordDataFromWebPageIndex:self->_currentPageIndex pageSize:self->_currentPageSize];
        }];
    }
    return _recordTableView;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
