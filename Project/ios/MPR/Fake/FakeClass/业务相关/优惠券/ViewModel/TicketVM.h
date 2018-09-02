//
//  TicketVM.h
//  WinShare
//
//  Created by GZH on 2017/8/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketVM : NSObject

/**
 获取我的优惠券列表数据

 @param overdue false-有效列表，ture-失效界面
 @param orderId 订单ID（只是查看时传空字符串）
 @param payWayType 选择的    Z_F方式（只是查看时传0）
 @param pageIndex 第几页
 @param pageSize 每页数量
 @param success 优惠券列表数据
 @param type 687-优惠券； 565-饮品券
 */
+ (void)getTicketListDataWithOverdue:(BOOL)overdue orderId:(NSString *)orderId payWayType:(WSFPayWayType)payWayType pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize type:(NSInteger)type success:(void(^)(BOOL isHaveDisableTicket, NSArray *ticketList))success failed:(void(^)(NSError *error))failed;


/**
 根据优惠券id查询具体详情
 
 @param ticketId 优惠券id
 @param success 优惠券数据
 */
+ (void)getTicketDetailDataWithTicketId:(NSString *)ticketId success:(void(^)(NSArray *ticketDict))success failed:(void(^)(NSError *error))failed;


/**
 将优惠券绑定在订单上
 
 @param orderId 订单id
 @param ticketId 优惠券id
 */
+ (void)useTicketForOrderId:(NSString *)orderId ticketId:(NSString *)ticketId success:(void(^)(NSDictionary *respondData))success failed:(void(^)(NSError *error))failed;

@end
