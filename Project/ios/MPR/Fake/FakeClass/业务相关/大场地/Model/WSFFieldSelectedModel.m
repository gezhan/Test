//
//  WSFFieldSelectedModel.m
//  WinShare
//
//  Created by GZH on 2018/1/18.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldSelectedModel.h"

@implementation WSFFieldSelectedModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"records" : @"Records",
             @"isTip" : @"IsTip",
             @"tip"   :  @"Tip"
             };
}

+ (NSValueTransformer *)recordsJSONTransformer{
    return [MTLJSONAdapter arrayTransformerWithModelClass:WSFFieldFieldM.class];
}
@end
