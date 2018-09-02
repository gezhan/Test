//
//  ShopCardTView.h
//  WinShare
//
//  Created by QIjikj on 2017/8/23.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopCardListModel;

@interface ShopCardTView : UITableView

@property (nonatomic, strong) NSArray <ShopCardListModel *> *cardListArray;//商铺卡数组

@end
