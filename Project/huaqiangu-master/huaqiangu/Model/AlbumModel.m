//
//  AlbumModel.m
//  huaqiangu
//
//  Created by JiangWeiGuo on 2016/9/18.
//  Copyright © 2016年 Jiangwei. All rights reserved.
//

#import "AlbumModel.h"

@implementation AlbumModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
            if (![obj isKindOfClass:[NSNull class]]) {
                if ([key isEqualToString:@"cover_path"]||[key isEqualToString:@"albumCoverUrl290"]||[key isEqualToString:@"vod_pic"]) {
                    [self setValue:obj forKey:@"coverLarge"];
                }else if ([key isEqualToString:@"id"]||[key isEqualToString:@"vod_id"]) {
                    [self setValue:obj forKey:@"albumId"];
                }else if ([key isEqualToString:@"vod_name"]) {
                    [self setValue:obj forKey:@"title"];
                }else if ([key isEqualToString:@"vod_content"]) {
                    [self setValue:obj forKey:@"intro"];
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
