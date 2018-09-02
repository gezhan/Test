//
//  WSFRPVersionApiModel.m
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPVersionApiModel.h"

@implementation WSFRPVersionApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"isMust" : @"IsMust",
             @"versionCode" : @"VersionCode",
             @"enabled" : @"Enabled",
             @"Id" : @"Id",
             @"createTime" : @"CreateTime",
             @"iteration" : @"Iteration",
             @"modifyTime" : @"ModifyTime",
             @"appSystem" : @"AppSystem",
             @"url" : @"Url"

             };
}

@end
