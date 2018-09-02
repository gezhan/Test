//
//  WSFDetailsSetMealViewModel.m
//  WinShare
//
//  Created by devRen on 2017/12/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDetailsSetMealViewModel.h"
#import "WSFSetMealModel.h"
#import "WSFSetMealManager.h"

@implementation WSFDetailsSetMealViewModel

- (instancetype)initWithSetMealModelArray:(NSArray<WSFSetMealModel *> *)setMealModelArray {
    self = [super init];
    if (self) {
        if (setMealModelArray.count > 3) {
            self.haveDots = YES;
        } else {
            self.haveDots = NO;
        }
        
        for (NSInteger i = 0; i < setMealModelArray.count; i ++) {
            if (i < 3) {
                WSFSetMealModel *model = setMealModelArray[i];
                [self.setNoArray addObject:[NSString stringWithFormat:@"%@:",model.mealNo]];
                [self.setContentArray addObject:[WSFSetMealManager machiningSetMealAttributedStringWithLimit:model.minimum setMealContent:model.mealContent]];
            }
        }
    }
    return self;
}

- (NSMutableArray *)setContentArray {
    if (!_setContentArray) {
        _setContentArray = [[NSMutableArray alloc] init];
    }
    return _setContentArray;
}

- (NSMutableArray *)setNoArray {
    if (!_setNoArray) {
        _setNoArray = [[NSMutableArray alloc] init];
    }
    return _setNoArray;
}
@end
