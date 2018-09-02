//
//  WSAboutVM.h
//  WinShare
//
//  Created by GZH on 2017/7/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSAboutVM : NSObject

//获取软件的最新版本信息
+ (void)getAppVersionMessageSuccess:(void(^)(NSDictionary *appVersion))success failed:(void(^)(NSError *error))failed;

//获取软件平台的客服电话
+ (void)getAppPlatformPhoneNumberSuccess:(void(^)(NSString *appPlatformPhone))success failed:(void(^)(NSError *error))failed;

@end
