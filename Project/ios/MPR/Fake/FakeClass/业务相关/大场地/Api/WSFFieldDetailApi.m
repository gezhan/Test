//
//  WSFFieldDetailApi.m
//  WinShare
//
//  Created by GZH on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldDetailApi.h"
@interface WSFFieldDetailApi ()

@property (nonatomic, strong) NSString *roomId;
@property (nonatomic, assign) CLLocationCoordinate2D coor;

@end

@implementation WSFFieldDetailApi

- (instancetype)initWithTheRoomId:(NSString *)roomId coor:(CLLocationCoordinate2D)coor {
    self = [super init];
    if (self) {

        _roomId = roomId;
        _coor = coor;
        
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/api/roombig/detail?"];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return @{
             @"roomId"     :_roomId,
             @"lat"        : @( _coor.latitude),
             @"lng"        : @(_coor.longitude)
             };
}

- (NSTimeInterval)requestTimeoutInterval {
    return WSFConstants_NetworkRequestTimeOutDutation;
}

@end
