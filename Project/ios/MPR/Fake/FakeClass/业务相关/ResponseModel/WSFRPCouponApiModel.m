//
//  WSFRPCouponApiModel.m
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPCouponApiModel.h"

@implementation WSFRPCouponApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"limits" : @"Limits",
             @"amountType" : @"AmountType",
             @"limitAmount" : @"LimitAmount",
             @"couponId" : @"CouponId",
             @"isCanUse" : @"IsCanUse",
             @"amount" : @"Amount",
             @"couponCode" : @"CouponCode",
             @"isUsed" : @"IsUsed",
             @"profileId" : @"ProfileId",
             @"createTime" : @"CreateTime",
             @"endTime" : @"EndTime",
             @"isOverdue" : @"IsOverdue",
             @"name" : @"Name"

             };
}

@end
