//
//  ShopCardDataVM.m
//  WinShare
//
//  Created by Gzh on 2017/9/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopCardDataVM.h"

@implementation ShopCardDataVM

+ (void)getShopCardListDataSuccess:(void(^)(NSArray *shopCardList))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@", GetShopCardListURL, [WSFUserInfo getToken]];
    
    [WSFNetworkClient GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        
        if ([JSONDict[@"Code"] isEqual:@0]) {
            if (success) {
                success(JSONDict[@"Data"]);
            }
        }else {
            if ([JSONDict[@"Message"] length] > 0) {
                NSLog(@"%@", JSONDict[@"Message"]);
            }
        }
        
    } failed:^(NSError *error) {
        
        if (failed) {
            failed(error);
        }
        
    }];
}

+ (void)getShopCardDetailAccountWithRoomId:(NSString *)roomId success:(void(^)(NSArray *shopCardDetailAccount))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@&roomId=%@", GetShopCardDetailAccountURL, [WSFUserInfo getToken], roomId];
    
    [WSFNetworkClient GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        
        if ([JSONDict[@"Code"] isEqual:@0]) {
            if (success) {
                success(JSONDict[@"Data"]);
            }
        }else {
            if ([JSONDict[@"Message"] length] > 0) {
                NSLog(@"%@", JSONDict[@"Message"]);
            }
        }
        
    } failed:^(NSError *error) {
        
        if (failed) {
            failed(error);
        }
        
    }];
}

+ (void)getShopCardDetailDataWithRoomId:(NSString *)roomId monthString:(NSString *)monthString pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(void(^)(NSInteger totalDuration, NSArray *shopCardDetailAccount))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@&roomId=%@&month=%@&pageIndex=%ld&pageSize=%ld", GetShopCardDetailDataURL, [WSFUserInfo getToken], roomId, monthString, pageIndex, pageSize];
    
    [WSFNetworkClient GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        
        if ([JSONDict[@"Code"] isEqual:@0]) {
            if (success) {
                success([JSONDict[@"Data"][@"TotalDuration"] integerValue], JSONDict[@"Data"][@"Records"]);
            }
        }else {
            if ([JSONDict[@"Message"] length] > 0) {
                NSLog(@"%@", JSONDict[@"Message"]);
            }
        }
        
    } failed:^(NSError *error) {
        
        if (failed) {
            failed(error);
        }
        
    }];
}

@end
