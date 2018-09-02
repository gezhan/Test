//
//  WSFHomePageTVApi.m
//  WinShare
//
//  Created by GZH on 2018/1/22.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFHomePageTVApi.h"
@interface WSFHomePageTVApi ()

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) CLLocationCoordinate2D coor;

@end
@implementation WSFHomePageTVApi

- (instancetype)initWithTheContent:(NSInteger)pageIndex pageSize:(NSInteger)pageSize coor:(CLLocationCoordinate2D)coor {
    self = [super init];
    if (self) {
        
        _pageIndex = pageIndex;
        _pageSize = pageSize;
        _coor = coor;
        
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/api/iconfig/list_nearroom?"];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}


- (id)requestArgument {
    return @{
             @"pageIndex"  : @(_pageIndex),
             @"pageSize"   : @(_pageSize),
             @"lat"        : @( _coor.latitude),
             @"lng"        : @(_coor.longitude)
             };
}

- (NSTimeInterval)requestTimeoutInterval {
    return WSFConstants_NetworkRequestTimeOutDutation;
}

@end
