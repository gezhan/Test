//
//  WSFActivityDetailApi.h
//  WinShare
//
//  Created by GZH on 2018/3/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "YTKNetwork.h"

/**
 活动详情页的数据
 */
@interface WSFActivityDetailApi : YTKRequest

/**
 * eventId  活动Id
 */
- (instancetype)initWithTheEventId:(NSString *)eventId;

@end
