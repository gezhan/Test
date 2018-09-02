//
//  WSFHomePageTVModel.m
//  WinShare
//
//  Created by GZH on 2018/1/22.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFHomePageTVModel.h"

@implementation WSFHomePageListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"roomId"      : @"RoomId",
             @"roomName"    : @"RoomName",
             @"address"     : @"Address",
             @"price"       : @"Price",
             @"theMeter"    : @"TheMeter",
             @"roomType"    : @"RoomType",
             @"capacity"    : @"Capacity",
             @"picture"     : @"Picture",
             @"typeOfRoom"  : @"TypeOfRoom"
             };
}



@end

@implementation WSFHomePageTVModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"totalCount"    : @"TotalCount",
             @"pageIndex"     : @"PageIndex",
             @"pageSize"      : @"PageSize",
             @"records"       : @"Records"
             };
}

+ (NSValueTransformer *)recordsJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFHomePageListModel.class];
}

@end
