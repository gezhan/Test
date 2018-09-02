//
//  NSString+ReplaceStr.h
//  WinShare
//
//  Created by QIjikj on 2017/5/10.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ReplaceStr)

//缩略图
+ (NSString *)replaceString:(NSString *)strURL
                   Withstr1:(NSString *)str1
                       str2:(NSString *)str2
                       str3:(NSString *)str3;

//原图
+ (NSString *)replaceString:(NSString *)strURL;

@end
