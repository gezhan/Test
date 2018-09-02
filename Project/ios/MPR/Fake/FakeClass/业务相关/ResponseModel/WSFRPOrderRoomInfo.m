//
//  WSFRPOrderRoomInfo.m
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPOrderRoomInfo.h"
#import "WSFRPPhotoApiModel.h"
#import "WSFRPResultKeyInfo.h"

@implementation WSFRPOrderRoomInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"roomId" : @"RoomId",
             @"orderId" : @"OrderId",
             @"lockId" : @"LockId",
             @"roomName" : @"RoomName",
             @"address" : @"Address",
             @"photo" : @"Photo",
             @"beginTime" : @"BeginTime",
             @"endTime" : @"EndTime",
             @"actualEndTime" : @"ActualEndTime",
             @"keyInfo" : @"KeyInfo",
             @"identity" : @"Identity"
             };
}

+ (NSValueTransformer *)photoJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:WSFRPPhotoApiModel.class];
}

+ (NSValueTransformer *)keyInfoJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:WSFRPResultKeyInfo.class];
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

+ (NSValueTransformer *)actualEndTimeJSONTransformer {
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
