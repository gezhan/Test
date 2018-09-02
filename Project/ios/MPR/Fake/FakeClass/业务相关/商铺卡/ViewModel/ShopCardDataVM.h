//
//  ShopCardDataVM.h
//  WinShare
//
//  Created by Gzh on 2017/9/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCardDataVM : NSObject


/**
 获取商铺卡列表数据
 */
+ (void)getShopCardListDataSuccess:(void(^)(NSArray *shopCardList))success failed:(void(^)(NSError *error))failed;


/**
 获取商铺卡详细数据有哪些月份有数据

 @param success 有数据的月份数组
 */
+ (void)getShopCardDetailAccountWithRoomId:(NSString *)roomId success:(void(^)(NSArray *shopCardDetailAccount))success failed:(void(^)(NSError *error))failed;


/**
 获取某一个月商铺卡的使用详情

 @param roomId 空间id
 @param monthString 月份名称（例如；2017-08）
 @param pageIndex 从第几页数据开始
 @param pageSize 每页数据的数量
 @param success 商铺卡一个月使用明细数据
 */
+ (void)getShopCardDetailDataWithRoomId:(NSString *)roomId monthString:(NSString *)monthString pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(void(^)(NSInteger totalDuration, NSArray *shopCardDetailAccount))success failed:(void(^)(NSError *error))failed;

@end
