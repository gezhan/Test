//
//  NSString+GetDate.h
//  XiaoYing
//
//  Created by GZH on 2017/3/15.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GetDate)

//获取第x天的日期（x代表第几天，0标识今天）   year为YES代表年月日，NO代表月日
+ (NSString *)getNextDateAction:(NSInteger)x andYear:(BOOL)year;

//获取两个字符串类型数据的时间差
+ (NSString *)getIntervalTimeFormTime:(NSString *)beginTime ToTime:(NSString *)endTime;

//根据当前时间获取当前是周几
+ (NSString*)getWeekdayStringFromDateStr:(NSString *)dateStr;

////获取每隔半个小时的时间点
//+ (NSString *)getPointTimeFromZeroTimeAction;


//获取距离现在X天之后这个时刻的时间
+ (NSString *)getNextTimeAction:(NSInteger)x
                        andYear:(BOOL)year;

@end



//将字符串转换成时间格式
@interface NSDate (GetDate)

//转换成年月日格式
+(NSDate *)getDateFromString:(NSString *)dateString;

////转换成月日格式
//+(NSDate *)getMonthDateFromString:(NSString *)dateString;

@end
