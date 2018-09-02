//
//  TrackModel.m
//  huaqiangu
//
//  Created by Jiangwei on 15/7/18.
//  Copyright (c) 2015年 Jiangwei. All rights reserved.
//

#import "TrackModel.h"

@implementation TrackModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
            if (![obj isKindOfClass:[NSNull class]]) {
                if ([key isEqualToString:@"url"]) {
                    [self setValue:obj forKey:@"playUrl64"];
                }else{
                    SEL se = NSSelectorFromString(key);
                    if ([self respondsToSelector:se]) {
                        [self setValue:obj forKey:key];
                    }
                }
            }
        }];
    }
    return self;
}

@end
