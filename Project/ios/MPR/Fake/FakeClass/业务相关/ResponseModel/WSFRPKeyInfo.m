//
//  WSFRPKeyInfo.m
//  WinShare
//
//  Created by GZH on 2018/1/29.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPKeyInfo.h"
#import "WSFRPLockVersionInfo.h"

@implementation WSFRPKeyInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"keyId" : @"keyId",
             @"lockId" : @"lockId",
             @"userType" : @"userType",
             @"keyStatus" : @"keyStatus",
             @"lockName" : @"lockName",
             @"lockAlias" : @"lockAlias",
             @"lockKey" : @"lockKey",
             @"lockMac" : @"lockMac",
             @"lockFlagPos" : @"lockFlagPos",
             @"adminPwd" : @"adminPwd",
             @"noKeyPwd" : @"noKeyPwd",
             @"deletePwd" : @"deletePwd",
             @"electricQuantity" : @"electricQuantity",
             @"aesKeyStr" : @"aesKeyStr",
             @"lockVersion" : @"lockVersion",
             @"startDate" : @"startDate",
             @"endDate" : @"endDate",
             @"timezoneRawOffset" : @"timezoneRawOffset",
             @"remarks" : @"remarks"
             };
}

+ (NSValueTransformer *)lockVersionJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:WSFRPLockVersionInfo.class];
}

@end
