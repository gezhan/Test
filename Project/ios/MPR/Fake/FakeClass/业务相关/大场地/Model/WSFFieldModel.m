//
//  WSFFieldModel.m
//  WinShare
//
//  Created by GZH on 2018/1/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldModel.h"
//@implementation WSFFieldPictureModel
//+ (NSDictionary *)JSONKeyPathsByPropertyKey {
//    return @{
////             @"Id"        : @"Id",
//             @"uRL"       : @"URL",
//             @"path"      : @"Path",
////             @"fileName"  : @"FileName",
//             };
//}
//
//@end

@implementation WSFFieldListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"roomId"      : @"RoomId",
             @"roomName"    : @"RoomName",
             @"address"     : @"Address",
             @"price"       : @"Price",
             @"theMeter"    : @"TheMeter",
             @"roomType"    : @"RoomType",
             @"capacity"    : @"Capacity",
             @"picture"     : @"Picture"
             };
}



@end

@implementation WSFFieldModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"totalCount"    : @"TotalCount",
             @"pageIndex"     : @"PageIndex",
             @"pageSize"      : @"PageSize",
             @"records"       : @"Records"
             };
}

+ (NSValueTransformer *)recordsJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFFieldListModel.class];
}

@end
