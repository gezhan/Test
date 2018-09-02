//
//  WSFRPOrderListApiModel.m
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPOrderListApiModel.h"

@implementation WSFRPOrderListApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"orderId" : @"OrderId",
             @"roomName" : @"RoomName",
             @"roomAddress" : @"RoomAddress",
             @"picture" : @"Picture",
             @"beginTime" : @"BeginTime",
             @"endTime" : @"EndTime",
             @"costPrice" : @"CostPrice",
             @"depositPrice" : @"DepositPrice",
             @"payPrice" : @"PayPrice",
             @"theFee" : @"TheFee",
             @"createTime" : @"CreateTime",
             @"status" : @"Status",
             @"way" : @"Way",
             @"needRefund" : @"NeedRefund",
             @"orderTheType" : @"OrderTheType"
             };
}

+ (NSValueTransformer *)pictureJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:WSFRPPhotoApiModel.class];
}

+ (NSValueTransformer *)beginTimeJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)endTimeJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)createTimeJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)stateJSONTransformer {
    return [NSValueTransformer
            mtl_valueMappingTransformerWithDictionary:@{
                                                        @"WSFRPEnumOrderTheType_SmallRoom": @(1),
                                                        @"WSFRPEnumOrderTheType_BigRoom": @(2)
                                                        }];
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return dateFormatter;
}

@end
