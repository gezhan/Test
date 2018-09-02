//
//  BqsDeviceFingerPrinting.h
//  DeviceFingerPrinting
//
//  Created by pengjianbo on 2017/1/18.
//  Copyright © 2017年 baiqishi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BqsDeviceFingerPrinting;

/**
 SDK初始化回调协议
 */
@protocol BqsDeviceFingerPrintingDelegate <NSObject>

/**
 初始化成功
 */
-(void) onBqsDFInitSuccess:(NSString *) tokenKey;

/**
 初始化失败
 
 @param resultCode 错误码
 @param resultDesc 错误描述
 */
-(void) onBqsDFInitFailure:(NSString *) resultCode withDesc:(NSString *) resultDesc;
@end


/**
 上传通讯录回调协议
 */
@protocol BqsDeviceFingerPrintingContactsDelegate <NSObject>

/**
 通讯录上传成功
 */
-(void) onBqsDFContactsUploadSuccess:(NSString *) tokenKey;

/**
 通讯录上传失败
 
 @param resultCode 错误码
 @param resultDesc 错误描述
 */
-(void) onBqsDFContactsUploadFailure:(NSString *) resultCode withDesc:(NSString *) resultDesc;
@end

@interface BqsDeviceFingerPrinting : NSObject
/**
 单例类方法
 @return instancetype
 */
+(instancetype)sharedBqsDeviceFingerPrinting;


/**
 设置上传通讯录回调

 @param delegate 回调
 */
-(void) setBqsDeviceFingerPrintingContactsDelegate:(id<BqsDeviceFingerPrintingContactsDelegate>) delegate;


/**
 设置上传设备信息回调

 @param delegate 回调
 */
-(void) setBqsDeviceFingerPrintingDelegate:(id<BqsDeviceFingerPrintingDelegate>) delegate;


/**
 获取tokenkey

 @return tokenkey
 */
-(NSString *)getTokenKey;


/**
 提交定位信息
 */
-(void) commitLocaiton;

/**
 提交定位信息(使用一些第三方定位，定位成功后将经纬度信息提交给白骑士服务器)
 */
-(void) commitLocaitonWithLongitude:(double) longitude withLatitude:(double) latitude;

/**
 提交通讯录
 */
-(void) commitContacts;


/**
 是否需要执行初始化(为了避免频繁调用初始化而添加的方法)

 @return YES:需要 NO:不需要
 */
-(BOOL) canInitBqsSDK;

/**
 初始化入口方法
 
 @param params 初始化参数
 传入参数: NSDictionary
 1)partnerId: 合作方编码，必填
 2)isGatherGps: 是否采集gps，默认YES:采集 NO:不采集
 3)isGatherContacts:是否采集通讯录，默认NO：不采集， YES:采集
 4)isTestingEnv:是否对接白骑士测试环境，默认NO：生产环境, YES:测试环境
 5)isGatherSensorInfo:是否采集传感器信息,默认YES:采集 NO:不采集
 */
-(void)initBqsDFSdkWithParams:(NSDictionary *) params;

@end
