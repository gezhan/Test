//
//  WSFActivitySelectSpaceTView.m
//  WinShare
//
//  Created by QIjikj on 2018/2/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivitySelectSpaceTView.h"
#import "WSFActivitySelectSpaceCell.h"
#import "WSFActivitySelectSpaceTVM.h"

@interface WSFActivitySelectSpaceTView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WSFActivitySelectSpaceTView

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

- (void)setActivitySelectSpaceTVM:(WSFActivitySelectSpaceTVM *)activitySelectSpaceTVM {
    _activitySelectSpaceTVM = activitySelectSpaceTVM;
    
    [self reloadData];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSFActivitySelectSpaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WSFActivitySelectSpaceCell"];
    if (!cell) {
        cell = [[WSFActivitySelectSpaceCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WSFActivitySelectSpaceCell"];
    }
    
    WSFActivitySelectSpaceCellVM *cellVM = self.activitySelectSpaceTVM.activitySelectSpaceCellVMArray[indexPath.row];
    
    cell.sapceImageView.image = [UIImage imageNamed:cellVM.spaceImageURL];
    cell.nameLabel.text = cellVM.nameString;
    cell.addressLabel.text = cellVM.addressString;
    cell.selectBtn.selected = cellVM.selected;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    for (int i = 0; i < self.activitySelectSpaceTVM.activitySelectSpaceCellVMArray.count; i++) {
        if (i == indexPath.row) {
            self.activitySelectSpaceTVM.activitySelectSpaceCellVMArray[i].selected = YES;
        }else {
            self.activitySelectSpaceTVM.activitySelectSpaceCellVMArray[i].selected = NO;
        }
    }
    [self reloadData];
}

@end
