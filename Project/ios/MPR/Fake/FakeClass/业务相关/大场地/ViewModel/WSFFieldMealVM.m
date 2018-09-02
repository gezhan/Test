//
//  WSFFieldMealVM.m
//  WinShare
//
//  Created by GZH on 2018/1/19.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldMealVM.h"
#import "WSFFieldFieldM.h"
@implementation WSFFieldMealVM

-(instancetype)initWithsetMealModelArray:(NSArray<WSFFieldFieldM *>*)setMealModelArray {
    self = [super init];
    if (self) {
        for (int i = 0; i < setMealModelArray.count; i++) {
            WSFFieldFieldM *field = setMealModelArray[i];
            [self.frontArray addObject:field.timeType.value];
            
            NSString *setMealMinimum = @"";
            if (field.meals.count > 0) {
                WSFFieldSetMealsM *setMealsM = field.meals[0];
                setMealMinimum = [NSString stringWithFormat:@"%ld元/场起", (long)setMealsM.minimum];
            }
            NSString *behindStr  = [NSString stringWithFormat:@"%@ - %@    %@", field.beginTime, field.endTime, setMealMinimum];
            [self.behindArray addObject:behindStr];
        }
        
    }
    return self;
}


- (NSMutableArray *)frontArray {
    if (_frontArray == nil) {
        _frontArray = [NSMutableArray array];
    }
    return _frontArray;
}
- (NSMutableArray *)behindArray {
    if (_behindArray == nil) {
        _behindArray = [NSMutableArray array];
    }
    return _behindArray;
}

@end
