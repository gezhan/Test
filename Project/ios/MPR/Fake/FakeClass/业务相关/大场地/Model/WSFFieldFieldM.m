//
//  WSFFieldFieldM.m
//  WinShare
//
//  Created by GZH on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldFieldM.h"

//@implementation WSFFieldTimeTypeM
//+ (NSDictionary *)JSONKeyPathsByPropertyKey {
//    return @{
//             @"fieldKey"  : @"Key",
//             @"fieldTime" : @"Value"
//             };
//}
//@end

@implementation WSFFieldSetMealsM
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"setMealId" : @"SetMealId",
             @"siteMealId" : @"SiteMealId",
             @"mealNo" : @"MealNo",
             @"minimum" : @"Minimum",
             @"mealContent" : @"MealContent"
             };
}
@end

@implementation WSFFieldFieldM
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"siteMealId" : @"SiteMealId",
             @"roomId" : @"RoomId",
             @"beginTime" : @"BeginTime",
             @"endTime" : @"EndTime",
             @"meals" : @"SetMeals" ,
             @"timeType" : @"TimeType"
             };
}

+ (NSValueTransformer *)mealsJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFFieldSetMealsM.class];
}

@end
