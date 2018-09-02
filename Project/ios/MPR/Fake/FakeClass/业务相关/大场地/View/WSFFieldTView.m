//
//  WSFFieldTView.m
//  WinShare
//
//  Created by GZH on 2018/1/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldTView.h"
#import "WSFFieldTVCell.h"
#import "WSFFieldDetailVC.h"
#import "WSFFieldVM.h"

@interface WSFFieldTView() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WSFFieldTView

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

- (void)setPlaygroundVM:(WSFFieldVM *)playgroundVM {
    _playgroundVM = playgroundVM;
    [self tableViewDisplayNotFoundViewWithRowCount:_playgroundVM.dataSource.count withImageName:@"playground_nodata_white"];
    [self reloadData];
}

#pragma mark - Delegate DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playgroundVM.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WSFFieldDetailVC *detailVC = [[WSFFieldDetailVC alloc]init];
    WSFFieldCellVM *model = self.playgroundVM.dataSource[indexPath.row];
    detailVC.roomId = model.roomId;
    [self.viewController.navigationController pushViewController:detailVC animated:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifierId = [NSString stringWithFormat:@"cell%ld%ld", (long)indexPath.section, (long)indexPath.row];
    WSFFieldTVCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierId];
    if (!cell) {
        cell = [[WSFFieldTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierId];
        WSFFieldCellVM *model = self.playgroundVM.dataSource[indexPath.row];
        cell.playgroundCellVM = model;
    }
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
