//
//  WSFRPResultKeyInfo.m
//  WinShare
//
//  Created by GZH on 2018/1/29.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPResultKeyInfo.h"
#import "WSFRPLockVersionInfo.h"

@implementation WSFRPResultKeyInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"keyBoardPwdId" : @"KeyBoardPwdId",
             @"keyBoardPwd" : @"KeyBoardPwd",
             @"lockId" : @"LockId",
             @"keyId" : @"KeyId",
             @"keyStatus" : @"KeyStatus",
             @"lockKey" : @"LockKey",
             @"lockMac" : @"LockMac",
             @"lockFlagPos" : @"LockFlagPos",
             @"aesKeyStr" : @"AesKeyStr",
             @"startDate" : @"StartDate",
             @"endDate" : @"EndDate",
             @"userType" : @"UserType",
             @"lockName" : @"LockName",
             @"lockAlias" : @"LockAlias",
             @"adminPwd" : @"AdminPwd",
             @"noKeyPwd" : @"NoKeyPwd",
             @"deletePwd" : @"DeletePwd",
             @"electricQuantity" : @"ElectricQuantity",
             @"remarks" : @"Remarks",
             @"timezoneRawOffset" : @"TimezoneRawOffset",
             @"lockVersion" : @"LockVersion"
             };
}

+ (NSValueTransformer *)lockVersionJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:WSFRPLockVersionInfo.class];
}

@end
