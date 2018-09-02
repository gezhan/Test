//
//  WSFReclaimDrinkTicketListVC.m
//  WinShare
//
//  Created by devRen on 2017/10/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDrinkTicketReclaimListVC.h"
#import "ScanQrCodeVC.h"
#import "WSFDrinkTicketReclaimTView.h"
#import "WSFDrinkTicketReclaimDetailVC.h"
#import "WSFDrinkTicketNetwork.h"
#import "WSFDrinkTicketBackListViewModel.h"

static NSString * const kDrinkTicketReclaimListVCTitle = @"饮品券回收";
static NSString * const kQRCodeButtonImageName = @"saoyisao";
static NSString * const kNoDrinkTicketImageViewImageName = @"wuneirong";
static NSString * const kNoDrinkTicketLabelText = @"近两个月暂无回收的饮品券\n可通过右上角扫一扫回收饮品券";

@interface WSFDrinkTicketReclaimListVC ()

@property (nonatomic, strong) WSFDrinkTicketReclaimTView *reclaimTView;
@property (nonatomic, strong) UIImageView *noDrinkTicketImageView;
@property (nonatomic, strong) UILabel *noDrinkTicketLabel;
@property (nonatomic, assign) NSInteger drinkTicketPageIndex;
@property (nonatomic, assign) NSInteger drinkTicketPageSize;
@property (nonatomic, strong) WSFDrinkTicketBackListViewModel *backListViewModel;



@end

@implementation WSFDrinkTicketReclaimListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = kDrinkTicketReclaimListVCTitle;
    [self setQRCodeButton];
    self.view.backgroundColor = HEX_COLOR_0xE6E6E6;
    
    _drinkTicketPageIndex = 1;
    _drinkTicketPageSize = 15;
    
    [self getDrinkTicketBackList];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reclaimDetailBack) name:WSFDrinkTicketReclaimDetailBackNotification object:nil];
}

- (void)reclaimDetailBack {
    [_reclaimTView.mj_header beginRefreshing];
}

- (void)setQRCodeButton {
    UIButton *QRCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    QRCodeButton.frame = CGRectMake(0, 0, 40, 40);
    QRCodeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [QRCodeButton setImage:[UIImage imageNamed:kQRCodeButtonImageName] forState:UIControlStateNormal];
    [QRCodeButton addTarget:self action:@selector(QRCodeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:QRCodeButton];
}

#pragma mark - 网络请求
- (void)getDrinkTicketBackList {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [WSFDrinkTicketNetwork getDrinkTicketBackListWithPageIndex:_drinkTicketPageIndex pageSize:_drinkTicketPageSize success:^(id data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        WSFDrinkTicketBackListModel *model = [[WSFDrinkTicketBackListModel alloc] initWithDict:data];
        
        if (_drinkTicketPageSize == 1) {
            [weakSelf.backListViewModel removeAllData];
            [weakSelf.reclaimTView.mj_footer resetNoMoreData];
        }
        
        [weakSelf.backListViewModel addNewDataFromNetwork:model];

        if (model.records.count == 0) {
            [weakSelf.reclaimTView.mj_footer endRefreshingWithNoMoreData];
        }
        
        if ([weakSelf.reclaimTView.mj_header isRefreshing]) {
            [weakSelf.reclaimTView.mj_header endRefreshing];
        }
        if ([weakSelf.reclaimTView.mj_footer isRefreshing]) {
            [weakSelf.reclaimTView.mj_footer endRefreshing];
        }
        
        if (weakSelf.backListViewModel.firstMonthRecords.count == 0) {
            self.noDrinkTicketImageView.hidden = NO;
            self.noDrinkTicketLabel.hidden = NO;
        } else {
            self.noDrinkTicketImageView.hidden = YES;
            self.noDrinkTicketLabel.hidden = YES;
            self.reclaimTView.backListViewModel = _backListViewModel;
            [self.reclaimTView reloadData];
        }
        
    } failed:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([weakSelf.reclaimTView.mj_header isRefreshing]) {
            [weakSelf.reclaimTView.mj_header endRefreshing];
        }
        if ([weakSelf.reclaimTView.mj_footer isRefreshing]) {
            [weakSelf.reclaimTView.mj_footer endRefreshing];
        }
        
        [weakSelf.view viewDisplayNotFoundViewWithNetworkLoss:(kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
            [weakSelf getDrinkTicketBackList];
        }];
    }];
}

#pragma mark - 点击事件
- (void)QRCodeButtonClick:(UIButton *)sender {
    ScanQrCodeVC *QRCodeVC = [[ScanQrCodeVC alloc] init];
    [self.navigationController pushViewController:QRCodeVC animated:NO];
}

#pragma mark - 懒加载
- (UIImageView *)noDrinkTicketImageView {
    if (!_noDrinkTicketImageView) {
        _noDrinkTicketImageView = [[UIImageView alloc] init];
        _noDrinkTicketImageView.image = [UIImage imageNamed:kNoDrinkTicketImageViewImageName];
        [self.view addSubview:_noDrinkTicketImageView];
        [_noDrinkTicketImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY).mas_offset(-32);
        }];
    }
    return _noDrinkTicketImageView;
}

- (UILabel *)noDrinkTicketLabel {
    if (!_noDrinkTicketLabel) {
        _noDrinkTicketLabel = [[UILabel alloc] init];
        _noDrinkTicketLabel.text = kNoDrinkTicketLabelText;
        _noDrinkTicketLabel.textColor = HEX_COLOR_0x808080;
        _noDrinkTicketLabel.font = SYSTEMFONT_16;
        _noDrinkTicketLabel.textAlignment = NSTextAlignmentCenter;
        _noDrinkTicketLabel.numberOfLines = 0;
        [self.view addSubview:_noDrinkTicketLabel];
        [_noDrinkTicketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.noDrinkTicketImageView.mas_bottom).mas_offset(20);
        }];
    }
    return _noDrinkTicketLabel;
}

- (WSFDrinkTicketReclaimTView *)reclaimTView {
    if (!_reclaimTView) {
        _reclaimTView = [[WSFDrinkTicketReclaimTView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        //上拉加载
        __weak typeof(self) weakSelf = self;
        _reclaimTView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.drinkTicketPageIndex++;
            [weakSelf getDrinkTicketBackList];
        }];
        
        _reclaimTView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.drinkTicketPageIndex = 1;
            [weakSelf.backListViewModel removeAllData];
            [weakSelf getDrinkTicketBackList];
        }];
        [self.view addSubview:self.reclaimTView];
     }
    return _reclaimTView;
}

- (WSFDrinkTicketBackListViewModel *)backListViewModel {
    if (!_backListViewModel) {
        _backListViewModel = [[WSFDrinkTicketBackListViewModel alloc] init];
    }
    return _backListViewModel;
}


@end
