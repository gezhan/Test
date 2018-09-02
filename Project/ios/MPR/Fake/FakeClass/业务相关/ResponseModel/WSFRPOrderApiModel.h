//
//  WSFRPOrderApiModel.h
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
@class WSFRPPhotoApiModel;
@class WSFRPKeyValueStrModel;
@class WSFRPOrderRoomInfo;

/**
 小包厢订单详情信息
 */
@interface WSFRPOrderApiModel : MTLModel <MTLJSONSerializing>

/** 订单ID*/
@property (nonatomic, copy) NSString *orderId;
/** 订单唯一编号*/
@property (nonatomic, copy) NSString *orderCode;
/** 空间编号*/
@property (nonatomic, copy) NSString *roomID;
/** 空间名称*/
@property (nonatomic, copy) NSString *roomName;
/** 空间地址*/
@property (nonatomic, copy) NSString *roomAddress;
/** 空间价格*/
@property (nonatomic, assign) CGFloat roomPrice;
/** 空间图片*/
@property (nonatomic, strong) WSFRPPhotoApiModel *picture;
/** 下单人是否是此空间商家*/
@property (nonatomic, assign) BOOL isRoomBusiness;
/** 订单描述语*/
@property (nonatomic, copy) NSString *orderDescription;
/** 订单退款/补款信息(例：退款：100.0元)*/
@property (nonatomic, copy) NSString *orderRepairInfo;
/** 订单退款/补款途径(例：ZFB)*/
@property (nonatomic, copy) NSString *orderRepairWay;
/** 优惠券ID*/
@property (nonatomic, copy) NSString *couponId;
/** 优惠券名称*/
@property (nonatomic, copy) NSString *couponName;
/** 优惠券金额（数值）*/
@property (nonatomic, assign) CGFloat couponAmount;
/** 优惠券金额（字符）*/
@property (nonatomic, copy) NSString *couponAmountStr;
/** 是否用了优惠券*/
@property (nonatomic, assign) BOOL isUseCoupon;
/** 是否有优惠券可用*/
@property (nonatomic, assign) BOOL isHaveCoupon;
/** 订单生成日期*/
@property (nonatomic, strong) NSDate *createTime;
/** 截至    Z_F剩余毫秒数*/
@property (nonatomic, assign) CGFloat remainingSeconds;
/** 联系电话（商家）*/
@property (nonatomic, copy) NSString *phone;
/** 联系电话（平台）*/
@property (nonatomic, copy) NSString *winSharePhone;
/** 预订时长*/
@property (nonatomic, copy) NSString *duration;
/** 截至    Z_F时间*/
@property (nonatomic, strong) NSDate *endPayTime;
/** 预计开始时间*/
@property (nonatomic, strong) NSDate *beginTime;
/** 预计结束时间*/
@property (nonatomic, strong) NSDate *endTime;
/** 订单总金额*/
@property (nonatomic, assign) CGFloat totalPrice;
/** 使用费用*/
@property (nonatomic, assign) CGFloat costPrice;
/** 押金*/
@property (nonatomic, assign) CGFloat depositPrice;
/** 实际    Z_F金额*/
@property (nonatomic, assign) CGFloat payPrice;
/** 订单状态*/
@property (nonatomic, copy) NSString *status;
/** 订单    Z_F方式1-ZFB；2-赢贝*/
@property (nonatomic, copy) NSString *payWay;
/** 订单    Z_F方式1-ZFB；2-赢贝*/
@property (nonatomic, assign) NSInteger payWayInt;
/** 订单    Z_F方式1-ZFB；2-赢贝*/
@property (nonatomic, strong) WSFRPKeyValueStrModel *payWayStr;
/** 赢贝是否足以    Z_F订单 true-足以；false-不够*/
@property (nonatomic, assign) BOOL yBeiIsEnough;
/** 商铺卡是否足以    Z_F订单 true-足以；false-不够*/
@property (nonatomic, assign) BOOL cardIsEnough;
/** 钥匙信息*/
@property (nonatomic, strong) WSFRPOrderRoomInfo *keyInfo;
/** 连接分享地址*/
@property (nonatomic, copy) NSString *shareUrl;
/** 套餐编号*/
@property (nonatomic, copy) NSString *mealNo;
/** 套餐内容*/
@property (nonatomic, copy) NSString *mealContent;

@end
