//
//  WSFFieldApi.h
//  WinShare
//
//  Created by GZH on 2018/1/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "YTKNetwork.h"

@interface WSFFieldApi : YTKRequest

/**
 * pageIndex  下标索引
 * pageSize   每页数量
 * coor       经纬度
 */
- (instancetype)initWithTheContent:(NSInteger)pageIndex pageSize:(NSInteger)pageSize coor:(CLLocationCoordinate2D)coor;

@end
