//
//  WSAboutVM.m
//  WinShare
//
//  Created by GZH on 2017/7/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSAboutVM.h"

@implementation WSAboutVM

//获取软件的最新版本信息
+ (void)getAppVersionMessageSuccess:(void(^)(NSDictionary *appVersion))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@?appSystem=%d", GetAppVersionURL, 20];
    
    [WSFNetworkClient GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        
        if ([JSONDict[@"Code"] isEqual:@0]) {
            if (success) {
                success(JSONDict[@"Data"]);
            }
        }else {
            if ([JSONDict[@"Message"] length] > 0) {
                [MBProgressHUD showMessage:JSONDict[@"Message"]];
            }
        }
        
    } failed:^(NSError *error) {
        
        if (failed) {
            failed(error);
        }
        
    }];
}

//获取软件平台的客服电话
+ (void)getAppPlatformPhoneNumberSuccess:(void(^)(NSString *appPlatformPhone))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@", GetAppPhoneURL];
    
    [WSFNetworkClient GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        
        if ([JSONDict[@"Code"] isEqual:@0]) {
            if (success) {
                success(JSONDict[@"Data"]);
            }
        }else {
            if ([JSONDict[@"Message"] length] > 0) {
                [MBProgressHUD showMessage:JSONDict[@"Message"]];
            }
        }
        
    } failed:^(NSError *error) {
        
        if (failed) {
            failed(error);
        }
        
    }];
}

@end
