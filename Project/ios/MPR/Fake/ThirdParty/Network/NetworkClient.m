//
//  NetworkClient.m
//  WinShare
//
//  Created by chenchanghua on 2017/11/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "NetworkClient.h"
#import "AFNetworking.h"

static const float timeOut = 10.0;

@implementation NetworkClient

//单例
+ (instancetype)client
{
    static NetworkClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[NetworkClient alloc] init];
        [client setupJSONRequestManager];
    });
    return client;
}

//结束所有的网络请求
+ (void)cancleAllRequest
{
    [[NetworkClient client].operationQueue cancelAllOperations];
}

//检查网络状态
- (void)networkStatusChangedAFN
{
  //1.获得一个网络状态监听管理者
  AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
  
  //2.监听状态的改变（当网络状态改变时就会点用该block）
  [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    
    //网络变化时候的回调
    if (_netWorkChange)_netWorkChange();
    
    switch (status) {
      case AFNetworkReachabilityStatusReachableViaWiFi:
        NSLog(@"您现在使用的网络类型是WIFI");
        break;
        
      case AFNetworkReachabilityStatusReachableViaWWAN:
        NSLog(@"您现在使用的是2G/3G网络\n可能会产生流量费用");
        break;
        
      case AFNetworkReachabilityStatusNotReachable:
        NSLog(@"您现在没有网络连接，请检查你的网络设置");
        break;
        
      case AFNetworkReachabilityStatusUnknown:
        NSLog(@"您的网络未知");
        break;
    }
    
  }];
  
  //3.手动开启，开始监听
  [manager startMonitoring];
}

- (void)setupJSONRequestManager
{
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.requestSerializer.timeoutInterval = timeOut;
    
    NSMutableSet *contentSet = [self.responseSerializer.acceptableContentTypes mutableCopy];
    [contentSet addObjectsFromArray:@[@"text/html", @"text/plain",@"application/json", @"text/json", @"text/javascript"]];
    self.responseSerializer.acceptableContentTypes = contentSet;
}

//get请求  无参数
+ (void)GET_Path:(NSString *)path completed:(HHSuccessBlock)successBlock failed:(HHFailedBlock)faileBlock
{
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //1.获得请求管理者
    NetworkClient *manager = [NetworkClient client];
    
    //2.发送Get请求
    [manager GET:path parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"调用GET接口:【%@】\n\n", [task currentRequest].URL.absoluteString);
        
        successBlock([NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil],responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
        faileBlock(error);
    }];
    
}

//get请求  有参数
+ (void)GET_Path:(NSString *)path params:(NSDictionary *)params completed:(HHSuccessBlock)successBlock failed:(HHFailedBlock)failed
{
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //1.获得请求管理者
    NetworkClient *manager = [NetworkClient client];
    
    //2.发送Get请求
    [manager GET:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"调用GET接口:【%@\nparams参数:%@】\n\n", [task currentRequest].URL.absoluteString, params);
        
        successBlock([NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil],responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
        failed(error);
    }];
}

//POST 无参数
+(void)POST_Path:(NSString *)path completed:(HHSuccessBlock)successBlock failed:(HHFailedBlock)failed
{
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //1.获得请求管理者
    NetworkClient *manager = [NetworkClient client];
    
    //2.发送Post请求
    [manager POST:path parameters:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"调用POST接口:【%@】\n\n", [task currentRequest].URL.absoluteString);
        
        successBlock([NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil],responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
}

//POST 有参数
+(void)POST_Path:(NSString *)path params:(id)params completed:(HHSuccessBlock)successBlock failed:(HHFailedBlock)failed
{
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //1.获得请求管理者
    NetworkClient *manager = [NetworkClient client];
    
    //2.发送Post请求
    [manager POST:path parameters:params  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"调用POST接口:【%@\nparams参数:%@】\n\n", [task currentRequest].URL.absoluteString, params);
        
        successBlock([NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil],responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
        failed(error);
    }];
}

- (void)dealloc
{
    NSLog(@"line<%d> %s release siglton",__LINE__,__func__);
}

@end
