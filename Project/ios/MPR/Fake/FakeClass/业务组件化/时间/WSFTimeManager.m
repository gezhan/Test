//
//  WSFTimeManager.m
//  WinShare
//
//  Created by GZH on 2017/12/15.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFTimeManager.h"

@implementation WSFTimeManager

//获取全天的时间点
+ (NSMutableArray *)getPointTimesAllDay {
    /**  存储所有时间点的数组 */
    NSMutableArray *pointTimeArray = [NSMutableArray array];
    [pointTimeArray addObject:@"00:00"];
    
    int hour = 0;
    NSString *hourStr;
    NSString *minuteStr;
    for (int i = 0; i < 47; i++) {
        // 计算时间
        hour += (i % 2) * 1;
        if (i == 0) hourStr = @"00";
        else {
            if (i < 19) {
                hourStr = [NSString stringWithFormat:@"0%d",hour];
            } else {
                hourStr = [NSString stringWithFormat:@"%d",hour];
            }
        }
        if ((i + 1) % 2) minuteStr = @"30";
        else minuteStr = @"00";
        NSString *targetStr = [NSString stringWithFormat:@"%@:%@",hourStr,minuteStr];
        [pointTimeArray addObject:targetStr];
    }
    return pointTimeArray;
}

//如果月份和日期的十位上有“0”，就都去掉
+ (NSString *)getNavDateTodayWithdateStr:(NSString *)dateStr {
    
    NSRange range = [dateStr rangeOfString:@"/"];
    NSString *beforeStr = [dateStr substringToIndex:range.location];
    NSString *behindStr = [dateStr substringFromIndex:range.location];
    
    beforeStr = [self getDateTodayWithdateStr:beforeStr];
    behindStr = [self getDateTodayWithdateStr:behindStr];
    
    return [NSString stringWithFormat:@"%@/%@", beforeStr, behindStr];
}

//去掉月份只要日期，并且去掉日期十位上的“0”
+ (NSString *)getDateTodayWithdateStr:(NSString *)dateStr {
    NSString *tempStr = [dateStr substringWithRange:NSMakeRange(dateStr.length - 2, 1)];
    if ([tempStr isEqualToString:@"0"]) {
        tempStr = [dateStr substringFromIndex:dateStr.length - 1];
    }else {
        tempStr = [dateStr substringFromIndex:dateStr.length - 2];
    }
    return tempStr;
}


@end
