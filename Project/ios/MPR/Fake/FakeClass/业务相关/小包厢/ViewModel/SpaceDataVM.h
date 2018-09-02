//
//  SpaceDataVM.h
//  WinShare
//
//  Created by QIjikj on 2017/5/10.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpaceDataVM : NSObject


/**
 根据筛选条件获取空间列表信息

 @param lng 经度
 @param lat 纬度
 @param selectTime 选定时间
 @param duration 持续时长
 @param minPeople 所选人数区间-最少
 @param maxPeople 所选人数区间-最多
 @param pageIndex 第几页
 @param pageSize 每页数量
 */
+ (void)getSpaceListDataWithLng:(double)lng lat:(double)lat selectTime:(NSString *)selectTime duration:(NSInteger)duration minPeople:(NSInteger)minPeople maxPeople:(NSInteger)maxPeople pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize success:(void(^)(NSArray *spaceListArray))success failed:(void(^)(NSError *error))failed;


/**
 根据空间id获取空间详情

 @param spaceId 空间id编码
 */
+ (void)getSpaceDetailDataWithSpaceId:(NSString *)spaceId success:(void(^)(NSDictionary *spaceDetailDictionary))success failed:(void(^)(NSError *error))failed;


/**
 根据获取空间详情

 @param spaceId 空间id编码
 @param lng lng 经度
 @param lat 纬度
 */
+ (void)getSpaceDetailDataV2WithSpaceId:(NSString *)spaceId lng:(double)lng lat:(double)lat success:(void(^)(NSDictionary *spaceDetailDictionary))success failed:(void(^)(NSError *error))failed;

@end
