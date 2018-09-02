//
//  WSFUserInfo.m
//  WinShare
//
//  Created by Gzh on 2017/11/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFUserInfo.h"

@implementation WSFUserInfo

/** 获取用户设备唯一标识 */
+ (NSString *)getUUID {
    return [PathUserDefaults objectForKey:@"UUID"];
}

+ (void)saveUUID:(NSString *)userUUID {
    [PathUserDefaults setObject:userUUID forKey:@"UUID"];
    [PathUserDefaults synchronize];
}

/** 存储token */
+ (NSString *)getToken {
    return [PathUserDefaults objectForKey:@"Token"];
}

+ (void)saveToken:(NSString *)token {
    [PathUserDefaults setObject:token forKey:@"Token"];
    [PathUserDefaults synchronize];
}

/**  存储手机号 */
+ (NSString *)getPhone {
    return [PathUserDefaults objectForKey:@"Phone"];
}

+ (void)savePhone:(NSString *)token {
    [PathUserDefaults setObject:token forKey:@"Phone"];
    [PathUserDefaults synchronize];
}

/** 用户身份标识 */
+ (WSFUserIdentifyType)getIdentify {
    return [PathUserDefaults integerForKey:@"Identify"];
}

+ (void)saveIdentify:(NSInteger)identify {
    [PathUserDefaults setInteger:identify forKey:@"Identify"];
    [PathUserDefaults synchronize];
}


/**  是否设置过密码 */
+ (BOOL)getSecretSetupState {
    return [PathUserDefaults boolForKey:@"isSetupSecret"];
}

+ (void)saveSecretSetupState:(BOOL)isSetup {
    [PathUserDefaults setBool:isSetup forKey:@"isSetupSecret"];
    [PathUserDefaults synchronize];
}

/**  用户的账户编号Id */
+ (NSString *)getProfileId {
    return [PathUserDefaults objectForKey:@"profileId"];
}

+ (void)saveProfileId:(NSString *)profileId {
    [PathUserDefaults setObject:profileId forKey:@"profileId"];
    [PathUserDefaults synchronize];
}

/** 清空数据 */
+(void)emptyDataAction {
    NSDictionary *dictionary = [PathUserDefaults dictionaryRepresentation];
    for(NSString *key in [dictionary allKeys]){
        [PathUserDefaults removeObjectForKey:key];
        [PathUserDefaults synchronize];
    }
}

@end
