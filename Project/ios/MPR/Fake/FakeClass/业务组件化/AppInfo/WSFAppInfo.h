//
//  WSFAppInfo.h
//  WinShare
//
//  Created by Gzh on 2017/11/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSFAppInfo : NSObject

/** 获取app平台的客服电话 */
+(NSString *)getTelephone;
+(void)saveTelephone:(NSString *)telephone;

/** 获取app被拒绝更新的版本 */
+(NSString *)getRefuseVersion;
+(void)saveRefuseVersion:(NSString *)refuseVersion;

@end
