//
//  NSString+ReplaceStr.m
//  WinShare
//
//  Created by QIjikj on 2017/5/10.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "NSString+ReplaceStr.h"

@implementation NSString (ReplaceStr)

+ (NSString *)replaceString:(NSString *)strURL
                   Withstr1:(NSString *)str1
                       str2:(NSString *)str2
                       str3:(NSString *)str3 {
    NSString *URL = [strURL stringByReplacingOccurrencesOfString:@"{0}" withString:str1];
    NSString *URL1 = [URL stringByReplacingOccurrencesOfString:@"{1}" withString:str2];
    NSString *URL2 = [URL1 stringByReplacingOccurrencesOfString:@"{2}" withString:str3];
    
    URL2 = [NSString stringWithFormat:@"%@/%@", BaseImageUrl, URL2];
    
    return URL2;
}

+ (NSString *)replaceString:(NSString *)strURL
{
    return [NSString stringWithFormat:@"%@/%@", BaseImageUrl, strURL];
}

@end
