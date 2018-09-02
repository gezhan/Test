//
//  AFService.m
//  ComboAF
//
//  Created by li on 14/11/11.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import "AFService.h"

@implementation AFService

//get请求
+(void)getMethod:(NSString *)path andDict:(id)parameters completion:(void(^)(NSDictionary *results, NSError *error))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是json类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript", @"text/plain",nil];//如果报接受类型不一致请替换一致text/html或别的
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dispatch_async(dispatch_get_main_queue(),^{
            TLog(@"输出返回的内容%@",responseObject);
            completion(responseObject,nil);
        });

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil,error);
        });
    }];
}
//post请求
+(void)postMethod:(NSString *)path andDict:(id)parameters completion:(void(^)(NSDictionary *results, NSError *error))completion
{
    //你的接口地址
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是json类型

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript", @"text/plain",nil];//如果报接受类型不一致请替换一致text/html或别的
    //manager.requestSerializer=[AFJSONRequestSerializer serializer];//申明请求的数据是json类型
    [manager POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        TLog(@"%@", responseObject);
        dispatch_async(dispatch_get_main_queue(),^{
//            TLog(@"输出返回的内容%@",responseObject);
            completion(responseObject,nil);
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        TLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil,error);
        });
    }
     ];
    
}
+(void)putMethod:(NSString *)path andDict:(id)parameters completion:(void(^)(NSDictionary *results, NSError *error))completion
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是json类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript", @"text/plain",nil];//如果报接受类型不一致请替换一致text/html或别的
    manager.requestSerializer=[AFJSONRequestSerializer serializer];//申明请求的数据是json类型
    [manager PUT:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        TLog(@"%@", responseObject);
        dispatch_async(dispatch_get_main_queue(),^{
            TLog(@"输出返回的内容%@",responseObject);
            completion(responseObject,nil);
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        TLog(@"Error: %@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(nil,error);
        });
    }];
}

@end
