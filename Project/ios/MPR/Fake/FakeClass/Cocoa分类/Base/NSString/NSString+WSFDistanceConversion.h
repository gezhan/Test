//
//  NSString+WSFDistanceConversion.h
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WSFDistanceConversion)

/**
 ** 将后台数据转换成我们需要展示的数据
 * originMeter 接口请求回来的数据
 */
+ (NSString *)distanceSizeFormatWithOriginMeter:(NSInteger)originMeter;

@end
