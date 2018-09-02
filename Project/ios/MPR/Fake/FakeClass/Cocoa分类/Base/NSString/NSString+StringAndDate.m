//
//  NSString+StringAndDate.m
//  WinShare
//
//  Created by GZH on 2017/5/14.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "NSString+StringAndDate.h"

@implementation NSString (StringAndDate)

+ (NSString *)dateStrWithNewFormatter:(NSString *)newForm oldStr:(NSString *)oldStr oldFormatter:(NSString *)oldForm
{
    NSString *oldDateString = oldStr;
    NSDateFormatter *oldDateFormatter = [[NSDateFormatter alloc] init];
    [oldDateFormatter setDateFormat: oldForm];
    
    NSDate *unificationDate = [oldDateFormatter dateFromString: oldDateString];
    
    NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc] init];
    [newDateFormatter setDateFormat: newForm];
    return [newDateFormatter stringFromDate:unificationDate];
}

- (NSDate *)dateReplaceDateString
{
    NSString *oldDateString = self;
    NSDateFormatter *oldDateFormatter = [[NSDateFormatter alloc] init];
    [oldDateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *unificationDate = [oldDateFormatter dateFromString: oldDateString];

    return unificationDate;
}

@end
