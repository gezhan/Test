//
//  WSFActivitySelectSpaceTVM.m
//  WinShare
//
//  Created by QIjikj on 2018/2/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivitySelectSpaceTVM.h"

@implementation WSFActivitySelectSpaceCellVM

@end

@implementation WSFActivitySelectSpaceTVM

// 假数据
- (instancetype)initWithNULL {
    if (self = [super init]) {
        for (int i = 0; i < 10 ; i++) {
            WSFActivitySelectSpaceCellVM *cellVM = [[WSFActivitySelectSpaceCellVM alloc] init];
            cellVM.spaceImageURL = @"timg.jpeg";
            cellVM.nameString = @"老树咖啡";
            cellVM.addressString = @"西湖华盛顿附近";
            cellVM.selected = NO;
            
            [self.activitySelectSpaceCellVMArray addObject:cellVM];
        }
    }
    return self;
}

- (NSMutableArray<WSFActivitySelectSpaceCellVM *> *)activitySelectSpaceCellVMArray {
    if (!_activitySelectSpaceCellVMArray) {
        _activitySelectSpaceCellVMArray = [NSMutableArray array];
    }
    return _activitySelectSpaceCellVMArray;
}

@end
