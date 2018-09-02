//
//  WSFRPCarouselSetApiModel.m
//  WinShare
//
//  Created by GZH on 2018/3/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPCarouselSetApiModel.h"

@implementation WSFRPCarouselSetApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"Id"          : @"Id",
             @"jumpRoomId"  : @"JumpRoomId",
             @"jumpUrl"     : @"JumpUrl",
             @"sort"        : @"Sort",
             @"picture"     : @"Picture",
             @"jumpType"    : @"JumpType",
             @"jumpRoomName": @"JumpRoomName"
             };
}

@end
