//
//  WSFCityModel.m
//  WinShare
//
//  Created by GZH on 2017/12/19.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFCityModel.h"

@implementation WSFCityDetailModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"Id"          : @"Id",
             @"parentId"    : @"ParentId",
             @"regionName"  : @"RegionName",
             @"regionType"  : @"RegionType",
             @"isCapital"   : @"IsCapital",
             @"firstSpell"  : @"FirstSpell",
             };
}
@end

@implementation WSFCityArrayModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"spell"   : @"Spell",
             @"regions" : @"Regions"
             };
}

+ (NSValueTransformer *)regionsJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFCityDetailModel.class];
}

@end


@implementation WSFCityModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"regions" : @"Regions"
             };
}

+ (NSValueTransformer *)regionsJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFCityArrayModel.class];
}

@end






