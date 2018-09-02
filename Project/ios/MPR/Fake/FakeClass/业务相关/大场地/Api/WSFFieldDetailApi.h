//
//  WSFFieldDetailApi.h
//  WinShare
//
//  Created by GZH on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "YTKNetwork.h"

@interface WSFFieldDetailApi : YTKRequest

/**
 * roomId  空间id
 * coor    经纬度
 */
- (instancetype)initWithTheRoomId:(NSString *)roomId coor:(CLLocationCoordinate2D)coor;
@end
