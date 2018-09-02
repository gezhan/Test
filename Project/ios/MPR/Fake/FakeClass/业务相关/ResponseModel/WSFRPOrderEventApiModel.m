//
//  WSFRPOrderEventApiModel.m
//  WinShare
//
//  Created by ZWL on 2018/3/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPOrderEventApiModel.h"

@implementation WSFRPOrderEventApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"beginTime" : @"BeginTime",
             @"roomName" : @"RoomName",
             @"totalPrice" : @"TotalPrice",
             @"status" : @"Status",
             @"orderDescription" : @"OrderDescription",
             @"payPrice" : @"PayPrice",
             @"remainingSeconds" : @"RemainingSeconds",
             @"picture" : @"Picture",
             @"endPayTime" : @"EndPayTime",
             @"eventName" : @"EventName",
             @"endTime" : @"EndTime",
             @"roomAddress" : @"RoomAddress",
             @"roomId" : @"RoomId",
             @"eventTime" : @"EventTime",
             @"orderCode" : @"OrderCode",
             @"yBeiIsEnough" : @"YBeiIsEnough",
             @"phone" : @"Phone",
             @"manName" : @"ManName",
             @"createTime" : @"CreateTime",
             @"payWay" : @"PayWay",
             @"orderId" : @"OrderId",
             @"manTel" : @"ManTel"
             };
}

+ (NSValueTransformer *)pictureJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[WSFRPPhotoApiModel class]];
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

+ (NSValueTransformer *)payWayJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[WSFRPKeyValueStrModel class]];
}

+ (NSValueTransformer *)createTimeJSONTransformer {
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
