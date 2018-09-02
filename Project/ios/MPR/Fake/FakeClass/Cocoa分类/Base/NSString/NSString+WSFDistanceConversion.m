//
//  NSString+WSFDistanceConversion.m
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "NSString+WSFDistanceConversion.h"

@implementation NSString (WSFDistanceConversion)

// 获取距离大小
+ (NSString *)distanceSizeFormatWithOriginMeter:(NSInteger)originMeter {
    NSString *sizeUnitString;
    float size = originMeter;
    if(size < 1000){
        sizeUnitString = [NSString stringWithFormat:@"%.1fm", size];
    }else{
        size /= 1000;
        sizeUnitString = [NSString stringWithFormat:@"%.1fkm", size];
    }
    return sizeUnitString;
}

@end
