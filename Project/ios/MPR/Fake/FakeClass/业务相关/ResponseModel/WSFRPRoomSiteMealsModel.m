//
//  WSFRPRoomSiteMealsModel.m
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPRoomSiteMealsModel.h"

@implementation WSFRPRoomSiteMealsModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"timeType" : @"TimeType",
             @"roomId" : @"RoomId",
             @"siteMealId" : @"SiteMealId",
             @"beginTime" : @"BeginTime",
             @"endTime" : @"EndTime",
             @"setMeals" : @"SetMeals"

             };
}

+ (NSValueTransformer *)timeTypeJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:WSFRPKeyValueStrModel.class];
}

+ (NSValueTransformer *)setMealsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFRPSiteSetMealApiModel.class];
}

@end
