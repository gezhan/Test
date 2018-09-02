//
//  WSFDrinkTicketInvalidTView.m
//  WinShare
//
//  Created by devRen on 2017/10/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDrinkTicketInvalidTView.h"
#import "WSFDrinkTicketCell.h"

static NSString * const kTicketWSFDrinkTicketCell = @"WSFDrinkTicketCell";

@interface WSFDrinkTicketInvalidTView() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation WSFDrinkTicketInvalidTView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:UITableViewStylePlain]) {
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"];
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.estimatedRowHeight = 44;
        self.rowHeight = UITableViewAutomaticDimension;
    }
    return self;
}

- (void)setDrinkTicketArray:(NSMutableArray *)drinkTicketArray {
    _drinkTicketArray = drinkTicketArray;
    [self reloadData];
}

#pragma mark - tableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _drinkTicketArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSFDrinkTicketCell *cell = [[WSFDrinkTicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTicketWSFDrinkTicketCell cellType:WSFDrinkTicketCellType_invalid];
    [cell theAssignmentWithTicketModel:_drinkTicketArray[indexPath.row]];
    return cell;
}

@end
