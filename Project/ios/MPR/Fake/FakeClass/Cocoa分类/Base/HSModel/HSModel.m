//
//  HSModel.m
//  WinShare
//
//  Created by Gzh on 2017/9/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "HSModel.h"

@implementation HSModel

#pragma mark - 打印Model
- (NSString *)description
{
    NSMutableString* text = [NSMutableString stringWithFormat:@"\n<%@>\n", [self class]];
    NSArray* properties = [self filterPropertys];
    [properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString* key = (NSString*)obj;
        id value = [self valueForKey:key];
        NSString* valueDescription = (value)?[value description]:@"(null)";
        if ( ![value respondsToSelector:@selector(count)] && [valueDescription length]>600 ) {
            valueDescription = [NSString stringWithFormat:@"%@...", [valueDescription substringToIndex:599]];
        }
        valueDescription = [valueDescription stringByReplacingOccurrencesOfString:@"\n" withString:@"\n "];
        [text appendFormat:@" [%@]: %@\n", key, valueDescription];
    }];
    [text appendFormat:@"</%@>", [self class]];
    return text;
}

#pragma mark - 获取一个类的属性列表
- (NSArray *)filterPropertys
{
    NSMutableArray* props = [NSMutableArray array];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for(int i = 0; i < count; i++){
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [props addObject:propertyName];
    }
    free(properties);
    return props;
}

@end
