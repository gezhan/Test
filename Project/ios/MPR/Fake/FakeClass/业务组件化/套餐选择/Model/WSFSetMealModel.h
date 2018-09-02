//
//  WSFSetMealModel.h
//  WinShare
//
//  Created by devRen on 2017/12/5.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface WSFSetMealModel : MTLModel <MTLJSONSerializing>

/** 套餐ID */
@property (nonatomic, copy) NSString *mealID;
/** 所属空间ID */
@property (nonatomic, copy) NSString *roomId;
/** 套餐编号 (eg:套餐一、套餐二) */
@property (nonatomic, copy) NSString *mealNo;
/** 最低限额 */
@property (nonatomic, assign) NSInteger minimum;
/** 套餐内容 */
@property (nonatomic, copy) NSString *mealContent;

/**
 测试专用

 @param minimum 最低限额
 @param mealNo 套餐编号
 @return self
 */
- (instancetype)initWithMinimum:(NSInteger)minimum mealNo:(NSString *)mealNo DEPRECATED_ATTRIBUTE;

@end
