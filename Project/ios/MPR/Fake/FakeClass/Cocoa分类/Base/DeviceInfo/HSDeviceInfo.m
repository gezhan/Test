//
//  HSDeviceInfo.m
//  WinShare
//
//  Created by GZH on 2017/7/22.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "HSDeviceInfo.h"

@implementation HSDeviceInfo

//app名称
- (NSString *)appName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

//app版本
- (NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

//app构建版本
- (NSString *)appBuildVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

//手机序列号
- (NSString *)identifierNumber
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

//手机别名（用户定义的名称）
- (NSString *)userPhoneName
{
    return [[UIDevice currentDevice] name];
}

//设备名称
- (NSString *)deviceName
{
    return [[UIDevice currentDevice] systemName];
}

//手机系统版本
- (NSString *)phoneVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

//手机型号
- (NSString *)phoneModel
{
    return [[UIDevice currentDevice] model];
}

//地方型号（国际化区域名称）
- (NSString *)localPhoneModel
{
    return [[UIDevice currentDevice] localizedModel];
}


//清除app缓存
- (void)handleClearMemoryData
{
    //删除两部分
    
    //1.删除 sd 图片缓存
    //先清除内存中的图片缓存
    [[SDImageCache sharedImageCache] clearMemory];
    //清除磁盘的缓存
    [[SDImageCache sharedImageCache] clearDisk];
    
    //2.删除自己缓存
    NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    [[NSFileManager defaultManager] removeItemAtPath:myCachePath error:nil];
}

@end









