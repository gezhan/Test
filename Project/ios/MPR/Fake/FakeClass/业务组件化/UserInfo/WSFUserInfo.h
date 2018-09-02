//
//  WSFUserInfo.h
//  WinShare
//
//  Created by Gzh on 2017/11/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSFEnum.h"

@interface WSFUserInfo : NSObject

/** 获取用户设备唯一标识 */
+ (NSString *)getUUID;
+ (void)saveUUID:(NSString *)userUUID;

/** 存储token */
+ (NSString *)getToken;
+ (void)saveToken:(NSString *)token;

/** 存储手机号 */
+ (NSString *)getPhone;
+ (void)savePhone:(NSString *)token;

/**  是否设置过密码 */
+ (BOOL)getSecretSetupState;
+ (void)saveSecretSetupState:(BOOL)isSetup;

/**  用户的账户编号Id */
+ (NSString *)getProfileId;
+ (void)saveProfileId:(NSString *)profileId;

/** 用户身份标识 */
+ (WSFUserIdentifyType)getIdentify;
+ (void)saveIdentify:(NSInteger)identify;

/** 清空数据 */
+ (void)emptyDataAction;

@end
