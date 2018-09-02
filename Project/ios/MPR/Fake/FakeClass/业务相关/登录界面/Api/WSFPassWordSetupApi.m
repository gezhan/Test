//
//  WSFPassWordSetupApi.m
//  WinShare
//
//  Created by GZH on 2018/1/22.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFPassWordSetupApi.h"

@interface WSFPassWordSetupApi ()
@property (nonatomic, strong) NSString *passwordNew;
@end


@implementation WSFPassWordSetupApi

- (instancetype)initWithTheNewPwd:(NSString *)newPwd {
    self = [super init];
    if (self) {
        _passwordNew = newPwd;
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/api/Login/set_pwd_new?Token=%@", [WSFUserInfo getToken]];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"newPwd" : _passwordNew,
             };
}

- (NSTimeInterval)requestTimeoutInterval {
    return WSFConstants_NetworkRequestTimeOutDutation;
}

@end
