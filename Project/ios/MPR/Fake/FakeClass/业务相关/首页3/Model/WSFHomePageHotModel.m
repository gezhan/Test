//
//  WSFHomePageHotModel.m
//  WinShare
//
//  Created by GZH on 2018/1/11.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFHomePageHotModel.h"



@implementation WSFHomePageCarouselModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"Id"          : @"Id",
             @"jumpRoomId"  : @"JumpRoomId",
             @"jumpUrl"     : @"JumpUrl",
             @"sort"        : @"Sort",
             @"picture"     : @"Picture",
             @"jumpType"    : @"JumpType"
             };
}

@end

@implementation WSFHomePageHotRoomModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"Id"           : @"Id",
             @"roomId"       : @"RoomId",
             @"roomName"      : @"RoomName",
             @"sort"          : @"Sort",
             @"picture"       : @"Picture",
             @"price"       : @"Price",
             @"typeOfRoom"    : @"TypeOfRoom"
             };
}

@end

@implementation WSFHomePageHotModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"carousel"   : @"Carousel",
             @"hotRoom"    : @"HotRoom"
             };
}

+ (NSValueTransformer *)carouselJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFHomePageCarouselModel.class];
}

+ (NSValueTransformer *)hotRoomJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFHomePageHotRoomModel.class];
}


@end

