//
//  WSFRPPhotoApiModel.m
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPPhotoApiModel.h"

@implementation WSFRPPhotoApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"iid" : @"Id",
             @"uRL" : @"URL",
             @"path" : @"Path",
             @"fileName" : @"FileName",
             @"size" : @"Size"
             };
}

@end
