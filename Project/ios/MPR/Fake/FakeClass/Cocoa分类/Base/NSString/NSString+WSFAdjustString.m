//
//  NSString+WSFAdjustString.m
//  WinShare
//
//  Created by GZH on 2018/1/4.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "NSString+WSFAdjustString.h"

@implementation NSString (WSFAdjustString)

+ (NSString *)wsf_stringbyString:(NSString *)string
                          length:(NSUInteger)length
                           point:(BOOL)isPoint {
    if (string.length <= length) return string;
    string = [string substringToIndex:length];
    if (isPoint) {
        string = [string stringByAppendingString:@"..."];
    }
    return string;
}

@end
