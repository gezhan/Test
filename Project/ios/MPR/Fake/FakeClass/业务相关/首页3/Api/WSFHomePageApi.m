//
//  WSFHomePageApi.m
//  WinShare
//
//  Created by GZH on 2018/1/11.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFHomePageApi.h"

@implementation WSFHomePageApi

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/api/iconfig/list_index_up"];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (NSTimeInterval)requestTimeoutInterval {
    return WSFConstants_NetworkRequestTimeOutDutation;
}

@end
