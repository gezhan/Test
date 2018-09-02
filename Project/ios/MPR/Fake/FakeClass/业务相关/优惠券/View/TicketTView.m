//
//  TicketTView.m
//  WinShare
//
//  Created by GZH on 2017/8/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "TicketTView.h"
#import "TicketModel.h"
#import "TicketViewController.h"
#import "TicketNoLimitCell.h"
#import "TicketBeLimitCell.h"
#import "TicketLookDisableCell.h"
#import "TicketUnselectedCell.h"
#import "TicketInvalidViewController.h"

@interface TicketTView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSIndexPath *currentSelectedIndex;

@end

@implementation TicketTView

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
    
    // 在这里对已经选择的优惠券与ticketArray中的数据进行匹配，如果匹配上就对currentSelectedIndex进行赋值
    if (self.skip) {
        for (int i = 0; i < ticketArray.count; i++) {
            TicketModel *tempModel = [ticketArray objectAtIndex:i];
            if ([self.previousTicketedId isEqualToString:tempModel.couponId]) {
                self.currentSelectedIndex = [NSIndexPath indexPathForRow:i+1 inSection:0];
            }
            if ([self.previousTicketedId isEqualToString:@""]) {/** 表示之前没有绑定过优惠券 */
                self.currentSelectedIndex = [NSIndexPath indexPathForRow:0 inSection:0];
            }
        }
    }
    
    [self showTicketImageWithRowCount:_ticketArray.count WithNoValidTicket:self.isHaveDisableTicket];
    
    [self reloadData];
}

- (void)showTicketImageWithRowCount:(NSInteger)rowCount WithNoValidTicket:(BOOL)isNoValidTicket
{
    if (rowCount == 0) {
        UIView *showMessageView = [[UIView alloc]initWithFrame:self.bounds];
        showMessageView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        
        // 添加图片
        UIImageView *notFoundImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        UIImage *failImage = [UIImage imageNamed:@"youhuiquan_none"];
        notFoundImageView.width = failImage.size.width;
        notFoundImageView.height = failImage.size.height;
        notFoundImageView.top = (self.size.height - failImage.size.height)/2.f - 64;
        notFoundImageView.image = failImage;
        CGPoint center = notFoundImageView.center;
        center.x = showMessageView.center.x;
        notFoundImageView.center = center;
        [showMessageView addSubview:notFoundImageView];
        
        // 添加一个查看失效券按钮
        HSBlockButton *disabledTicketBtn = [HSBlockButton buttonWithType:UIButtonTypeCustom];
        [disabledTicketBtn setTitle:@"查看失效券>>" forState:UIControlStateNormal];
        [disabledTicketBtn setTitleColor:[UIColor colorWithHexString:@"#2b84c6"] forState:UIControlStateNormal];
        [disabledTicketBtn setTitleColor:[UIColor colorWithHexString:@"#cccccc"] forState:UIControlStateDisabled];
        [disabledTicketBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [disabledTicketBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [disabledTicketBtn setEnabled:isNoValidTicket];
        __weak typeof(self) weakSelf = self;
        [disabledTicketBtn addTouchUpInsideBlock:^(UIButton *button) {
            TicketInvalidViewController *ticketInvalidVC = [[TicketInvalidViewController alloc] init];
            [weakSelf.viewController.navigationController pushViewController:ticketInvalidVC animated:NO];
        }];
        [showMessageView addSubview:disabledTicketBtn];
        [disabledTicketBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(showMessageView.mas_centerX).offset(0);
            make.bottom.mas_equalTo(showMessageView.mas_bottom).offset(-22);
        }];
        
        self.backgroundView = showMessageView;
    }else{
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

#pragma mark - tableViewDataSource,UITableViewDelegate

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.skip && self.ticketArray.count > 0) {
        return self.ticketArray.count + 2;
    }else if (!self.skip && self.ticketArray.count > 0) {
        return self.ticketArray.count + 1;
    }else {
        return self.ticketArray.count;
    }
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketModel *ticketModel = nil;
    if (self.skip) {
        if (indexPath.row > 0 && indexPath.row < self.ticketArray.count + 1) {
            ticketModel = [self.ticketArray objectAtIndex:indexPath.row - 1];
        }
    }else {
        if (indexPath.row < self.ticketArray.count) {
            ticketModel = [self.ticketArray objectAtIndex:indexPath.row];
        }
    }
    
    if (self.skip) {
        if (indexPath.row == 0) {
            TicketUnselectedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TicketUnselectedCell"];
            if (!cell) {
                cell = [[TicketUnselectedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TicketUnselectedCell"];
            }
            if ([self.currentSelectedIndex compare:indexPath] == NSOrderedSame) {
                [cell.selectedLogo setHidden:NO];
            }
            return cell;
        }else if (indexPath.row < self.ticketArray.count + 1 && ticketModel.limitAmount.length == 0) {
            TicketNoLimitCell *ticketCell = [tableView dequeueReusableCellWithIdentifier:@""];
            if (!ticketCell) {
                ticketCell = [[TicketNoLimitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TicketNoLimitCell" limitCount:ticketModel.limits.count];
            }
            ticketCell.ticketModel = ticketModel;
            if ([self.currentSelectedIndex compare:indexPath] == NSOrderedSame) {
                [ticketCell.selectedLogo setHidden:NO];
            }
            return ticketCell;
        }else if (indexPath.row < self.ticketArray.count + 1 && ticketModel.limitAmount.length > 0) {
            TicketBeLimitCell *ticketCell = [tableView dequeueReusableCellWithIdentifier:@""];
            if (!ticketCell) {
                ticketCell = [[TicketBeLimitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TicketBeLimitCell" limitCount:ticketModel.limits.count];
            }
            ticketCell.ticketModel = ticketModel;
            if ([self.currentSelectedIndex compare:indexPath] == NSOrderedSame) {
                [ticketCell.selectedLogo setHidden:NO];
            }
            return ticketCell;
        }else {
            TicketLookDisableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TicketLookDisableCell"];
            if (!cell) {
                cell = [[TicketLookDisableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TicketLookDisableCell"];
            }
            cell.isHaveDisableTicket = self.isHaveDisableTicket;
            return cell;
        }
    }else {
        if (indexPath.row < self.ticketArray.count && ticketModel.limitAmount.length == 0) {
            TicketNoLimitCell *ticketCell = [tableView dequeueReusableCellWithIdentifier:@""];
            if (!ticketCell) {
                ticketCell = [[TicketNoLimitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TicketNoLimitCell" limitCount:ticketModel.limits.count];
            }
            ticketCell.ticketModel = ticketModel;
            return ticketCell;
        }else if (indexPath.row < self.ticketArray.count && ticketModel.limitAmount.length > 0) {
            TicketBeLimitCell *ticketCell = [tableView dequeueReusableCellWithIdentifier:@""];
            if (!ticketCell) {
                ticketCell = [[TicketBeLimitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TicketBeLimitCell" limitCount:ticketModel.limits.count];
            }
            ticketCell.ticketModel = ticketModel;
            return ticketCell;
        }
        else {
            TicketLookDisableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TicketLookDisableCell"];
            if (!cell) {
                cell = [[TicketLookDisableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TicketLookDisableCell"];
            }
            cell.isHaveDisableTicket = self.isHaveDisableTicket;
            return cell;
        }
    
    }
}

// 区首高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

// 区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

// 区首视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

// 区尾视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

//当已经点击cell时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.skip) {
        
        // 数据的准备
        TicketModel *ticketModel = nil;
        if (indexPath.row == 0) {// 如果不绑定优惠券，传@""作为优惠券的id，服务器作相应的识别处理
            TicketViewController *ticketVC = (TicketViewController *)self.viewController;
            ticketVC.selectTicketBlock(@"", 0);
        }else if (indexPath.row > 0 && indexPath.row <= self.ticketArray.count) {
            ticketModel = [self.ticketArray objectAtIndex:indexPath.row - 1];
            TicketViewController *ticketVC = (TicketViewController *)self.viewController;
            if (!ticketModel.isCanUse) {
                return;
            }
            ticketVC.selectTicketBlock(ticketModel.couponId, ticketModel.amount);
        }else {
        
        }
        
        // 当前被选中的优惠券做上标记
        BOOL isEqual = ([self.currentSelectedIndex compare:indexPath] == NSOrderedSame) ? YES : NO;
        if (!isEqual) {
            /** 将之前选中的优惠券标识符去掉 */
            UITableViewCell *selectedDidCell = [tableView cellForRowAtIndexPath:self.currentSelectedIndex];
            if ([selectedDidCell isKindOfClass:[TicketNoLimitCell class]]) {
                TicketNoLimitCell *cell = (TicketNoLimitCell *)selectedDidCell;
                [cell.selectedLogo setHidden:YES];
            }else if ([selectedDidCell isKindOfClass:[TicketBeLimitCell class]]) {
                TicketBeLimitCell *cell = (TicketBeLimitCell *)selectedDidCell;
                [cell.selectedLogo setHidden:YES];
            }else if ([selectedDidCell isKindOfClass:[TicketUnselectedCell class]]) {
                TicketUnselectedCell *cell = (TicketUnselectedCell *)selectedDidCell;
                [cell.selectedLogo setHidden:YES];
            }
            /** 重新赋值 */
            self.currentSelectedIndex = indexPath;
            /** 将新的选中的优惠券的标识符加上 */
            UITableViewCell *selectedWillCell = [tableView cellForRowAtIndexPath:self.currentSelectedIndex];
            if ([selectedWillCell isKindOfClass:[TicketNoLimitCell class]]) {
                TicketNoLimitCell *cell = (TicketNoLimitCell *)selectedWillCell;
                [cell.selectedLogo setHidden:NO];
            }else if ([selectedWillCell isKindOfClass:[TicketBeLimitCell class]]) {
                TicketBeLimitCell *cell = (TicketBeLimitCell *)selectedWillCell;
                [cell.selectedLogo setHidden:NO];
            }else if ([selectedWillCell isKindOfClass:[TicketUnselectedCell class]]) {
                TicketUnselectedCell *cell = (TicketUnselectedCell *)selectedWillCell;
                [cell.selectedLogo setHidden:NO];
            }
        }
        
    }
    
}

#pragma mark - 懒加载
- (NSIndexPath *)currentSelectedIndex
{
    if (!_currentSelectedIndex) {
        _currentSelectedIndex = [NSIndexPath indexPathForRow:0 inSection:9];
    }
    return _currentSelectedIndex;
}

@end
