//
//  WSFRPOrderListApiModel.h
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
#import "WSFRPPhotoApiModel.h"

/** 订单所属类型*/
typedef NS_ENUM(NSUInteger, WSFRPEnumOrderTheType) {
    WSFRPEnumOrderTheType_SmallRoom = 1,  // 小包厢
    WSFRPEnumOrderTheType_BigRoom = 2,    // 大场地
    WSFRPEnumOrderTheType_Event = 3       // 活动
};

/**
 订单列表Cell信息
 */
@interface WSFRPOrderListApiModel : MTLModel <MTLJSONSerializing>

/** 订单ID*/
@property (nonatomic, copy) NSString *orderId;
/** 空间名称*/
@property (nonatomic, copy) NSString *roomName;
/** 空间地址*/
@property (nonatomic, copy) NSString *roomAddress;
/** 空间图片*/
@property (nonatomic, strong) WSFRPPhotoApiModel *picture;
/** 预计开始时间*/
@property (nonatomic, strong) NSDate *beginTime;
/** 预计结束时间*/
@property (nonatomic, strong) NSDate *endTime;
/** 使用费用*/
@property (nonatomic, assign) CGFloat costPrice;
/** 押金*/
@property (nonatomic, assign) CGFloat depositPrice;
/** 实际    Z_F金额*/
@property (nonatomic, assign) CGFloat payPrice;
/** ！活动费用（eg1:￥60 ；eg2:免费）*/
@property (nonatomic, copy) NSString *theFee;
/** 订单生成日期*/
@property (nonatomic, strong) NSDate *createTime;
/** 订单状态*/
@property (nonatomic, copy) NSString *status;
/** 1-取消的订单；2-提前结束的订单*/
@property (nonatomic, copy) NSString *way;
/** 是否需要退款*/
@property (nonatomic, assign) BOOL needRefund;
/** 订单所属类型*/
@property (nonatomic, assign) WSFRPEnumOrderTheType orderTheType;

@end
