//
//  WSFRPRoomMealListModel.m
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPRoomMealListModel.h"

@implementation WSFRPRoomMealListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"Id" : @"Id",
             @"mealNo" : @"MealNo",
             @"roomId" : @"RoomId",
             @"minimum" : @"Minimum",
             @"mealContent" : @"MealContent"

             };
}

@end
