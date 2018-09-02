//
//  UITableView+ShowMessageView.h
//  WinShare
//
//  Created by GZH on 2017/5/23.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (ShowMessageView)

- (void)tableViewDisplayNotFoundViewWithRowCount:(NSInteger)rowCount withImageName:(NSString *)imageName;

- (void)tableViewDisplayNotFoundViewWithNetworkLoss:(BOOL)networkLoss withImageName:(NSString *)imageName clickString:(NSString *)clickString clickBlock:(void(^)())block;

@end
