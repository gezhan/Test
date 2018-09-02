//
//  WSFRPRoomBigApiModel.m
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPRoomBigApiModel.h"

@implementation WSFRPRoomBigApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"Id" : @"Id",
             @"Description" : @"Description",
             @"roomType" : @"RoomType",
             @"deviceItems" : @"DeviceItems",
             @"roomShareUrl" : @"RoomShareUrl",
             @"setMeals" : @"SetMeals",
             @"regionCode" : @"RegionCode",
             @"Long" : @"Long",
             @"roomName" : @"RoomName",
             @"capacity" : @"Capacity",
             @"address" : @"Address",
             @"price" : @"Price",
             @"areaSize" : @"AreaSize",
             @"theMeter" : @"TheMeter",
             @"tel" : @"Tel",
             @"photos" : @"Photos",
             @"lat" : @"Lat"

             };
}

+ (NSValueTransformer *)deviceItemsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFRPRoomFacilitiesModel.class];
}

+ (NSValueTransformer *)photosJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFRPPhotoApiModel.class];
}

+ (NSValueTransformer *)setMealsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFRPRoomSiteMealsModel.class];
}

@end
