//
//  HSDeviceInfo.h
//  WinShare
//
//  Created by GZH on 2017/7/22.
//  Copyright © 2017年 QiJikj. All rights reserved.
//  获取手机和app信息

#import <Foundation/Foundation.h>

@interface HSDeviceInfo : NSObject

//app名称
@property (nonatomic, copy) NSString *appName;

//app版本
@property (nonatomic, copy) NSString *appVersion;

//app构建版本
@property (nonatomic, copy) NSString *appBuildVersion;

//手机序列号
@property (nonatomic, copy) NSString *identifierNumber;

//手机别名（用户定义的名称）
@property (nonatomic, copy) NSString *userPhoneName;

//设备名称
@property (nonatomic, copy) NSString *deviceName;

//手机系统版本
@property (nonatomic, copy) NSString *phoneVersion;

//手机型号
@property (nonatomic, copy) NSString *phoneModel;

//地方型号（国际化区域名称）
@property (nonatomic, copy) NSString *localPhoneModel;

//清除app缓存
- (void)handleClearMemoryData;

@end
