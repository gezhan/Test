//
//  AFService.h
//  ComboAF
//
//  Created by li on 14/11/11.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface AFService : NSObject

//get请求
+(void)getMethod:(NSString *)path andDict:(id)parameters completion:(void(^)(NSDictionary *results, NSError *error))completion;
//post请求
+(void)postMethod:(NSString *)path andDict:(id)parameters completion:(void(^)(NSDictionary *results, NSError *error))completion;
//put请求
+(void)putMethod:(NSString *)path andDict:(id)parameters completion:(void(^)(NSDictionary *results, NSError *error))completion;


@end
