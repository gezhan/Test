//
//  ShopListDetailTView.h
//  WinShare
//
//  Created by QIjikj on 2017/7/12.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopListDetailModel, ShopListDetailHeadModel;

@interface ShopListDetailTView : UITableView

@property (nonatomic, strong) ShopListDetailHeadModel *shopListDetailHeadModel;//详情页头部信息
@property (nonatomic, strong) NSArray <ShopListDetailModel *> *shopListDetailModelArr;//详情页每个订单信息

@end
