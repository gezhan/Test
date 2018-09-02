//
//  WSFRPAppEventApiResModel.m
//  WinShare
//
//  Created by GZH on 2018/3/8.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPAppEventApiResModel.h"

@implementation WSFRPAppEventApiResModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"Id"                 : @"Id",
             @"name"               : @"Name",
             @"man"                : @"Man",
             @"manTop"             : @"ManTop",
             @"manDown"            : @"ManDown",
             @"enrolmentFee"       : @"EnrolmentFee",
             @"tel"                : @"Tel",
             @"roomId"             : @"RoomId",
             @"roomName"           : @"RoomName",
             @"applyBeginDate"     : @"ApplyBeginDate",
             @"applyEndDate"       : @"ApplyEndDate",
             @"eventBeginTime"     : @"EventBeginTime",
             @"eventEndTime"       : @"EventEndTime",
             @"address"            : @"Address",
             @"lng"                : @"Long",
             @"lat"                : @"Lat",
             @"eventDate"          : @"EventDate",
             @"picture"            : @"Pictures",
             @"intros"             : @"Intros",
             @"eventStatus"        : @"EventStatus",
             @"shareUrl"           : @"ShareUrl"
             };
}

+ (NSValueTransformer *)pictureJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFRPPhotoApiModel.class];
}
+ (NSValueTransformer *)introsJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFRPEventIntroApiResModel.class];
}


@end
