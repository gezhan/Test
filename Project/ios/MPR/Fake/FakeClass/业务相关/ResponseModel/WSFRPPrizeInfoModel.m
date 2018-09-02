//
//  WSFRPPrizeInfoModel.m
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPPrizeInfoModel.h"

@implementation WSFRPPrizeInfoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"amountType" : @"AmountType",
             @"limitAmount" : @"LimitAmount",
             @"amount" : @"Amount",
             @"useLimits" : @"UseLimits",
             @"creaTime" : @"CreaTime",
             @"type" : @"Type",
             @"prizeId" : @"PrizeId",
             @"code" : @"Code",
             @"typeKeyValue" : @"TypeKeyValue",
             @"validTime" : @"ValidTime",
             @"prizeName" : @"PrizeName",
             @"status" : @"Status"

             };
}

+ (NSValueTransformer *)typeKeyValueJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFRPKeyValueStrModel.class];
}

@end
