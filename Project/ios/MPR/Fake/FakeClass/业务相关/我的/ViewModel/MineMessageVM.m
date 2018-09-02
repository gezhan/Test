//
//  MineMessageVM.m
//  WinShare
//
//  Created by GZH on 2017/5/13.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "MineMessageVM.h"
#import "WSFNetworkClient.h"

@implementation MineMessageVM

+ (void)getMineCurrentBalanceWithSuccess:(void(^)(NSString *balanceMoney))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@", getMineBalanceMoneyURL, [WSFUserInfo getToken]];
    
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

+ (void)getMineMoneyUsedRecordWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(void(^)(NSArray *moneyUsedRecord))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@&pageIndex=%d&pageSize=%d", getMineMoneyUsedRecordURL, [WSFUserInfo getToken], pageIndex, pageSize];
    
    [WSFNetworkClient GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        
        if ([JSONDict[@"Code"] isEqual:@0]) {
            if (success) {
                success(JSONDict[@"Data"][@"Records"]);
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

+ (void)getMineIdentifyDataSuccess:(void(^)(NSInteger identifyNumber))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@", getMineIdentifyURL, [WSFUserInfo getToken]];
    
    [WSFNetworkClient GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        
        if ([JSONDict[@"Code"] isEqual:@0]) {
            if (success) {
                success([JSONDict[@"Data"] integerValue]);
            }
        }else {
            if ([JSONDict[@"Message"] length] > 0) {
                [MBProgressHUD showMessage:JSONDict[@"Message"]];
                if (failed) {
                    failed(nil);
                }
            }
        }
        
    } failed:^(NSError *error) {
        
        if (failed) {
            failed(error);
        }
        
    }];
}

@end
