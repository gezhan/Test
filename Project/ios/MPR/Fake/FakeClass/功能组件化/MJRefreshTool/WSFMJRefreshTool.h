//
//  WSFMJRefreshTool.h
//  WinShare
//
//  Created by devRen on 2017/11/17.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

#ifndef WSFMJRefreshTool_h
#define WSFMJRefreshTool_h

/**
 重置刷新

 @param tableView 被刷新列表对象
 */
RYJKIT_STATIC_INLINE void RYJMJFooterResetNoMoreData(UITableView *tableView) {
    [tableView.mj_footer resetNoMoreData];
}

/**
 提示没有更多的数据

 @param tableView 被刷新列表对象
 */
RYJKIT_STATIC_INLINE void RYJMJEndRefreshingWithNoMoreData(UITableView *tableView) {
    [tableView.mj_footer endRefreshingWithNoMoreData];
}

/**
 停止 Footer 动画

 @param tableView 被刷新列表对象
 */
RYJKIT_STATIC_INLINE void RYJMJFooterEndRefreshing(UITableView *tableView) {
    if ([tableView.mj_footer isRefreshing]) {
        [tableView.mj_footer endRefreshing];
    }
}

/**
 停止 Header 动画

 @param tableView 被刷新列表对象
 */
RYJKIT_STATIC_INLINE void RYJMJHeaderEndRefreshing(UITableView *tableView) {
    if ([tableView.mj_header isRefreshing]) {
        [tableView.mj_header endRefreshing];
    }
}

/**
 停止 Header & Footer 动画

 @param tableView 被刷新列表对象
 */
RYJKIT_STATIC_INLINE void RYJMJEndRefreshing(UITableView *tableView) {
    RYJMJFooterEndRefreshing(tableView);
    RYJMJHeaderEndRefreshing(tableView);
}

/**
 通过判读数据有无停止动画 显示：no more data

 @param tableView 被刷新列表对象
 @param count 数据条数
 */
RYJKIT_STATIC_INLINE void RYJCommonMJRefreshEndRefreshing(UITableView *tableView, NSInteger count) {
    if (count == 0) {
        RYJMJEndRefreshingWithNoMoreData(tableView);
    } else {
        RYJMJFooterEndRefreshing(tableView);
    }
    RYJMJHeaderEndRefreshing(tableView);
}

#endif /* WSFMJRefreshTool_h */
