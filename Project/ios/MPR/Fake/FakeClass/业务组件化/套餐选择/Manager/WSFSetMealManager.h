//
//  WSFSetMealManager.h
//  WinShare
//
//  Created by devRen on 2017/12/5.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSFSetMealModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface WSFSetMealManager : NSObject

/**
 获取最优推荐
 ⚠️ 警告 没有最优推荐返回 nil

 @param setMealModelArray 套餐数组
 @param monetary 消费金额
 @return 返回最优套餐 或 nil
 */
+ (WSFSetMealModel *)getAvailableSetMealWithSetMealModelArray:(NSArray<WSFSetMealModel *> *)setMealModelArray
                                                     monetary:(NSInteger)monetary;

/**
 根据编号获取套餐

 @param setMealModelArray 套餐数组
 @param mealNo 套餐编号
 @return 返回对应套餐
 */
+ (WSFSetMealModel *)getSetMealWithModelArray:(NSArray<WSFSetMealModel *> *)setMealModelArray
                                       mealNo:(NSString *)mealNo;

/**
 加工套餐富文本

 @param setMealLimit 套餐限制
 @param setMealContent 套餐内容
 @return 返回富文本
 */
+ (NSMutableAttributedString *)machiningSetMealAttributedStringWithLimit:(NSInteger)setMealLimit
                                                          setMealContent:(NSString *)setMealContent;

@end
NS_ASSUME_NONNULL_END
