//
//  WSFTimeManager.h
//  WinShare
//
//  Created by GZH on 2017/12/15.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSFTimeManager : NSObject

/**
 * 获取全天的时间点
 *
 */
+ (NSMutableArray *)getPointTimesAllDay;

/**
 * 如果月份和日期的十位上有“0”，就都去掉
 * dateStr : XX/XX结构的数据
 */
+ (NSString *)getNavDateTodayWithdateStr:(NSString *)dateStr;

/**
 * 返回年月日中的“日”，如果十位上是“0”，也去掉
 * dateStr
 */
+ (NSString *)getDateTodayWithdateStr:(NSString *)dateStr;

@end
