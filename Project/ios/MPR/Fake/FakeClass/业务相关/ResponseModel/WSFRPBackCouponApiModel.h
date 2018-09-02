//
//  WSFRPBackCouponApiModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"


/**
 回收饮品券列表cell信息
 */
@interface WSFRPBackCouponApiModel : MTLModel <MTLJSONSerializing>

/** 饮品券ID */
@property (nonatomic, copy) NSString *couponId;
/** 饮品券名称 */
@property (nonatomic, copy) NSString *name;
/** 面值（金额(单位元)/折扣率/时长（单位h）） */
@property (nonatomic, assign) CGFloat amount;
/** 限制条件(字典值包含：地区限制、金额限制、时间限制、空间限制、    Z_F限制) */
@property (nonatomic, strong) NSArray *limits;
/** 兑换日期 */
@property (nonatomic, strong) NSDate *backTime;

@end
