//
//  MineMessageVM.h
//  WinShare
//
//  Created by QIjikj on 2017/5/13.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineMessageVM : NSObject


/**
 获取用户当前剩余赢贝

 @param success 赢贝数量
 */
+ (void)getMineCurrentBalanceWithSuccess:(void(^)(NSString *balanceMoney))success failed:(void(^)(NSError *error))failed;


/**
 返回我的赢贝使用流水信息

 @param pageIndex 从第几页开始
 @param pageSize 每页显示的数量
 @param success 我的赢贝使用流水信息
 */
+ (void)getMineMoneyUsedRecordWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(void(^)(NSArray *moneyUsedRecord))success failed:(void(^)(NSError *error))failed;


/**
 获取用户身份标识（1-用户；2-商户；3-产业园商户）

 @param success 身份标识编号
 */
+ (void)getMineIdentifyDataSuccess:(void(^)(NSInteger identifyNumber))success failed:(void(^)(NSError *error))failed;

@end












