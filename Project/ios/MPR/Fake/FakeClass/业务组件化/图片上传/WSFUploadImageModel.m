//
//  WSFUploadImageModel.m
//  WinShare
//
//  Created by devRen on 2017/12/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFUploadImageModel.h"

@implementation WSFUploadImageModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"imageID" : @"ID",
             @"formatUrl" : @"FormatUrl",
             @"rowUrl" : @"RowUrl"
             };
}

@end
