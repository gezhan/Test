//
//  WSFRPCouponApiModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"


/**
 优惠券列表cell信息
 */
@interface WSFRPCouponApiModel : MTLModel <MTLJSONSerializing>

/** 优惠券ID*/
@property (nonatomic, copy) NSString *couponId;
/** 优惠券名称*/
@property (nonatomic, copy) NSString *name;
/** 优惠券号码*/
@property (nonatomic, copy) NSString *couponCode;
/** 账户编号*/
@property (nonatomic, copy) NSString *profileId;
/** 面值（金额(单位元)/折扣率/时长（单位h））*/
@property (nonatomic, assign) CGFloat amount;
/** 折扣类型（减金额，折扣券，减时长）*/
@property (nonatomic, copy) NSString *amountType;
/** 限制条件(字典值包含：地区限制、金额限制、时间限制、空间限制、    Z_F限制)*/
@property (nonatomic, strong) NSArray *limits;
/** 限制条件-金额限制（eg:满100元可用）*/
@property (nonatomic, copy) NSString *limitAmount;
/** 是否已使用*/
@property (nonatomic, assign) BOOL isUsed;
/** 是否过期*/
@property (nonatomic, assign) BOOL isOverdue;
/** 生成日期*/
@property (nonatomic, strong) NSDate *createTime;
/** 有效期截止日期*/
@property (nonatomic, strong) NSDate *endTime;
/** 是否可用*/
@property (nonatomic, assign) BOOL isCanUse;

@end
