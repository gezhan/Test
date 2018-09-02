//
//  WSFCityViewModel.m
//  WinShare
//
//  Created by GZH on 2017/12/20.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFCityViewModel.h"

@implementation WSFCityViewModel

- (instancetype)initWithCityModelArray:(NSArray<WSFCityArrayModel *> *)cityModelArray {
    self = [super init];
    if (self) {
        for (WSFCityArrayModel *model in cityModelArray) {
            [self.firstSpellArray addObject:model.spell];
            [self.cityArray addObject:model.regions];
        }
    }
    return self;
}


- (NSMutableArray *)firstSpellArray {
    if (_firstSpellArray == nil) {
        _firstSpellArray = [NSMutableArray arrayWithObjects:@"定位", @"热门", nil];
    }
    return _firstSpellArray;
}
- (NSMutableArray *)cityArray {
    if (_cityArray == nil) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}

@end
