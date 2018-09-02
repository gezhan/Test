//
//  WSFHomePageTableView.m
//  WinShare
//
//  Created by GZH on 2018/1/10.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFHomePageTableView.h"
#import "WSFHomePagePromptView.h"
#import "WSFHomePageTVCell.h"
#import "WSFHomePageTVVM.h"
#import "SpaceDetailViewController.h"
#import "WSFFieldDetailVC.h"

@interface WSFHomePageTableView() <UITableViewDelegate, UITableViewDataSource>

@end
@implementation WSFHomePageTableView

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

- (void)setTableViewVM:(WSFHomePageTVVM *)tableViewVM {
    _tableViewVM = tableViewVM;
    [self reloadData];
}

#pragma mark - Delegate DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewVM.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 52;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WSFHomePagePromptView *promptView = [[WSFHomePagePromptView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 52) signString:@"附近空间"];
    return promptView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WSFHomePageCellVM *cellVM = self.tableViewVM.dataSource[indexPath.row];
    if (cellVM.jumpTypeKey == 1) {
        //小包厢
        SpaceDetailViewController *spaceDetailVC = [[SpaceDetailViewController alloc] init];
        spaceDetailVC.SpaceId = cellVM.roomId;
        spaceDetailVC.screenCoor = cellVM.coor; 
        [self.viewController.navigationController pushViewController:spaceDetailVC animated:NO];
    }else {
        //大场地
        WSFFieldDetailVC *detailVC = [[WSFFieldDetailVC alloc]init];
        detailVC.roomId = cellVM.roomId;
        [self.viewController.navigationController pushViewController:detailVC animated:NO];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WSFHomePageTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[WSFHomePageTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (self.tableViewVM.dataSource.count > indexPath.row) {
        WSFHomePageCellVM *model = self.tableViewVM.dataSource[indexPath.row];
        cell.homePageCellVM = model;
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
