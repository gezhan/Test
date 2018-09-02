//
//  NSMutableDictionary+SafeValue.m
//  duotin2.0
//
//  Created by Vienta on 5/6/14.
//  Copyright (c) 2014 Duotin Network Technology Co.,LTD. All rights reserved.
//

#import "NSMutableDictionary+SafeValue.h"

@implementation NSMutableDictionary (SafeValue)

- (void)setSafeObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!anObject) {
        [self setObject:[NSNull null] forKey:aKey];
    } else {
        [self setObject:anObject forKey:aKey];
    }
}

@end

@implementation NSDictionary(forNSNull)
//处理json含有null的情况
- (id)objectForKeySafely:(id)aKey{
    if(self == nil || self == (id)[NSNull null]){
        NSLog(@"NSDictionary warning:nsdictionary为nil");
        return nil;
    }
    id value = [self objectForKey:aKey];
    if (value == nil || value == (id)[NSNull null]) {
        if(value == (id)[NSNull null]) NSLog(@"NSDictionary warning:(key=%@,value=NSNull)", aKey);
        return nil;
    }else
        return value;
}
@end

@implementation NSNull(forNSDictionary)
- (id)objectForKeySafely:(id)aKey{
    NSLog(@"NSDictionary warning:nsdictionary为NSNull key=%@", aKey);
    return nil;
}
@end
