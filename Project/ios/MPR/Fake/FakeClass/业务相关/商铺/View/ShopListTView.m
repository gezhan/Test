//
//  ShopListTView.m
//  WinShare
//
//  Created by QIjikj on 2017/7/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopListTView.h"
#import "ShopListCell.h"
#import "ShopListModel.h"
#import "ShopListDetailVC.h"
#import "WSFShopListOnWaitCell.h"
#import "WSFShopDetailBigRoomVC.h"

@interface ShopListTView ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation ShopListTView
@synthesize shopListArray = _shopListArray;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 44;
        self.rowHeight = UITableViewAutomaticDimension;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)setShopListArray:(NSArray<ShopListModel *> *)shopListArray
{
    _shopListArray = shopListArray;
    
    if (self.userIdentifyNum == 1) {//普通用户
        
        UIView *showMessageView = [[UIView alloc]initWithFrame:self.bounds];
        showMessageView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        
        UIImageView *iconImage = [[UIImageView alloc] init];
        iconImage.image = [UIImage imageNamed:@"lianxiwo"];
        [showMessageView addSubview:iconImage];
        [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(showMessageView.mas_centerY).offset(-64);
            make.centerX.mas_equalTo(showMessageView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(29, 29));
        }];
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.text = [NSString stringWithFormat:@"联系我们成为商户:%@", [WSFAppInfo getTelephone]];
        [textLabel setFont:[UIFont systemFontOfSize:14]];
        [showMessageView addSubview:textLabel];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(iconImage.mas_bottom).offset(20);
            make.centerX.mas_equalTo(showMessageView.mas_centerX);
        }];
        
        self.backgroundView = showMessageView;
        
    }else if (self.userIdentifyNum == 2) {//普通商户
        [self tableViewDisplayNotFoundViewWithRowCount:0 withImageName:@"shangxian"];
    }else {
        [self reloadData];
    }
    
}

#pragma mark - tableViewDataSource,UITableViewDelegate

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shopListArray.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopListModel *shopListModel = [self.shopListArray objectAtIndex:indexPath.row];
    if (shopListModel.waitOnline || shopListModel.shopListModelType == ShopListModelType_bigroom) {
        WSFShopListOnWaitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WSFShopListOnWaitCell"];
        if (!cell) {
            cell = [[WSFShopListOnWaitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WSFShopListOnWaitCell"];
        }
        cell.shopListModel = shopListModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        ShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopListCell"];
        if (!cell) {
            cell = [[ShopListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopListCell"];
        }
        cell.shopListModel = shopListModel;
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
    ShopListModel *shopListModel = [self.shopListArray objectAtIndex:indexPath.row];
    
    if (shopListModel.shopListModelType == ShopListModelType_smallRoom) {
        ShopListDetailVC *shopListDetailVC = [[ShopListDetailVC alloc] init];
        shopListDetailVC.spaceId = shopListModel.roomId;
        shopListDetailVC.spaceName = shopListModel.roomName;
        [self.viewController.navigationController pushViewController:shopListDetailVC animated:NO];
    }else {
        WSFShopDetailBigRoomVC *shopListDetailVC = [[WSFShopDetailBigRoomVC alloc] init];
        shopListDetailVC.spaceId = shopListModel.roomId;
        shopListDetailVC.spaceName = shopListModel.roomName;
        [self.viewController.navigationController pushViewController:shopListDetailVC animated:NO];
    }
}

#pragma mark - lazyLoad

- (NSArray<ShopListModel *> *)shopListArray
{
    if (!_shopListArray) {
        _shopListArray = [[NSArray alloc] init];
    }
    return _shopListArray;
}

@end
