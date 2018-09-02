//
//  TicketVM.m
//  WinShare
//
//  Created by GZH on 2017/8/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "TicketVM.h"

@implementation TicketVM

+ (void)getTicketListDataWithOverdue:(BOOL)overdue orderId:(NSString *)orderId payWayType:(WSFPayWayType)payWayType pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize type:(NSInteger)type success:(void(^)(BOOL isHaveDisableTicket, NSArray *ticketList))success failed:(void(^)(NSError *error))failed
{
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

+ (void)getTicketDetailDataWithTicketId:(NSString *)ticketId success:(void(^)(NSArray *ticketDict))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@&couponId=%@", getTicketDetailURL, [WSFUserInfo getToken], ticketId];
    
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

+ (void)useTicketForOrderId:(NSString *)orderId ticketId:(NSString *)ticketId success:(void(^)(NSDictionary *respondData))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@&orderId=%@&couponId=%@", useTicketForOrderURL, [WSFUserInfo getToken], orderId, ticketId];
    
    [WSFNetworkClient POST_Path:url completed:^(NSData *stringData, id JSONDict) {
        
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
