//
//  ShopListTView.h
//  WinShare
//
//  Created by QIjikj on 2017/7/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopListModel;

@interface ShopListTView : UITableView

@property (nonatomic, strong) NSArray <ShopListModel *> *shopListArray;
@property (nonatomic, assign) NSInteger userIdentifyNum;//获取用户身份标识（1-用户；2-商户；3-产业园商户）

@end
