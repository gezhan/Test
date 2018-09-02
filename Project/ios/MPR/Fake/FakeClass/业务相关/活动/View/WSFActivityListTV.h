//
//  WSFActivityListTV.h
//  WinShare
//
//  Created by GZH on 2018/2/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSFActivityListVM;
/**
 用户 - 活动首页的tableView
 */
@interface WSFActivityListTV : UITableView

@property (nonatomic, strong) WSFActivityListVM *listVM;

@end
