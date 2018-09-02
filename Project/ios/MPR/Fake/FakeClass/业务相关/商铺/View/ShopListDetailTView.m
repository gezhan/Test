//
//  ShopListDetailTView.m
//  WinShare
//
//  Created by QIjikj on 2017/7/12.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopListDetailTView.h"
#import "ShopListDetailCell.h"
#import "ShopListDetailHeadCell.h"
#import "ShopListDetailModel.h"
#import "ShopListDetailHeadModel.h"
#import "WSFShopListDetailFieldCell.h"

@interface ShopListDetailTView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ShopListDetailTView
@synthesize shopListDetailModelArr = _shopListDetailModelArr, shopListDetailHeadModel = _shopListDetailHeadModel;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//        self.backgroundColor = HEX_COLOR_0xE5E5E5;
        self.estimatedRowHeight = 44;
        self.rowHeight = UITableViewAutomaticDimension;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)setShopListDetailHeadModel:(ShopListDetailHeadModel *)shopListDetailHeadModel
{
    _shopListDetailHeadModel = shopListDetailHeadModel;
    
    [self reloadData];
}

- (void)setShopListDetailModelArr:(NSArray<ShopListDetailModel *> *)shopListDetailModelArr
{
    _shopListDetailModelArr = shopListDetailModelArr;
    
    [self reloadData];
}

#pragma mark - tableViewDataSource,UITableViewDelegate

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shopListDetailModelArr.count + 1;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        ShopListDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopListDetailHeadCell"];
        if (!cell) {
            cell = [[ShopListDetailHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopListDetailHeadCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shopListDetailHeadModel = self.shopListDetailHeadModel;
        return cell;
        
    }else {
        ShopListDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopListDetailCell"];
        if (!cell) {
            cell = [[ShopListDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopListDetailCell"];
        }
        
        ShopListDetailModel *shopListDetailModel = [self.shopListDetailModelArr objectAtIndex:(indexPath.row - 1)];
        cell.shopListDetailModel = shopListDetailModel;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
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

- (NSArray<ShopListDetailModel *> *)shopListDetailModelArr
{
    if (!_shopListDetailModelArr) {
        _shopListDetailModelArr = [[NSArray alloc] init];
    }
    return _shopListDetailModelArr;
}

- (ShopListDetailHeadModel *)shopListDetailHeadModel
{
    if (!_shopListDetailHeadModel) {
        _shopListDetailHeadModel = [[ShopListDetailHeadModel alloc] init];
    }
    return _shopListDetailHeadModel;
}

@end
