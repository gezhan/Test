//
//  ShopCardTView.m
//  WinShare
//
//  Created by QIjikj on 2017/8/23.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopCardTView.h"
#import "ShopCardCell.h"
#import "ShopCardListModel.h"

@interface ShopCardTView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ShopCardTView
@synthesize cardListArray = _cardListArray;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)setCardListArray:(NSArray *)cardListArray
{
    _cardListArray = cardListArray;
    [self reloadData];
}

#pragma mark - tableViewDataSource,UITableViewDelegate

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cardListArray.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopCardCell *shopCardCell = [tableView dequeueReusableCellWithIdentifier:@"ShopCardCell"];
    if (!shopCardCell) {
        shopCardCell = [[ShopCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopCardCell"];
    }
    
    ShopCardListModel *shopCardListModel = [self.cardListArray objectAtIndex:indexPath.row];
    shopCardCell.shopCardListModel = shopCardListModel;
    return shopCardCell;
}

// 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 155;
}

// 区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

//当已经点击cell时
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - lazyLoad

- (NSArray *)cardListArray
{
    if (!_cardListArray) {
        _cardListArray = [[NSArray alloc] init];
    }
    return _cardListArray;
}

@end
