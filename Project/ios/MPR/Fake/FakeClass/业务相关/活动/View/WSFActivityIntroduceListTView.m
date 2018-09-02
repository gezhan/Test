//
//  WSFActivityIntroduceListTView.m
//  WinShare
//
//  Created by QIjikj on 2018/2/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityIntroduceListTView.h"
#import "WSFActivitySelectSpaceTVM.h"
#import "WSFActivityIntroduceListCell.h"
#import "WSFActivityIntroduceListTVM.h"

@interface WSFActivityIntroduceListTView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WSFActivityIntroduceListTView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 44;
        self.rowHeight = UITableViewAutomaticDimension;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)setActivityIntroduceListTVM:(WSFActivityIntroduceListTVM *)activityIntroduceListTVM {
    _activityIntroduceListTVM = activityIntroduceListTVM;
    
    [self reloadData];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WSFActivityIntroduceListTCellVM *cellVM = self.activityIntroduceListTVM.activityIntroduceListTCellVMArray[indexPath.row];
    
    WSFActivityIntroduceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WSFActivityIntroduceListCell"];
    if (!cell) {
        cell = [[WSFActivityIntroduceListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WSFActivityIntroduceListCell"];
    }
    cell.activityIntroduceListTCellVM = cellVM;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
