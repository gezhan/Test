//
//  WSFRPOrderDealBigRApiModel.h
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"


/**
 大场地订单处理信息(大场地-取消订单信息)
 */
@interface WSFRPOrderDealBigRApiModel : MTLModel <MTLJSONSerializing>

/** 订单唯一编号*/
@property (nonatomic, copy) NSString *orderCode;
/** 预订时间*/
@property (nonatomic, copy) NSString *orderTime;
/** 定金(用户    Z_F金额)*/
@property (nonatomic, assign) CGFloat costPrice;
/** 可退费用*/
@property (nonatomic, assign) CGFloat refundPrice;
/** 可退赢贝*/
@property (nonatomic, assign) CGFloat refundYbei;
/** 可以退款方式 1-ZFB/赢贝； 2-只能赢贝*/
@property (nonatomic, assign) NSInteger returnWay;

@end
