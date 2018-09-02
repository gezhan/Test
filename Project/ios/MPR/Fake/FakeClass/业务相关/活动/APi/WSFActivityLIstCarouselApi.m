//
//  WSFActivityLIstCarouselApi.m
//  WinShare
//
//  Created by GZH on 2018/3/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityLIstCarouselApi.h"

@implementation WSFActivityLIstCarouselApi

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/api/iconfig/list_carousel_event"];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (NSTimeInterval)requestTimeoutInterval {
    return WSFConstants_NetworkRequestTimeOutDutation;
}


@end
