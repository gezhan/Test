//
//  WSFFeedbackApi.m
//  WinShare
//
//  Created by devRen on 2017/12/6.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFFeedbackApi.h"

@interface WSFFeedbackApi ()

@property (nonatomic, copy) NSString *theContent;
@property (nonatomic, copy) NSString *picIds;

@end

@implementation WSFFeedbackApi

- (instancetype)initWithTheContent:(NSString *)theContent picIds:(NSString *)picIds {
    self = [super init];
    if (self) {
        _theContent = theContent;
        _picIds = picIds;
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/api/feedback/add?Token=%@",[WSFUserInfo getToken]];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"system" : @"iOS",
             @"version" : [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],
             @"theContent" : _theContent,
             @"picIds" : _picIds,
             };
}

- (NSTimeInterval)requestTimeoutInterval {
    return WSFConstants_NetworkRequestTimeOutDutation;
}

@end
