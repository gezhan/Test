//
//  WSFDrinkTicketTableView.m
//  WinShare
//
//  Created by devRen on 2017/10/27.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDrinkTicketTView.h"
#import "WSFDrinkTicketCell.h"
#import "WSFDrinkTicketLookDisableCell.h"
#import "WSFDrinkTicketInvalidVC.h"
#import "TicketModel.h"

static NSString * const kTicketLookDisableCellIdentifier = @"TicketLookDisableCell";
static NSString * const kTicketWSFDrinkTicketCell = @"WSFDrinkTicketCell";
static NSString * const kNotFoundImageViewImage = @"yinpiniquan_none";
static NSString * const kDisabledTicketBtnTitle = @"查看失效券>>";

@interface WSFDrinkTicketTView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *showMessageView;
@property (nonatomic, strong) UIImageView *notFoundImageView;
@property (nonatomic, strong) HSBlockButton *disabledTicketBtn;

@end

@implementation WSFDrinkTicketTView

#pragma mark - init初始化
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

#pragma mark - Delegate DateSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_drinkTicketArray.count == 0) {
        return 0;
    }
    return _drinkTicketArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _drinkTicketArray.count) {
        WSFDrinkTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:kTicketWSFDrinkTicketCell];
        if (!cell) {
            cell = [[WSFDrinkTicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTicketWSFDrinkTicketCell cellType:WSFDrinkTicketCellType_valid];
        }
        
        [cell theAssignmentWithTicketModel:_drinkTicketArray[indexPath.row]];
        return cell;
    } else {
        WSFDrinkTicketLookDisableCell *cell = [tableView dequeueReusableCellWithIdentifier:kTicketLookDisableCellIdentifier];
        if (!cell) {
            cell = [[WSFDrinkTicketLookDisableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTicketLookDisableCellIdentifier];
        }
        cell.isHaveDisableTicket = self.isHaveDisableTicket;
//        cell.isHaveDisableTicket = NO;
        return cell;
    }
}

- (void)showTicketImageWithRowCount:(NSInteger)rowCount WithNoValidTicket:(BOOL)isNoValidTicket {
    if (rowCount == 0) {
        _showMessageView = [[UIView alloc] initWithFrame:self.bounds];
        _showMessageView.backgroundColor = HEX_COLOR_0xEFEFF4;
        [_showMessageView addSubview:self.notFoundImageView];
        [self.disabledTicketBtn setEnabled:isNoValidTicket];
        self.backgroundView = _showMessageView;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

#pragma mark - set方法
- (void)setDrinkTicketArray:(NSArray<TicketModel *> *)drinkTicketArray {
    _drinkTicketArray = drinkTicketArray;
    [self showTicketImageWithRowCount:_drinkTicketArray.count WithNoValidTicket:self.isHaveDisableTicket];
    [self reloadData];
}

#pragma mark - 懒加载
- (UIImageView *)notFoundImageView {
    if (!_notFoundImageView) {
        _notFoundImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        UIImage *failImage = [UIImage imageNamed:kNotFoundImageViewImage];
        _notFoundImageView.width = failImage.size.width;
        _notFoundImageView.height = failImage.size.height;
        _notFoundImageView.top = (self.size.height - failImage.size.height)/2.f - 64;
        _notFoundImageView.image = failImage;
        CGPoint center = _notFoundImageView.center;
        center.x = _showMessageView.center.x;
        _notFoundImageView.center = center;
    }
    return _notFoundImageView;
}

- (HSBlockButton *)disabledTicketBtn {
    if (!_disabledTicketBtn) {
        _disabledTicketBtn = [HSBlockButton buttonWithType:UIButtonTypeCustom];
        [_disabledTicketBtn setTitle:kDisabledTicketBtnTitle forState:UIControlStateNormal];
        [_disabledTicketBtn setTitleColor:HEX_COLOR_0x2B84C6 forState:UIControlStateNormal];
        [_disabledTicketBtn setTitleColor:HEX_COLOR_0xCCCCCC forState:UIControlStateDisabled];
        [_disabledTicketBtn.titleLabel setFont:SYSTEMFONT_12];
        [_disabledTicketBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        __weak typeof(self) weakSelf = self;
        [_disabledTicketBtn addTouchUpInsideBlock:^(UIButton *button) {
            [weakSelf.viewController.navigationController pushViewController:[[WSFDrinkTicketInvalidVC alloc] init] animated:NO];
        }];
        [_showMessageView addSubview:_disabledTicketBtn];
        [_disabledTicketBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_showMessageView.mas_centerX).offset(0);
            make.bottom.mas_equalTo(_showMessageView.mas_bottom).offset(-22);
        }];
    }
    return _disabledTicketBtn;
}

@end
