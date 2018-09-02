//
//  WSFFieldSelectedApi.m
//  WinShare
//
//  Created by GZH on 2018/1/18.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldSelectedApi.h"
@interface WSFFieldSelectedApi ()

@property (nonatomic, strong) NSString *roomId;

@end

@implementation WSFFieldSelectedApi

- (instancetype)initWithTheRoomId:(NSString *)roomId  {
    self = [super init];
    if (self) {
        
        _roomId = roomId;
        
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/api/sitemeal/get_list?"];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"roomId"     :_roomId,
             };
}

- (NSTimeInterval)requestTimeoutInterval {
    return WSFConstants_NetworkRequestTimeOutDutation;
}

@end
