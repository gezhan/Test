//
//  WSFDrinkTicketNetwork.h
//  WinShare
//
//  Created by devRen on 2017/10/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface WSFDrinkTicketNetwork : NSObject

/**
 获取我的饮品券列表数据
 
 @param overdue false-有效列表，ture-失效界面
 @param orderId 订单ID（只是查看时传空字符串）
 @param payWayType 选择的    Z_F方式（只是查看时传0）
 @param pageIndex 第几页
 @param pageSize 每页数量
 @param success 优惠券列表数据
 @param type 687-优惠券； 565-饮品券
 */
+ (void)getDrinkTicketListDataWithOverdue:(BOOL)overdue orderId:(NSString *)orderId payWayType:(WSFPayWayType)payWayType pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize type:(NSInteger)type success:(void(^)(BOOL isHaveDisableTicket, NSArray *ticketList))success failed:(void(^)(NSError *error))failed;

/**
 获取饮品券回收列表

 @param pageIndex 第几页
 @param pageSize 每页数量
 @param success 获取成功的回调
 @param failed 获取失败的回调
 */
+ (void)getDrinkTicketBackListWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(void(^)(id data))success failed:(void(^)(NSError *error))failed;

/**
 扫描饮品券二维码获取饮品券信息

 @param couponCode 优惠券代码
 @param success 获取成功的回调
 @param failed 获取失败的回调
 */
+ (void)getDrinkTicketDetailWithCouponCode:(nonnull NSString *)couponCode success:(void(^)(id data))success failed:(void(^)(NSError *error))failed;

/**
 回收优惠券

 @param couponCode 优惠券代码
 @param success 获取成功的回调
 @param failed 获取失败的回调
 */
+ (void)postDrinkTicketQRBackWithCouponCode:(nonnull NSString *)couponCode success:(void(^)(id data))success failed:(void(^)(NSError *error))failed;

@end
NS_ASSUME_NONNULL_END
