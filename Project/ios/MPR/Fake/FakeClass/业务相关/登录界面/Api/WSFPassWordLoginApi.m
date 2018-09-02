//
//  WSFPassWordLoginApi.m
//  WinShare
//
//  Created by GZH on 2018/1/22.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFPassWordLoginApi.h"

@interface WSFPassWordLoginApi ()
@property (nonatomic, strong) NSString *accountName;
@property (nonatomic, strong) NSString *password;
@end


@implementation WSFPassWordLoginApi
- (instancetype)initWithTheaccountName:(NSString *)accountName pwd:(NSString *)password {
    self = [super init];
    if (self) {
        
        _accountName = accountName;
        _password = password;
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/api/Login/Login_pwd"];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"accountName" : _accountName,
             @"password"    : _password
             };
}

- (NSTimeInterval)requestTimeoutInterval {
    return WSFConstants_NetworkRequestTimeOutDutation;
}

@end
