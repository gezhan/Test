//
//  NSString+GetDate.m
//  XiaoYing
//
//  Created by GZH on 2017/3/15.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "NSString+GetDate.h"

@implementation NSString (GetDate)


//获取距离当前x天的日期
+ (NSString *)getNextDateAction:(NSInteger)x
                        andYear:(BOOL)year {
    
    NSDate *date = [NSDate date];
    NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 * x sinceDate:date];//后一天
    NSDateFormatter *pickerFormatter=[[NSDateFormatter alloc]init];
    //创建日期显示格式
    if (year) {
        
        [pickerFormatter setDateFormat:@"yyyy/MM/dd"];
    }else {
        
        [pickerFormatter setDateFormat:@"MM/dd"];
    }
    
    //将日期转换为字符串的形式
    NSString *dateString=[pickerFormatter stringFromDate:nextDay];
    return dateString;
}

//获取距离现在X天之后这个时刻的时间
+ (NSString *)getNextTimeAction:(NSInteger)x
                        andYear:(BOOL)year {
    
    NSDate *date = [NSDate date];
    NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 * x sinceDate:date];//后一天
    NSDateFormatter *pickerFormatter=[[NSDateFormatter alloc]init];
    [pickerFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString=[pickerFormatter stringFromDate:nextDay];
    //创建日期显示格式
    if (year) {
        
        //将日期转换为字符串的形式
        dateString = [dateString substringWithRange:NSMakeRange(11, 5)];
        return dateString;
    }
    
    return dateString;
}

//获取两个字符串类型数据的时间差
+ (NSString *)getIntervalTimeFormTime:(NSString *)beginTime ToTime:(NSString *)endTime{
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *begindate =[dateFormat dateFromString:beginTime];
    NSDate *enddate =[dateFormat dateFromString:endTime];
    
    NSTimeInterval start = [begindate timeIntervalSince1970]*1;
    NSTimeInterval end = [enddate timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int day = (int)value / (24 * 3600);
    
    NSString *str = nil;
    str = [NSString stringWithFormat:@"%d", day];
    
    return str;
}


//根据当前时间获取当前是周几
+ (NSString*)getWeekdayStringFromDateStr:(NSString *)dateStr {
    
    NSDate *inputDate = [NSDate getDateFromString:dateStr];
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}



////获取每隔半个小时的时间点
//+ (NSString *)getPointTimeFromZeroTimeAction {
//    
//    
//    
//    int hour = 9;
//    NSString *hourStr;
//    NSString *minuteStr;
//    for (int i = 0; i < 48; i ++) {
//        // 计算时间
//        hour += (i % 2) * 1;
//        if (i == 0) hourStr = @"00";
//        else hourStr = [NSString stringWithFormat:@"%d",hour];
//        
//        if ((i + 1) % 2) minuteStr = @"30";
//        else minuteStr = @"00";
//        
//        
//        NSString *targetStr = [NSString stringWithFormat:@"%@:%@",hourStr,minuteStr];
//        
//    }
//    
//    return targetStr;
//}





@end



//字符串转换成日期
@implementation NSDate (GetDate)

//转换成年月日格式
+(NSDate *)getDateFromString:(NSString *)dateString {
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date =[dateFormat dateFromString:dateString];
    
    return date;
}

////转换成月日格式
//+(NSDate *)getMonthDateFromString:(NSString *)dateString {
//    
//    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
//    
//    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    
//    NSDate *date =[dateFormat dateFromString:dateString];
//    
//    return date;
//}


@end
