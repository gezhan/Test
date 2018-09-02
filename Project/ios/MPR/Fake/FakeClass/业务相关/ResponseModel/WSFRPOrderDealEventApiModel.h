//
//  WSFRPOrderDealEventApiModel.h
//  WinShare
//
//  Created by ZWL on 2018/3/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"

/**
 活动的取消订单数据
 */
@interface WSFRPOrderDealEventApiModel : MTLModel <MTLJSONSerializing>

/** 订单唯一编号 */
@property (nonatomic, copy) NSString *orderCode;
/** 活动名字 */
@property (nonatomic, copy) NSString *eventName;
/** 预订时间 */
@property (nonatomic, copy) NSString *orderTime;
/** 费用 */
@property (nonatomic, assign) CGFloat costPrice;
/** 可退费用 */
@property (nonatomic, assign) CGFloat refundPrice;
/** 可退赢贝 */
@property (nonatomic, assign) CGFloat refundYbei;
/** 可以退款方式1-ZFB/赢贝；2-只能赢贝 */
@property (nonatomic, assign) NSInteger returnWay;

@end
