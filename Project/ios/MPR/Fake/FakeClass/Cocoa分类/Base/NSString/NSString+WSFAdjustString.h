//
//  NSString+WSFAdjustString.h
//  WinShare
//
//  Created by GZH on 2018/1/4.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WSFAdjustString)

/**
 ** 获取调整之后的字符串 （超过规定的长度，截取；不超过的话，直接返回）
 * string 需要调整的字符串
 * length 需要的长度
 * isPoint 超过规定长度之后，截取完，是否拼接省略号
 */
+ (NSString *)wsf_stringbyString:(NSString *)string
                          length:(NSUInteger)length
                           point:(BOOL)isPoint;

@end
