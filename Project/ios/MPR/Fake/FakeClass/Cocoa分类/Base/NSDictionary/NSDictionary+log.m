//
//  NSDictionary+log.m
//  WinShare
//
//  Created by GZH on 2017/4/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "NSDictionary+log.h"

@implementation NSDictionary (log)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        [string appendFormat:@"\t%@", key];
        [string appendString:@" : "];
        
        if ([obj isKindOfClass:[NSString class]]) { //Nsstring
            [string appendFormat:@"\"%@\",\n", obj];
            
        }else if ([obj isKindOfClass:[NSNull class]]) { //null
            [string appendFormat:@"null,\n"];
            
        }else { //NSNumber
            [string appendFormat:@"%@,\n", obj];
        }
        
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

@end
