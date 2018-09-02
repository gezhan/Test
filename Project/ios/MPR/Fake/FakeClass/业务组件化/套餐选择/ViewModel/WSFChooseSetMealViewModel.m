//
//  WSFChooseSetMealViewModel.m
//  WinShare
//
//  Created by devRen on 2017/12/4.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFChooseSetMealViewModel.h"
#import "WSFSetMealManager.h"

@implementation WSFChooseSetMealCellViewModel

@end

@implementation WSFChooseSetMealViewModel

- (instancetype)initWithSetMealModelArray:(NSArray<WSFSetMealModel *> *)setMealModelArray monetary:(NSInteger)monetary selectedMealNo:(NSString *)selectedMealNo {
    self = [super init];
    if (self) {
        for (WSFSetMealModel * setMealModel in setMealModelArray) {
            WSFChooseSetMealCellViewModel *model = [[WSFChooseSetMealCellViewModel alloc] init];
            
            // 套餐名
            model.setMealNameString = [NSString stringWithFormat:@"%@:",setMealModel.mealNo];
            
            // 套餐内容富文本
            model.setMealContentString = [WSFSetMealManager machiningSetMealAttributedStringWithLimit:setMealModel.minimum setMealContent:setMealModel.mealContent];
            
            // 套餐是否满足条件
            if (monetary >= setMealModel.minimum) {
                model.dissatisfy = YES;
            } else {
                model.dissatisfy = NO;
            }
            
            // 选中图片样式
            if ([selectedMealNo isEqualToString:setMealModel.mealNo]) {
                model.selected = YES;
            } else {
                model.selected = NO;
            }
            
            [self.cellViewModelArray addObject:model];
        }
    }
    return self;
}

- (NSMutableArray *)cellViewModelArray {
    if (!_cellViewModelArray) {
        _cellViewModelArray = [[NSMutableArray alloc] init];
    }
    return _cellViewModelArray;
}

@end
