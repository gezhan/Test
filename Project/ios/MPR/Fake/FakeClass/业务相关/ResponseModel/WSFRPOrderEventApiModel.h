//
//  WSFRPOrderEventApiModel.h
//  WinShare
//
//  Created by ZWL on 2018/3/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

//#import "Mantle.h"
#import "WSFRPPhotoApiModel.h"
#import "WSFRPKeyValueStrModel.h"

/**
 活动订单详情信息
 */
@interface WSFRPOrderEventApiModel : MTLModel <MTLJSONSerializing>

/** 订单ID */
@property (nonatomic, copy) NSString *orderId;
/** 订单状态 */
@property (nonatomic, copy) NSString *status;
/** 订单描述语 */
@property (nonatomic, copy) NSString *orderDescription;
/** 空间编号 */
@property (nonatomic, copy) NSString *roomId;
/** 空间名称 */
@property (nonatomic, copy) NSString *roomName;
/** 空间地址 */
@property (nonatomic, copy) NSString *roomAddress;
/** 活动图片 */
@property (nonatomic, strong) WSFRPPhotoApiModel *picture;
/** 活动名称 */
@property (nonatomic, copy) NSString *eventName;
/** 活动开始时间 */
@property (nonatomic, strong) NSDate *beginTime;
/** 活动结束时间 */
@property (nonatomic, strong) NSDate *endTime;
/** 活动时间 */
@property (nonatomic, copy) NSString *eventTime;
/** 订单价格 */
@property (nonatomic, assign) CGFloat payPrice;
/** 订单总计 */
@property (nonatomic, assign) CGFloat totalPrice;
/** 报名信息：联系姓名 */
@property (nonatomic, copy) NSString *manName;
/** 报名信息：联系姓名 */
@property (nonatomic, copy) NSString *manTel;
/** 订单唯一编号 */
@property (nonatomic, copy) NSString *orderCode;
/** 订单    Z_F方式（1-ZFB；2-赢贝） */
@property (nonatomic, strong) WSFRPKeyValueStrModel *payWay;
/** 订单生成日期 */
@property (nonatomic, strong) NSDate *createTime;
/** 截至    Z_F剩余毫秒数 */
@property (nonatomic, assign) CGFloat remainingSeconds;
/** 截至    Z_F时间 */
@property (nonatomic, strong) NSDate *endPayTime;
/** 联系电话 */
@property (nonatomic, copy) NSString *phone;
/** 赢贝是否足以    Z_F订单true-足以；false-不够 */
@property (nonatomic, assign) BOOL yBeiIsEnough;

@end
