//
//  WSFTimePointVM.m
//  WinShare
//
//  Created by GZH on 2018/2/26.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFTimePointVM.h"

@implementation WSFTimePointVM

- (instancetype)init {
    self = [super init];
    if (self) {
        
        //时
        for (int i = 0; i < 24; i++) {
            if (i < 10) {
                [self.whenArray addObject:[NSString stringWithFormat:@"0%d", i]];
            }else {
                [self.whenArray addObject:[NSString stringWithFormat:@"%d", i]];
            }
        }

        //分
        for (int i = 0; i < 60; i++) {
            if (i < 10) {
                [self.pointsArray addObject:[NSString stringWithFormat:@"0%d", i]];
            }else {
                [self.pointsArray addObject:[NSString stringWithFormat:@"%d", i]];
            }
        }
        
    }
    return self;
}

- (NSMutableArray *)whenArray {
    if (_whenArray == nil) {
        _whenArray = [NSMutableArray array];
    }
    return _whenArray;
}

- (NSMutableArray *)pointsArray {
    if (_pointsArray == nil) {
        _pointsArray = [NSMutableArray array];
    }
    return _pointsArray;
}

@end
