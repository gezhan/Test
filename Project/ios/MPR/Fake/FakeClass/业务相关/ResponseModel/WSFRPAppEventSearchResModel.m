//
//  WSFRPAppEventSearchResModel.m
//  WinShare
//
//  Created by GZH on 2018/3/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPAppEventSearchResModel.h"

@implementation WSFRPAppEventSearchResModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"Id"             : @"Id",
             @"picture"        : @"Picture",
             @"name"           : @"Name",
             @"address"        : @"Address",
             @"eventBeginTime" : @"EventBeginTime",
             @"eventEndTime"   : @"EventEndTime",
             @"eventTheTime"   : @"EventTheTime",
             @"enrolmentFee"   : @"EnrolmentFee",
             @"eventStatus"    : @"EventStatus",
             @"man"            : @"Man"
             };
}



@end
