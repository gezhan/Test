//
//  NetService.h
//  duotin2.0
//
//  Created by Vienta on 4/16/14.
//  Copyright (c) 2014 Duotin Network Technology Co.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface NetService : AFHTTPSessionManager

+ (instancetype)sharedNetService;

/**
 *  Get方法
 *
 *  @param path       url请求路径
 *  @param parameters 请求参数
 *  @param success    成功block
 *  @param failure    失败block
*/
//- (NSURLSessionDataTask *)getPath:(NSString *)path
//     parameters:(NSDictionary *)parameters
//        success:(void (^)(id sucRes))success
//        failure:(void (^)(id failRes))failure;
/**
 *  Post方法
 *
 *  @param path       url请求路径
 *  @param parameters 请求参数
 *  @param success    成功
 *  @param failure    失败
 */
//get请求
-(void)getMethod:(NSString *)path andDict:(id)parameters completion:(void(^)(NSDictionary *results, NSError *error))completion;
//post请求
-(void)postMethod:(NSString *)path andDict:(id)parameters completion:(void(^)(NSDictionary *results, NSError *error))completion;
//
-(void)postImageToServer:(NSString *)path andDict:(id)parameters completion:(void(^)(NSDictionary *results, NSError *error))completion;
+(void)uploadImageData : (NSString *)url parameters:(NSDictionary *)dparameters imageData:(NSData *)dimageData success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure;
@end
