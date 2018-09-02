//
//  WSFRPSiteMealListModel.m
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPSiteMealListModel.h"

@implementation WSFRPSiteMealListModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"records" : @"Records",
             @"isTip" : @"IsTip",
             @"tip" : @"Tip"

             };
}

+ (NSValueTransformer *)recordsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFRPRoomSiteMealsModel.class];
}

@end
