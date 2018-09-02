//
//  WSFUserInfoManager.h
//  WinShare
//
//  Created by GZH on 2018/1/24.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSFUserInfoApiModel.h"
@interface WSFUserInfoManager : NSObject

/** 用户信息的单例 */
+ (WSFUserInfoManager *) shareUserInfoManager;

/** 用户信息 */
@property(nonatomic, strong)WSFUserInfoApiModel *userInfoApiModel ;

/**  登录成功，保存数据 */
- (void)loginSuccess:(NSDictionary *)dict;

/**  退出成功，清除数据 */
- (void)logoutSuccess;


@end
