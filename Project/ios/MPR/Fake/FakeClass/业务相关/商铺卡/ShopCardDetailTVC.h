//
//  ShopCardDetailTVC.h
//  WinShare
//
//  Created by QIjikj on 2017/8/23.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCardDetailTVC : UITableViewController

/** 空间ID */
@property (nonatomic, copy) NSString *roomId;
/** 月份名称字符串（例如：2017-08） */
@property (nonatomic, copy) NSString *monthNameString;

@end
