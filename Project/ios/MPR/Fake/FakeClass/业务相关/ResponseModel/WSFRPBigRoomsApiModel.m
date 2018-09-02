//
//  WSFRPBigRoomsApiModel.m
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPBigRoomsApiModel.h"

@implementation WSFRPBigRoomsApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"roomName" : @"RoomName",
             @"roomId" : @"RoomId",
             @"address" : @"Address",
             @"capacity" : @"Capacity",
             @"price" : @"Price",
             @"picture" : @"Picture",
             @"theMeter" : @"TheMeter",
             @"roomType" : @"RoomType"

             };
}

+ (NSValueTransformer *)pictureJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:WSFRPPhotoApiModel.class];
}

@end
