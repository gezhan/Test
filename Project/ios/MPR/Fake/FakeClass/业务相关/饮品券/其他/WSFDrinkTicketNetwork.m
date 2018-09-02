//
//  WSFDrinkTicketNetwork.m
//  WinShare
//
//  Created by devRen on 2017/10/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDrinkTicketNetwork.h"

@implementation WSFDrinkTicketNetwork

+ (void)getDrinkTicketListDataWithOverdue:(BOOL)overdue orderId:(NSString *)orderId payWayType:(WSFPayWayType)payWayType pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize type:(NSInteger)type success:(void(^)(BOOL isHaveDisableTicket, NSArray *ticketList))success failed:(void(^)(NSError *error))failed {
    NSString *overdue_string = overdue ? @"true" : @"false";
    
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@&overdue=%@&pageIndex=%ld&pageSize=%ld&orderId=%@&way=%ld&type=%ld", getTicketListURL, [WSFUserInfo getToken], overdue_string, pageIndex, pageSize, orderId, payWayType, type];
    
    [WSFNetworkClient GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        
        if ([JSONDict[@"Code"] isEqual:@0]) {
            if (success) {
                success([JSONDict[@"Data"][@"IsHaveFailure"] boolValue], JSONDict[@"Data"][@"Records"]);
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

#pragma mark - 获取饮品券回收列表
+ (void)getDrinkTicketBackListWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(void(^)(id data))success failed:(void(^)(NSError *error))failed {
    
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@&pageIndex=%ld&pageSize=%ld", getDrinkTicketBackListURL, [WSFUserInfo getToken], pageIndex, pageSize];
    
    [WSFNetworkClient GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        
        if ([JSONDict[@"Code"] isEqual:@0]) {
            if (success) {
                success(JSONDict[@"Data"]);
            }
        }else {
            if ([JSONDict[@"Message"] length] > 0) {
                [MBProgressHUD showMessage:JSONDict[@"Message"]];
            }
            if (failed) {
                failed(nil);
            }
        }
        
    } failed:^(NSError *error) {
        
        if (failed) {
            failed(error);
        }
        
    }];
}

#pragma mark - 扫描饮品券二维码获取饮品券信息
+ (void)getDrinkTicketDetailWithCouponCode:(NSString *)couponCode success:(void(^)(id data))success failed:(void(^)(NSError *error))failed {
    
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@&couponCode=%@", getDrinkTicketQRDetailURL, [WSFUserInfo getToken], couponCode];
    NSLog(@"getDrinkTicketQRDetailURL = %@",url);
    [WSFNetworkClient GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        
        if ([JSONDict[@"Code"] isEqual:@0]) {
            if (success) {
                success(JSONDict[@"Data"]);
            }
        }else {
            if ([JSONDict[@"Message"] length] > 0) {
                [MBProgressHUD showMessage:JSONDict[@"Message"]];
            }
            if (failed) {
                failed(nil);
            }
        }
        
    } failed:^(NSError *error) {
        
        if (failed) {
            failed(error);
        }
        
    }];
}

#pragma mark - 回收优惠券
+ (void)postDrinkTicketQRBackWithCouponCode:(NSString *)couponCode success:(void(^)(id data))success failed:(void(^)(NSError *error))failed {
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@&couponCode=%@", getDrinkTicketQRBackURL, [WSFUserInfo getToken], couponCode];
    
    [WSFNetworkClient POST_Path:url completed:^(NSData *stringData, id JSONDict) {
        
        if ([JSONDict[@"Code"] isEqual:@0]) {
            if (success) {
                success(JSONDict);
            }
        }else {
            if ([JSONDict[@"Message"] length] > 0) {
//                [MBProgressHUD showMessage:JSONDict[@"Message"]];
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
