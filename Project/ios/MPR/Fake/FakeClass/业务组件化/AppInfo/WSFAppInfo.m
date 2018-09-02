//
//  WSFAppInfo.m
//  WinShare
//
//  Created by Gzh on 2017/11/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFAppInfo.h"

@implementation WSFAppInfo

/** 获取app平台的客服电话 */
+(NSString *)getTelephone
{
    return [PathUserDefaults objectForKey:@"APP_Telephone"];
}

+(void)saveTelephone:(NSString *)telephone
{
    [PathUserDefaults setObject:telephone forKey:@"APP_Telephone"];
    [PathUserDefaults synchronize];
}

/** 获取app被拒绝更新的版本 */
+(NSString *)getRefuseVersion
{
    return [PathUserDefaults objectForKey:@"APP_RefuseVersion"];;
}

+(void)saveRefuseVersion:(NSString *)refuseVersion
{
    [PathUserDefaults setObject:refuseVersion forKey:@"APP_RefuseVersion"];
    [PathUserDefaults synchronize];
}

@end
