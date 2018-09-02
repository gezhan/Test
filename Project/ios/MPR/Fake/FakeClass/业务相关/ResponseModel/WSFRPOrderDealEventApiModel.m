//
//  WSFRPOrderDealEventApiModel.m
//  WinShare
//
//  Created by ZWL on 2018/3/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPOrderDealEventApiModel.h"

@implementation WSFRPOrderDealEventApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"refundYbei" : @"RefundYbei",
             @"returnWay" : @"ReturnWay",
             @"costPrice" : @"CostPrice",
             @"orderTime" : @"OrderTime",
             @"refundPrice" : @"RefundPrice",
             @"eventName" : @"EventName",
             @"orderCode" : @"OrderCode"
             };
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return dateFormatter;
}

@end
