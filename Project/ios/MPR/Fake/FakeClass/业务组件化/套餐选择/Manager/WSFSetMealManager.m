//
//  WSFSetMealManager.m
//  WinShare
//
//  Created by devRen on 2017/12/5.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFSetMealManager.h"

@implementation WSFSetMealManager

+ (WSFSetMealModel *)getAvailableSetMealWithSetMealModelArray:(NSArray<WSFSetMealModel *> *)setMealModelArray
                                                     monetary:(NSInteger)monetary {
    
    NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"minimum" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"mealNo"ascending:YES];
    NSArray *tempArray = [setMealModelArray sortedArrayUsingDescriptors:@[sortDescriptor1,sortDescriptor2]];

    WSFSetMealModel *firstModel = [tempArray firstObject];
    if (monetary < firstModel.minimum) {
        return nil; // 消费金额小于所有最低限额
    }
    
    for (NSInteger i = 0; i < tempArray.count; i ++) {
        WSFSetMealModel *model = tempArray[i];
        if (i == tempArray.count - 1) {
            return model; // 消费金额大于所有最低限额
        } else {
            if (monetary == model.minimum) {
                return model; // 消费金额 == 最低限额 
            }
            
            WSFSetMealModel *nextModel = tempArray[i + 1];
            if (monetary > model.minimum && monetary < nextModel.minimum) {
                if (i > 0) {
                    WSFSetMealModel *priorModel = tempArray[i - 1];
                    if (model.minimum == priorModel.minimum) {
                        for (NSInteger j = i - 2; j >= 0; j --) {
                            WSFSetMealModel *morePriorModel = tempArray[j];
                            if (morePriorModel.minimum != model.minimum) {
                                return tempArray[j + 1];    // 最低限额相同的情况，返回套餐编号小的套餐
                            }
                        }
                        
                    } else {
                        return model;
                    }
                } else {
                    return model;
                }
            }
        }
    }
    
    return nil;
}

+ (WSFSetMealModel *)getSetMealWithModelArray:(NSArray<WSFSetMealModel *> *)setMealModelArray
                                       mealNo:(NSString *)mealNo {
    for (NSInteger i = 0; i < setMealModelArray.count; i ++) {
        WSFSetMealModel *model = setMealModelArray[i];
        if ([model.mealNo isEqualToString:mealNo]) {
            return model;
        }
    }
    
    return nil;
}

+ (NSMutableAttributedString *)machiningSetMealAttributedStringWithLimit:(NSInteger)setMealLimit
                                                          setMealContent:(NSString *)setMealContent {
    NSString *limit = [NSString stringWithFormat:@"满%ld",(long)setMealLimit];
    NSString *content = [NSString stringWithFormat:@" 赠（%@）",setMealContent];
    NSString *setMeal = [NSString stringWithFormat:@"%@%@",limit,content];
    NSMutableAttributedString *setMealAtt = [[NSMutableAttributedString alloc] initWithString:setMeal];
    [setMealAtt addAttribute:NSForegroundColorAttributeName
                    value:[UIColor orangeColor]
                    range:NSMakeRange(0, limit.length)];
    
    return setMealAtt;
}

@end
