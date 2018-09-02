//
//  WSFSetMealModel.m
//  WinShare
//
//  Created by devRen on 2017/12/5.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFSetMealModel.h"

@implementation WSFSetMealModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"mealID" : @"Id",
             @"roomId" : @"RoomId",
             @"mealNo" : @"MealNo",
             @"minimum" : @"Minimum",
             @"mealContent" : @"MealContent",
             };
}

- (instancetype)initWithMinimum:(NSInteger)minimum mealNo:(NSString *)mealNo {
    self = [super init];
    if (self) {
        _minimum = minimum;
        _mealNo = mealNo;
        _mealContent = @"2杯咖啡、2杯咖啡、2杯咖啡";
    }
    return self;
}

@end
