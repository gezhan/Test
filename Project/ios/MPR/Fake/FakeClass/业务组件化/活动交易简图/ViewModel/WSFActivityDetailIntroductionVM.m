//
//  WSFActivityDetailIntroductionVM.m
//  WinShare
//
//  Created by ZWL on 2018/3/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityDetailIntroductionVM.h"

@implementation WSFActivityDetailIntroductionVM

- (instancetype)init {
    if (self = [super init]) {
        self.nameString = [NSString stringWithFormat:@"活动名称：%@", @""];
        self.timeString = [NSString stringWithFormat:@"活动时间：%@", @""];
        self.addressString = [NSString stringWithFormat:@"活动地址：%@", @""];
        self.imageURL = [NSURL URLWithString:@""];
    }
    return self;
}

@end
