//
//  SpaceDataVM.m
//  WinShare
//
//  Created by QIjikj on 2017/5/10.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "SpaceDataVM.h"

@implementation SpaceDataVM

+ (void)getSpaceListDataWithLng:(double)lng lat:(double)lat selectTime:(NSString *)selectTime duration:(NSInteger)duration minPeople:(NSInteger)minPeople maxPeople:(NSInteger)maxPeople pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(void(^)(NSArray *spaceListArray))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@&lng=%f&lat=%f&selectTime=%@&duration=%ld&minPeople=%ld&maxPeople=%ld&pageIndex=%ld&pageSize=%ld", GetSpaceListDataURL, [WSFUserInfo getToken], lng, lat, selectTime, duration, (long)minPeople, (long)maxPeople, (long)pageIndex, (long)pageSize];
  
    [WSFNetworkClient GET_Path:url completed:^(NSData *stringData, id JSONDict) {
        if ([JSONDict[@"Code"] isEqual:@0]) {
            if (success) {
                success(JSONDict[@"Data"][@"Records"]);
            }
        }else {
            if ([JSONDict[@"Message"] length] > 0) {
                [MBProgressHUD showMessage:JSONDict[@"Message"]];
            }
            if (success) {
                success(@[]);
            }
        }
        
    } failed:^(NSError *error) {
        
        if (failed) {
            failed(error);
        }
        
    }];
}

+ (void)getSpaceDetailDataWithSpaceId:(NSString *)spaceId success:(void(^)(NSDictionary *spaceDetailDictionary))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@&Id=%@", GetSpaceDetailDataURL, [WSFUserInfo getToken], spaceId];
    
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

+ (void)getSpaceDetailDataV2WithSpaceId:(NSString *)spaceId lng:(double)lng lat:(double)lat success:(void(^)(NSDictionary *spaceDetailDictionary))success failed:(void(^)(NSError *error))failed
{
    NSString *url = [NSString stringWithFormat:@"%@?Token=%@&Id=%@&lat=%f&lng=%f", GetSpaceDetailDataURLV2, [WSFUserInfo getToken], spaceId, lat, lng];
    
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
