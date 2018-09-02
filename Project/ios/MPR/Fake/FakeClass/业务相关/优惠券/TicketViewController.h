//
//  TicketViewController.h
//  WinShare
//
//  Created by GZH on 2017/5/8.
//  Copyright © 2017年 QiJikj. All rights reserved.
//  可用的优惠券列表

#import "WSFBaseViewController.h"

/** 返回选中的优惠券的ID和面值。“不使用优惠券”返回的是@“”和0 */
typedef void(^selectTicketBlock)(NSString *ticketId, NSInteger ticketAmount);

@interface TicketViewController : WSFBaseViewController

/** YES-进入优惠券的选择界面 NO-进入优惠券的查看界面 */
@property (nonatomic, assign) BOOL skip;

/** 为指定的订单绑定优惠券 */
@property (nonatomic, copy) NSString *orderId;

/** 为指定的    Z_F方式绑定优惠券 */
@property (nonatomic, assign) WSFPayWayType payWayType;

/** 之前绑定的的优惠券ID，没有绑定过的话，传空字符串 */
@property (nonatomic, copy) NSString *previousTicketedId;

/** 如果进入的是优惠券的选择界面，选择任何一张优惠券后的回调block */
@property (nonatomic, copy) selectTicketBlock selectTicketBlock;


@end
