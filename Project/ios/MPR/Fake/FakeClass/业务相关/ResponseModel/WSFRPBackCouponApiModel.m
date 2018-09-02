//
//  WSFRPBackCouponApiModel.m
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPBackCouponApiModel.h"

@implementation WSFRPBackCouponApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"amount" : @"Amount",
             @"limits" : @"Limits",
             @"backTime" : @"BackTime",
             @"name" : @"Name",
             @"couponId" : @"CouponId"

             };
}

@end
