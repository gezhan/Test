//
//  WSFFieldPriceStallAPIModel.m
//  WinShare
//
//  Created by QIjikj on 2018/1/17.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldPriceStallAPIModel.h"

@implementation WSFFieldPriceStallAPIModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"setMealId" : @"SetMealId",
             @"siteMealId" : @"SiteMealId",
             @"mealNo" : @"MealNo",
             @"minimum" : @"Minimum",
             @"mealContent" : @"MealContent",
             };
}

@end
