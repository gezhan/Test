//
//  WSFRPSiteSetMealApiModel.m
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPSiteSetMealApiModel.h"

@implementation WSFRPSiteSetMealApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"setMealId" : @"SetMealId",
             @"mealNo" : @"MealNo",
             @"siteMealId" : @"SiteMealId",
             @"minimum" : @"Minimum",
             @"mealContent" : @"MealContent"

             };
}

@end
