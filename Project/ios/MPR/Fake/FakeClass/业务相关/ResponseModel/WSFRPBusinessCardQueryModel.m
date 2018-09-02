//
//  WSFRPBusinessCardQueryModel.m
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPBusinessCardQueryModel.h"

@implementation WSFRPBusinessCardQueryModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"theMonth" : @"TheMonth",
             @"roomId" : @"RoomId",
             @"pageSize" : @"PageSize",
             @"totalCount" : @"TotalCount",
             @"totalDuration" : @"TotalDuration",
             @"pageIndex" : @"PageIndex",
             @"records" : @"Records"

             };
}

+ (NSValueTransformer *)recordsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFRPBusinessCardDetailModel.class];
}

@end
