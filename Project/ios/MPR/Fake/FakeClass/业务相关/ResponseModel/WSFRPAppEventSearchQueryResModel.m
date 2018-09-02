//
//  WSFRPAppEventSearchQueryResModel.m
//  WinShare
//
//  Created by GZH on 2018/3/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPAppEventSearchQueryResModel.h"
#import "WSFRPAppEventSearchResModel.h"

@implementation WSFRPAppEventSearchQueryResModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"totalCount"    : @"TotalCount",
             @"pageIndex"     : @"PageIndex",
             @"pageSize"      : @"PageSize",
             @"records"       : @"Records"
             };
}

+ (NSValueTransformer *)recordsJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFRPAppEventSearchResModel.class];
}

@end
