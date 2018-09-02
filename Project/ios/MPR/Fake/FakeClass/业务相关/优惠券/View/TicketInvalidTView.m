//
//  TicketInvalidTView.m
//  WinShare
//
//  Created by GZH on 2017/8/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "TicketInvalidTView.h"
#import "TicketModel.h"
#import "TicketInvalidNoLimitCell.h"
#import "TicketInvalidBeLimitCell.h"

@interface TicketInvalidTView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation TicketInvalidTView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
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

- (void)setTicketArray:(NSArray<TicketModel *> *)ticketArray
{
    _ticketArray = ticketArray;
    
    [self reloadData];
}

#pragma mark - tableViewDataSource,UITableViewDelegate

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ticketArray.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketModel *ticketModel = nil;
    ticketModel = [self.ticketArray objectAtIndex:indexPath.row];
    
    if (ticketModel.limitAmount.length == 0) {
        TicketInvalidNoLimitCell *cell = [tableView dequeueReusableCellWithIdentifier: @""];
        if (!cell) {
            cell = [[TicketInvalidNoLimitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TicketInvalidNoLimitCell" limitCount:ticketModel.limits.count];
        }
        cell.ticketModel = ticketModel;
        return cell;
    }else {
        TicketInvalidBeLimitCell *cell = [tableView dequeueReusableCellWithIdentifier: @""];
        if (!cell) {
            cell = [[TicketInvalidBeLimitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TicketInvalidBeLimitCell" limitCount:ticketModel.limits.count];
        }
        cell.ticketModel = ticketModel;
        return cell;
    }
}

//当已经点击cell时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

@end
