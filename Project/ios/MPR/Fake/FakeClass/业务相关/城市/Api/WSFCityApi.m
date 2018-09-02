//
//  WSFCityApi.m
//  WinShare
//
//  Created by GZH on 2017/12/19.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFCityApi.h"

@implementation WSFCityApi

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/api/lbs/region_all_app"];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (NSTimeInterval)requestTimeoutInterval {
    return WSFConstants_NetworkRequestTimeOutDutation;
}

@end
