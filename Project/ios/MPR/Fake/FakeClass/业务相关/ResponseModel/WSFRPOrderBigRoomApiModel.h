//
//  WSFRPOrderBigRoomApiModel.h
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
@class WSFRPPhotoApiModel;
@class WSFRPKeyValueStrModel;

/**
 大场地订单详情信息
 */
@interface WSFRPOrderBigRoomApiModel : MTLModel <MTLJSONSerializing>

/** 订单ID*/
@property (nonatomic, copy) NSString *orderId;
/** 订单状态*/
@property (nonatomic, copy) NSString *status;
/** 订单描述语*/
@property (nonatomic, copy) NSString *orderDescription;
/** 空间编号*/
@property (nonatomic, copy) NSString *roomId;
/** 空间名字*/
@property (nonatomic, copy) NSString *roomName;
/** 空间地址*/
@property (nonatomic, copy) NSString *roomAddress;
/** 空间照片*/
@property (nonatomic, strong) WSFRPPhotoApiModel *picture;
/** 使用时间(eg:2017-01-03)*/
@property (nonatomic, copy) NSString *useTime;
/** 场次及时间*/
@property (nonatomic, copy) NSString *siteMeal;
/** 套餐(价格档位)eg:1000元/场*/
@property (nonatomic, copy) NSString *setMeal;
/** 价格档位（eg:1000）*/
@property (nonatomic, assign) CGFloat setMealPrice;
/** 订单总金额*/
@property (nonatomic, assign) CGFloat totalPrice;
/** 实际    Z_F金额*/
@property (nonatomic, assign) CGFloat payPrice;
/** 附加信息（活动人数eg:6）*/
@property (nonatomic, assign) NSInteger manNum;
/** 附加信息（备注）*/
@property (nonatomic, copy) NSString *remark;
/** 订单唯一编号*/
@property (nonatomic, copy) NSString *orderCode;
/** 订单    Z_F方式（1-ZFB；2-赢贝）*/
@property (nonatomic, assign) WSFRPKeyValueStrModel *payWay;
/** 订单生成日期*/
@property (nonatomic, strong) NSDate *createTime;
/** 开始时间*/
@property (nonatomic, strong) NSDate *beginTime;
/** 结束时间*/
@property (nonatomic, strong) NSDate *endTime;
/** 优惠名称*/
@property (nonatomic, copy) NSString *discountsType;
/** 优惠金额*/
@property (nonatomic, assign) CGFloat discountsAmount;
/** 截至    Z_F剩余毫秒数*/
@property (nonatomic, assign) CGFloat remainingSeconds;
/** 截至    Z_F时间*/
@property (nonatomic, strong) NSDate *endPayTime;
/** 联系电话（商家*/
@property (nonatomic, copy) NSString *phone;
/** 赢贝是否足以    Z_F订单 true-足以；false-不够*/
@property (nonatomic, assign) BOOL yBeiIsEnough;

@end
