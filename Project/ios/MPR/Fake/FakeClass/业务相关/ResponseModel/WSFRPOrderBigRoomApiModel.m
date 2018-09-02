//
//  WSFRPOrderBigRoomApiModel.m
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPOrderBigRoomApiModel.h"
#import "WSFRPPhotoApiModel.h"
#import "WSFRPKeyValueStrModel.h"

@implementation WSFRPOrderBigRoomApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"orderId" : @"OrderId",
             @"status" : @"Status",
             @"orderDescription" : @"OrderDescription",
             @"roomId" : @"RoomId",
             @"roomName" : @"RoomName",
             @"roomAddress" : @"RoomAddress",
             @"picture" : @"Picture",
             @"useTime" : @"UseTime",
             @"siteMeal" : @"SiteMeal",
             @"setMeal" : @"SetMeal",
             @"setMealPrice" : @"SetMealPrice",
             @"totalPrice" : @"TotalPrice",
             @"payPrice" : @"PayPrice",
             @"manNum" : @"ManNum",
             @"remark" : @"Remark",
             @"orderCode" : @"OrderCode",
             @"payWay" : @"PayWay",
             @"createTime" : @"CreateTime",
             @"beginTime" : @"BeginTime",
             @"endTime" : @"EndTime",
             @"discountsType" : @"DiscountsType",
             @"discountsAmount" : @"DiscountsAmount",
             @"remainingSeconds" : @"RemainingSeconds",
             @"endPayTime" : @"EndPayTime",
             @"phone" : @"Phone",
             @"yBeiIsEnough" : @"YBeiIsEnough"
             };
}

+ (NSValueTransformer *)pictureJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:WSFRPPhotoApiModel.class];
}

+ (NSValueTransformer *)payWayJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:WSFRPKeyValueStrModel.class];
}

+ (NSValueTransformer *)createTimeJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
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

+ (NSValueTransformer *)endPayTimeJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return dateFormatter;
}

@end
