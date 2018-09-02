//
//  NetworkClient.h
//  WinShare
//
//  Created by chenchanghua on 2017/11/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "AFNetworking.h"

#warning 这里没有将‘未知网络’列入无网状态，之后再改
#define kNetworkNotReachability ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 0)  //无网

typedef void (^HHSuccessBlock)(NSData *stringData,id JSONDict);
typedef void (^HHFailedBlock)(NSError *error);
typedef void (^NetWorkChange)();

@interface NetworkClient : AFHTTPSessionManager

/* 当网络有变化的时候调用 */
@property(nonatomic, copy)NetWorkChange netWorkChange;

/*请求客户端*/
+ (instancetype)client;

/*结束所有的网络请求*/
+ (void)cancleAllRequest;

/*检查网络状态*/
- (void)networkStatusChangedAFN;

/**
 GET请求
 无HTTPBody参数
 */
+ (void)GET_Path:(NSString *)path completed:(HHSuccessBlock)successBlock failed:(HHFailedBlock)failed;

/**
 GET请求
 有HTTPBody参数
 */
+ (void)GET_Path:(NSString *)path params:(NSDictionary *)params completed:(HHSuccessBlock)successBlock failed:(HHFailedBlock)failed;

/**
 POST请求
 无HTTPBody参数
 */
+ (void)POST_Path:(NSString *)path completed:(HHSuccessBlock)successBlock failed:(HHFailedBlock)failed;

/**
 POST请求
 有HTTPBody参数
 */
+ (void)POST_Path:(NSString *)path params:(id)params completed:(HHSuccessBlock)successBlock failed:(HHFailedBlock)failed;

@end
