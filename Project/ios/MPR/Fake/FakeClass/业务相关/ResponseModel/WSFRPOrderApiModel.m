//
//  WSFRPOrderApiModel.m
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPOrderApiModel.h"
#import "WSFRPPhotoApiModel.h"
#import "WSFRPKeyValueStrModel.h"
#import "WSFRPOrderRoomInfo.h"

@implementation WSFRPOrderApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"orderId" : @"OrderId",
             @"orderCode" : @"OrderCode",
             @"roomID" : @"RoomID",
             @"roomName" : @"RoomName",
             @"roomAddress" : @"RoomAddress",
             @"roomPrice" : @"RoomPrice",
             @"picture" : @"Picture",
             @"isRoomBusiness" : @"IsRoomBusiness",
             @"orderDescription" : @"OrderDescription",
             @"orderRepairInfo" : @"OrderRepairInfo",
             @"orderRepairWay" : @"OrderRepairWay",
             @"couponId" : @"CouponId",
             @"couponName" : @"CouponName",
             @"couponAmount" : @"CouponAmount",
             @"couponAmountStr" : @"CouponAmountStr",
             @"isUseCoupon" : @"IsUseCoupon",
             @"isHaveCoupon" : @"IsHaveCoupon",
             @"createTime" : @"CreateTime",
             @"remainingSeconds" : @"RemainingSeconds",
             @"phone" : @"Phone",
             @"winSharePhone" : @"WinSharePhone",
             @"duration" : @"Duration",
             @"endPayTime" : @"EndPayTime",
             @"beginTime" : @"BeginTime",
             @"endTime" : @"EndTime",
             @"totalPrice" : @"TotalPrice",
             @"costPrice" : @"CostPrice",
             @"depositPrice" : @"DepositPrice",
             @"payPrice" : @"PayPrice",
             @"status" : @"Status",
             @"payWay" : @"PayWay",
             @"payWayInt" : @"PayWayInt",
             @"payWayStr" : @"PayWayStr",
             @"yBeiIsEnough" : @"YBeiIsEnough",
             @"cardIsEnough" : @"CardIsEnough",
             @"keyInfo" : @"KeyInfo",
             @"shareUrl" : @"ShareUrl",
             @"mealNo" : @"MealNo",
             @"mealContent" : @"MealContent"
             };
}

+ (NSValueTransformer *)pictureJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:WSFRPPhotoApiModel.class];
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

+ (NSValueTransformer *)payWayStrJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[WSFRPKeyValueStrModel class]];
}

+ (NSValueTransformer *)keyInfoJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:[WSFRPOrderRoomInfo class]];
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return dateFormatter;
}

@end
