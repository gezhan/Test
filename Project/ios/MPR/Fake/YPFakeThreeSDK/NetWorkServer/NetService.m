//
//  NetService.m
//  duotin2.0
//
//  Created by Vienta on 4/16/14.
//  Copyright (c) 2014 Duotin Network Technology Co.,LTD. All rights reserved.
//

#import "NetService.h"
//#import "AFNetworking.h"
//#import "AFHTTPRequestOperationManager.h"

@implementation NetService

+ (instancetype)sharedNetService
{
  static NetService *_sharedClient = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSURL *baseURL = [NSURL URLWithString:@"http://mobile.ximalaya.com"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"TuneStore iOS 1.0"}];
    //设置我们的缓存大小 其中内存缓存大小设置10M  磁盘缓存5M
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024 diskCapacity:50 * 1024 * 1024 diskPath:nil];
    [config setURLCache:cache];
    _sharedClient = [[NetService alloc] initWithBaseURL:baseURL sessionConfiguration:nil];
    _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript", @"text/plain",nil];
    [_sharedClient.reachabilityManager startMonitoring];
    
    
  });
  
  return _sharedClient;
}

-(void)getMethod:(NSString *)path andDict:(id)parameters completion:(void(^)(NSDictionary *results, NSError *error))completion
{
  [self GET:path parameters:parameters success:^(NSURLSessionDataTask *task,id responseObject){
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSHTTPURLResponse *httpResponse =(NSHTTPURLResponse *)task.response;
    NSData *doubi = responseObject;
    NSString *shabi =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];
    TLog(@"输出傻逼%@",shabi);
    TLog(@"输出%ld",(long)httpResponse.statusCode);
    if (httpResponse.statusCode==200) {
      dispatch_async(dispatch_get_main_queue(),^{
        //TLog(@"输出返回的内容%@",responseObject);
        completion(responseObject,nil);
      });
    }else
    {
      dispatch_async(dispatch_get_main_queue(), ^{
        completion(nil,nil);});
    }
  } failure:^(NSURLSessionDataTask *task,NSError *error){
    dispatch_async(dispatch_get_main_queue(), ^{
      completion(nil,error);
    });
  }];
  //    [self reachablityStatus:^(int netStatus){
  //        TLog(@"成功");
  //    } fail:^(int errStatus) {
  //        [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请检查您的网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
  //    }];
}
-(void)postMethod:(NSString *)path andDict:(id)parameters completion:(void(^)(NSDictionary *results, NSError *error))completion
{
  [self POST:path parameters:parameters success:^(NSURLSessionDataTask *task,id responseObject){
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSHTTPURLResponse *httpResponse =(NSHTTPURLResponse *)task.response;
    TLog(@"输出%ld",(long)httpResponse.statusCode);
    
    if (httpResponse.statusCode==200) {
      dispatch_async(dispatch_get_main_queue(),^{
        TLog(@"输出返回的内容%@",responseObject);
        completion(responseObject,nil);
      });
    }else
    {
      dispatch_async(dispatch_get_main_queue(), ^{
        completion(nil,nil);});
    }
  } failure:^(NSURLSessionDataTask *task,NSError *error){
    dispatch_async(dispatch_get_main_queue(), ^{
      NSHTTPURLResponse *httpResponse =(NSHTTPURLResponse *)task.response;
      TLog(@"输出%@",httpResponse);
      completion(nil,error);
    });
  }];
  //    [self reachablityStatus:^(int netStatus){
  //
  //    } fail:^(int errStatus) {
  //        [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请检查您的网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
  //    }];
}
//上传图片
-(void)postImageToServer:(NSString *)path andDict:(id)parameters completion:(void(^)(NSDictionary *results, NSError *error))completion
{
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  //NSDictionary *parameters = @{@"foo": @"bar"};
  manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
  NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"image.png"], 1.0);
  [manager POST:@"http://www.ytimd.com/amd/clientPicture_upload.action" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    [formData appendPartWithFileData :imageData name:@"image" fileName:@"image.png" mimeType:@"image/jpeg"];
  } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    TLog(@"Error: %@", operation);
    TLog(@"Success: %@", responseObject);
    //        NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    //        NSData *newData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    //        NSDictionary *userDatadic = [NSJSONSerialization JSONObjectWithData:newData options:0 error:nil];
    //        TLog(@"输出返回的内容%@",userDatadic);
    //NSDictionary *userDic = userDatadic[@"data"];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    TLog(@"Error: %@", operation);
    TLog(@"Error: %@", error);
  }];
  
  
}
+(void)uploadImageData : (NSString *)url parameters:(NSDictionary *)dparameters imageData:(NSData *)dimageData success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure
{
  AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
  
  AFHTTPRequestOperation *op = [manager POST:url parameters:dparameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //do not put image inside parameters dictionary as I did, but append it!
    [formData appendPartWithFileData:dimageData name:@"image" fileName:@"image.png" mimeType:@"image/jpeg"];
  } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //success
    TLog(@"成功%@",operation);
    TLog(@"Success: %@", responseObject);
    success(responseObject);
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    // failure
    TLog(@"失败%@",error);
    failure(error);
  }];
  op.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript", @"text/plain",nil];//[NSSet setWithObject:@"text/html"];
  [op start];
  
  
  
}
- (void)reachablityStatus:(void (^)(int))success fail:(void (^) (int))fail
{
  [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    TLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    switch (status) {
      case AFNetworkReachabilityStatusReachableViaWWAN:
        TLog(@"3G");
        success(AFNetworkReachabilityStatusReachableViaWWAN);
      case AFNetworkReachabilityStatusReachableViaWiFi:
        TLog(@"无线");
        success(AFNetworkReachabilityStatusReachableViaWiFi);
        break;
      case AFNetworkReachabilityStatusNotReachable:
        TLog(@"没有网络");
        fail(AFNetworkReachabilityStatusNotReachable);
      default:
        TLog(@"无线");
        break;
    }
  }];
  
}


@end

