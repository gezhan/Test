//
//  WSFUserInfoManager.m
//  WinShare
//
//  Created by GZH on 2018/1/24.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFUserInfoManager.h"

@implementation WSFUserInfoManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _userInfoApiModel = [NSKeyedUnarchiver unarchiveObjectWithFile:[self userInfoFilePath]];
    }
    return self;
}

+ (WSFUserInfoManager *) shareUserInfoManager {
    static WSFUserInfoManager *shareUserInfoManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareUserInfoManager = [[self alloc]init];
    });
    return shareUserInfoManager;
}

/**  登录成功，保存数据 */
- (void)loginSuccess:(NSDictionary *)dict {
    _userInfoApiModel = [[WSFUserInfoApiModel alloc]initWithData:dict];
    /** 保存当前信息 */
    [NSKeyedArchiver archiveRootObject:_userInfoApiModel toFile:[self userInfoFilePath]];
}

/**  退出成功，清除数据 */
- (void)logoutSuccess {
    _userInfoApiModel = nil ;
    /** 删除当前的用户信息 */
    [[NSFileManager defaultManager] removeItemAtPath:[self userInfoFilePath] error:nil];
}

/** 保存用户信息的地址 */
- (NSString *)userInfoFilePath {
    return UserBaseInfoPath;
}

@end
