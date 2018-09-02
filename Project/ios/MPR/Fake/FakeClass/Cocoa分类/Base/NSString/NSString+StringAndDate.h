//
//  NSString+StringAndDate.h
//  WinShare
//
//  Created by GZH on 2017/5/14.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringAndDate)

/**
 将旧的dateString按照新的格式输出

 @param newForm 新的格式(@"yyyy-MM-dd HH:mm:ss")
 @param oldStr 旧的dateString(@"2017-05-12 12:30:50")
 @param oldForm 旧的格式(@"yyyy/MM/dd HH:mm")
 @return 新的dateString(@"2017/05/12 12:30")
 使用注意：输入oldStr和oldForm时，确保格式的对应
 */
+ (NSString *)dateStrWithNewFormatter:(NSString *)newForm oldStr:(NSString *)oldStr oldFormatter:(NSString *)oldForm;

/** 将服务器返回的date型的字符串转换成NSDate类型 */
- (NSDate *)dateReplaceDateString;

@end
