//
//  WSFShopListDetailBigRoomTView.h
//  WinShare
//
//  Created by QIjikj on 2018/1/22.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSFBusinessBrDetailApiModel, ShopListDetailHeadModel;

@interface WSFShopListDetailBigRoomTView : UITableView

@property (nonatomic, strong) ShopListDetailHeadModel *shopListDetailHeadModel;//详情页头部信息
@property (nonatomic, strong) NSArray <WSFBusinessBrDetailApiModel *> *shopListDetailModelArr;//详情页每个订单信息

@end
