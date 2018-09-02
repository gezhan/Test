//
//  WSFRPLockVersionInfo.m
//  WinShare
//
//  Created by GZH on 2018/1/29.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPLockVersionInfo.h"

@implementation WSFRPLockVersionInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"protocolType" : @"ProtocolType",
             @"protocolVersion" : @"ProtocolVersion",
             @"scene" : @"Scene",
             @"groupId" : @"GroupId",
             @"orgId" : @"OrgId"
             };
}

@end
