//
//  WSFActivityDetailApi.m
//  WinShare
//
//  Created by GZH on 2018/3/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityDetailApi.h"

@interface WSFActivityDetailApi ()

@property (nonatomic, strong) NSString *eventId;

@end

@implementation WSFActivityDetailApi

- (instancetype)initWithTheEventId:(NSString *)eventId {
    self = [super init];
    if (self) {
        
        _eventId = eventId;
        
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/api/event_app/eve_info?"];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"eventId"  : _eventId
             };
}

- (NSTimeInterval)requestTimeoutInterval {
    return WSFConstants_NetworkRequestTimeOutDutation;
}


@end
