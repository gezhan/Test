//
//  ShopDataVM.h
//  WinShare
//
//  Created by QIjikj on 2017/7/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopDataVM : NSObject


/**
 获取商铺列表数据

 @param pageIndex 开始页码
 @param pageSize 每页数据的条数
 @param success 商铺列表数组
 */
+ (void)getShopListDataWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(void(^)(NSArray *shopListDataArray))success failed:(void(^)(NSError *error))failed;


/**
 获取指定商铺的经营情况与订单列表数据

 @param roomId 空间id
 @param pageIndex 开始页码
 @param pageSize 每页数据的条数
 @param success 指定商铺的经营情况,订单列表数据
 */
+ (void)getShopListDetailDataWithRoomId:(NSString *)roomId pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(void(^)(NSDictionary *shopIncomeDictionary, NSArray *shopListDetailArray))success failed:(void(^)(NSError *error))failed;


/**
 获取商铺邀请二维码的信息

 @param success 二维码的信息，用来生成二维码
 */
+ (void)getShopQRCodeMessageSuccess:(void(^)(NSString *QRCodeString))success failed:(void(^)(NSError *error))failed;

// ====================大场地

/**
 获取指定大场地的经营情况与订单列表数据
 
 @param roomId 空间id
 @param pageIndex 开始页码
 @param pageSize 每页数据的条数
 @param success 指定商铺的经营情况,订单列表数据
 */
+ (void)getShopListDetailBigRoomDataWithRoomId:(NSString *)roomId pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(void(^)(NSDictionary *shopIncomeDictionary, NSArray *shopListDetailArray))success failed:(void(^)(NSError *error))failed;



@end
