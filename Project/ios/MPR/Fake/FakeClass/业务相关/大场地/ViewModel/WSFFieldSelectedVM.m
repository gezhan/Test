//
//  WSFFieldSelectedVM.m
//  WinShare
//
//  Created by GZH on 2018/1/18.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldSelectedVM.h"
#import "WSFFieldSelectedModel.h"
#import "WSFFieldFieldM.h"
@implementation WSFFieldMealContentCellVM

@end

@implementation WSFFieldSelectedCellVM

@end

@implementation WSFFieldSelectedVM

- (instancetype)initWithselectedModel:(WSFFieldSelectedModel *)playgroundModel {
    self = [super init];
    if (self) {

        self.isTip = playgroundModel.isTip;
        self.tip = playgroundModel.tip;
        for (int i = 0; i < playgroundModel.records.count; i++) {
            WSFFieldFieldM *fieldM = playgroundModel.records[i];
            WSFFieldSelectedCellVM *selectedM = [[WSFFieldSelectedCellVM alloc]init];
            selectedM.siteMealId = fieldM.siteMealId;
            selectedM.roomId = fieldM.roomId;
            selectedM.beginEndTime  = [NSString stringWithFormat:@"%@ %@ - %@", fieldM.timeType.value , fieldM.beginTime, fieldM.endTime];
            
            NSMutableArray *setMealArray = [NSMutableArray array];
            for (int i = 0; i < fieldM.meals.count; i++) {
                WSFFieldSetMealsM *setMealm = fieldM.meals[i];
                WSFFieldMealContentCellVM *contentCellM = [[WSFFieldMealContentCellVM alloc]init];
                contentCellM.setMealId = setMealm.setMealId;
                contentCellM.siteMealId = setMealm.siteMealId;
                contentCellM.mealNo = setMealm.mealNo;
                contentCellM.minimum = [NSString stringWithFormat:@"￥%ld/场", (long)setMealm.minimum];
                contentCellM.minimumInteger = setMealm.minimum;
                contentCellM.mealContent = setMealm.mealContent;
                [setMealArray addObject:contentCellM];
            }
            selectedM.setMealArray = setMealArray;
            
            [self.dataSource addObject:selectedM];
        }
    }
    return self;
}


#pragma mark - 懒加载
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}




@end
