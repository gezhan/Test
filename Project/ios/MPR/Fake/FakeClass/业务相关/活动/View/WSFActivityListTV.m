//
//  WSFActivityListTV.m
//  WinShare
//
//  Created by GZH on 2018/2/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityListTV.h"
#import "WSFActivityListTVCell.h"
#import "WSFActivityDetailVC.h"
#import "WSFActivityListVM.h"

@interface WSFActivityListTV() <UITableViewDelegate, UITableViewDataSource>

@end
@implementation WSFActivityListTV

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        
        self.tableFooterView = [UIView new];
        self.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 44;
        self.rowHeight = UITableViewAutomaticDimension;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return self;
}

- (void)setListVM:(WSFActivityListVM *)listVM {
    _listVM = listVM;
    [self tableViewDisplayNotFoundViewWithRowCount:_listVM.dataSource.count withImageName:@"playground_nodata_white"];
    [self reloadData];
}

#pragma mark - Delegate DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listVM.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WSFActivityDetailVC *VC = [[WSFActivityDetailVC alloc]init];
    WSFActivityListCellVM *cellVM = _listVM.dataSource[indexPath.row];
    VC.eventId = cellVM.Id;
    [self.viewController.navigationController pushViewController:VC animated:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSFActivityListTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[WSFActivityListTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    WSFActivityListCellVM *cellVM = _listVM.dataSource[indexPath.row];
    cell.cellVM = cellVM;
    return cell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
