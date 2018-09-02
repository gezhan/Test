//
//  WSFDrinkTicketReclaimTView.m
//  WinShare
//
//  Created by devRen on 2017/10/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDrinkTicketReclaimTView.h"
#import "WSFDrinkTicketReclaimCell.h"

static NSString * const kWSFDrinkTicketReclaimCell = @"WSFDrinkTicketReclaimCell";
static NSUInteger const heightForTViewHeader = 30;

static UIView *setViewForFooter(NSString *month, NSString *total) {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    view.backgroundColor = HEX_COLOR_0xE6E6E6;
    UILabel *monthLabel = [[UILabel alloc] init];
    monthLabel.text = month;
    monthLabel.font = SYSTEMFONT_14;
    monthLabel.textColor = HEX_COLOR_0x808080;
    [view addSubview:monthLabel];
    [monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).mas_offset(10);
        make.top.equalTo(view.mas_top).mas_offset(10);
    }];
    UILabel *totalLabel = [[UILabel alloc] init];
    totalLabel.text = total;
    totalLabel.font = SYSTEMFONT_14;
    totalLabel.textColor = HEX_COLOR_0x1A1A1A;
    [view addSubview:totalLabel];
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).mas_offset(-10);
        make.top.equalTo(view.mas_top).mas_offset(10);
    }];
    return view;
}

@interface WSFDrinkTicketReclaimTView() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WSFDrinkTicketReclaimTView

#pragma mark - init 初始化
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.backgroundColor = HEX_COLOR_0xE6E6E6;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.estimatedRowHeight = 44;
        self.rowHeight = UITableViewAutomaticDimension;
    }
    return self;
}

#pragma mark - Delegate DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_backListViewModel.firstMonthRecords.count > 0 && _backListViewModel.secondMonthRecords.count >0 ) {
        return 2;
    } else if (_backListViewModel.firstMonthRecords.count > 0) {
        return 1;
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _backListViewModel.firstMonthRecords.count;
    } else {
        return _backListViewModel.secondMonthRecords.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return heightForTViewHeader;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0 ) {
        return setViewForFooter(_backListViewModel.firstMonth,_backListViewModel.firstMonthTotalAmount);
    } else {
        return setViewForFooter(_backListViewModel.secondMonth, _backListViewModel.secondMonthTotalAmount);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    WSFDrinkTicketReclaimCell *cell = [tableView dequeueReusableCellWithIdentifier:kWSFDrinkTicketReclaimCell];
//    if (!cell) {
        WSFDrinkTicketReclaimCell *cell = [[WSFDrinkTicketReclaimCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kWSFDrinkTicketReclaimCell];
        if (indexPath.section == 0) {
            cell.backAPIModel = _backListViewModel.firstMonthRecords[indexPath.row];
        } else {
            cell.backAPIModel = _backListViewModel.secondMonthRecords[indexPath.row];
        }
//    }
    return cell;
}

#pragma mark - set方法
- (void)setBackListViewModel:(WSFDrinkTicketBackListViewModel *)backListViewModel {
    _backListViewModel = backListViewModel;
    [self reloadData];
}

@end
