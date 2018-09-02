//
//  HSSystem.h
//  WinShare
//
//  Created by GZH on 2017/5/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IOS_VERSION ([[UIDevice currentDevice] systemVersion].floatValue)

@interface HSSystem : NSObject

+ (NSString *)iOSSystemVersion;
+ (NSString *)appVersion;
+ (NSString *)appBundleName;
+ (NSString *)buildVersion;
+ (NSString *)bundleSeedID;

+ (BOOL)isJailbrokenUser;
+ (BOOL)isPiratedUser;

+ (BOOL)iOS8;
+ (BOOL)iOSVersion:(CGFloat)version;

@end
