//
//  NSArray+log.m
//  WinShare
//
//  Created by GZH on 2017/4/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "NSArray+log.h"

@implementation NSArray (log)

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个[
    [string appendString:@"[\n"];
    
    // 遍历所有的元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[NSString class]]) { //Nsstring
            [string appendFormat:@"\t\"%@\",\n", obj];
            
        }else if ([obj isKindOfClass:[NSNull class]]) { //null
            [string appendFormat:@"\tnull,\n"];
            
        }else if ([obj isKindOfClass:[NSNumber class]]){ //NSNumber
            [string appendFormat:@"\t%@,\n", obj];
            
        }else {
            [string appendFormat:@"\t%@,\n", obj];
        }
        
    }];
    
    // 结尾有个]
    [string appendString:@"]"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

@end
