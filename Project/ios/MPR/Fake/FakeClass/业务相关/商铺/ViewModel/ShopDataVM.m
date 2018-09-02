//
//  ShopDataVM.m
//  WinShare
//
//  Created by QIjikj on 2017/7/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopDataVM.h"

@implementation ShopDataVM

+ (void)getShopListDataWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(void(^)(NSArray *shopListDataArray))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@&pageIndex=%ld&pageSize=%ld", GetShopListURL, [WSFUserInfo getToken], pageIndex, pageSize];
    
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

+ (void)getShopListDetailDataWithRoomId:(NSString *)roomId pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(void(^)(NSDictionary *shopIncomeDictionary, NSArray *shopListDetailArray))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@&roomId=%@&pageIndex=%ld&pageSize=%ld", GetShopListDetailURL, [WSFUserInfo getToken], roomId, pageIndex, pageSize];
    
    [WSFNetworkClient GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        
        if ([JSONDict[@"Code"] isEqual:@0]) {
            if (success) {
                success(JSONDict[@"Data"], JSONDict[@"Data"][@"Records"]);
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

+ (void)getShopQRCodeMessageSuccess:(void(^)(NSString *QRCodeString))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@", GetShopQRCodeURL, [WSFUserInfo getToken]];
    
    [WSFNetworkClient GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        
        if ([JSONDict[@"Code"] isEqual:@0]) {
            if (success) {
                success(JSONDict[@"Data"]);
            }
        }else {
            if ([JSONDict[@"Message"] length] > 0) {
                if (failed) {
                    failed(JSONDict[@"Message"]);
                }
            }
        }
        
    } failed:^(NSError *error) {
        
        if (failed) {
            failed(error);
        }
        
    }];
}

/**
 获取指定大场地的经营情况与订单列表数据
 
 @param roomId 空间id
 @param pageIndex 开始页码
 @param pageSize 每页数据的条数
 @param success 指定商铺的经营情况,订单列表数据
 */
+ (void)getShopListDetailBigRoomDataWithRoomId:(NSString *)roomId pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(void(^)(NSDictionary *shopIncomeDictionary, NSArray *shopListDetailArray))success failed:(void(^)(NSError *error))failed {
    NSString *url = [NSString stringWithFormat:@"%@/api/room/brdetail_bigroom?Token=%@&roomId=%@&pageIndex=%ld&pageSize=%ld", BaseUrl, [WSFUserInfo getToken], roomId, pageIndex, pageSize];
    
    [WSFNetworkClient GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        
        if ([JSONDict[@"Code"] isEqual:@0]) {
            if (success) {
                success(JSONDict[@"Data"], JSONDict[@"Data"][@"Records"]);
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
