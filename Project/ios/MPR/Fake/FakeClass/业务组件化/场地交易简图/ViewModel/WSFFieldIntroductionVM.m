//
//  WSFFieldIntroductionVM.m
//  WinShare
//
//  Created by QIjikj on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldIntroductionVM.h"

@implementation WSFFieldIntroductionVM

- (instancetype)init {
    if ([super init]) {
        // 使用时间
        self.timeString = [NSString stringWithFormat:@"使用时间：%@", @""];
        // 场次
        self.timeString = [NSString stringWithFormat:@"场次：%@", @""];
        // 套餐
        self.timeString = [NSString stringWithFormat:@"套餐：%@", @""];
        // 图片URL
        self.imageURL = [NSURL URLWithString:@""];
    }
    return self;
}

@end
