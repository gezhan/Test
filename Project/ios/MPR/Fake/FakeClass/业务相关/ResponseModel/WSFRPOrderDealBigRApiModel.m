//
//  WSFRPOrderDealBigRApiModel.m
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPOrderDealBigRApiModel.h"

@implementation WSFRPOrderDealBigRApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"orderCode" : @"OrderCode",
             @"orderTime" : @"OrderTime",
             @"costPrice" : @"CostPrice",
             @"refundPrice" : @"RefundPrice",
             @"refundYbei" : @"RefundYbei",
             @"returnWay" : @"ReturnWay"
             };
}

@end
