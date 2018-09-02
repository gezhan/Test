//
//  WSFNetworkClient.m
//  WinShare
//
//  Created by Gzh on 2017/11/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFNetworkClient.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "HNNetWorkManager.h"

#define kNetworkRequestTimeOutDutation WSFConstants_NetworkRequestTimeOutDutation

@implementation WSFNetworkClient

//单例
+ (instancetype)client
{
    static WSFNetworkClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[WSFNetworkClient alloc]init];
        [client setupJSONRequestManager];
    });
    return client;
}

//结束所有的网络请求
+ (void)cancleAllRequest
{
    [[WSFNetworkClient client].operationQueue cancelAllOperations];
}

//检查网络状态
- (void)networkStatusChangedAFN
{
    //1.获得一个网络状态监听管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //2.监听状态的改变（当网络状态改变时就会点用该block）
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app.mapManager start:WSFConstants_BaiduMapAppkey generalDelegate:nil];
      
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
    self.requestSerializer.timeoutInterval = kNetworkRequestTimeOutDutation;
    
    NSMutableSet *contentSet = [self.responseSerializer.acceptableContentTypes mutableCopy];
    [contentSet addObjectsFromArray:@[@"text/html", @"text/plain",@"application/json", @"text/json", @"text/javascript"]];
    self.responseSerializer.acceptableContentTypes = contentSet;
}

//get请求  无参数
+ (void)GET_Path:(NSString *)path completed:(HHSuccessBlock)successBlock failed:(HHFailedBlock)faileBlock
{
    if (kNetworkNotReachability) {
        [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
        faileBlock(nil);
        return;
    }
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  [HNNetWorkManager getRequestWithURLString:path parameters:nil success:^(id response) {
    NSData *jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    successBlock(jsonData, messageDic);
  } failure:^(NSError *error) {
    if ([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) {
      [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
    }
    faileBlock(error);
  }];
    
//    //1.获得请求管理者
//    WSFNetworkClient *manager = [WSFNetworkClient client];
//
//    //2.发送Get请求
//    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"调用GET接口:【%@】", [task currentRequest].URL.absoluteString);
//        successBlock([NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil],responseObject);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        if ([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) {
//            [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
//        }
//        faileBlock(error);
//    }];
  
}

//get请求  有参数
+ (void)GET_Path:(NSString *)path params:(NSDictionary *)params completed:(HHSuccessBlock)successBlock failed:(HHFailedBlock)failed
{
    if (kNetworkNotReachability) {
        [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
        failed(nil);
        return;
    }
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

  [HNNetWorkManager getRequestWithURLString:path parameters:nil success:^(id response) {
    NSData *jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    successBlock(jsonData, messageDic);
  } failure:^(NSError *error) {
    
    if ([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) {
      [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
    }
    failed(error);
  }];
  
  
  
//  //1.获得请求管理者
//  WSFNetworkClient *manager = [WSFNetworkClient client];
//
  
//    //2.发送Get请求
//    [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSLog(@"调用GET接口:【%@\nparams参数:%@】\n\n", [task currentRequest].URL.absoluteString, params);
//
//        successBlock([NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil],responseObject);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        if ([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) {
//            [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
//        }
//        failed(error);
//    }];
}

//POST 无参数
+(void)POST_Path:(NSString *)path completed:(HHSuccessBlock)successBlock failed:(HHFailedBlock)failed
{
    if (kNetworkNotReachability) {
        [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
        failed(nil);
        return;
    }
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  [HNNetWorkManager postRequestWithURLString:path parameters:nil success:^(id response) {
    NSData *jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    successBlock(jsonData, messageDic);
  } failure:^(NSError *error) {
    if ([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) {
      [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
    }
    failed(error);
  }];
    
//    //1.获得请求管理者
//    WSFNetworkClient *manager = [WSFNetworkClient client];
//
//    //2.发送Post请求
//    [manager POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSLog(@"调用POST接口:【%@】\n\n", [task currentRequest].URL.absoluteString);
//
//        successBlock([NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil],responseObject);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        if ([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) {
//            [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
//        }
//        failed(error);
//    }];
}

//POST 有参数
+(void)POST_Path:(NSString *)path params:(id)params completed:(HHSuccessBlock)successBlock failed:(HHFailedBlock)failed
{
    if (kNetworkNotReachability) {
        [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
        failed(nil);
        return;
    }
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  [HNNetWorkManager postRequestWithURLString:path parameters:params success:^(id response) {
    NSData *jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    successBlock(jsonData, messageDic);
  } failure:^(NSError *error) {
    if ([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) {
      [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
    }
    failed(error);
  }];
    
    //1.获得请求管理者
//    WSFNetworkClient *manager = [WSFNetworkClient client];
//
//    //2.发送Post请求
//    [manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSLog(@"调用POST接口:【%@\nparams参数:%@】\n\n", [task currentRequest].URL.absoluteString, params);
//
//        successBlock([NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil],responseObject);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        if ([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]) {
//            [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
//        }
//        failed(error);
//    }];
}

- (void)dealloc
{
    NSLog(@"line<%d> %s release siglton",__LINE__,__func__);
}

@end
