//
//  WSFChooseSetMealViewModel.h
//  WinShare
//
//  Created by devRen on 2017/12/4.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSFSetMealModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface WSFChooseSetMealCellViewModel : NSObject

/** 套餐名 */
@property (nonatomic, copy) NSString *setMealNameString;
/** 套餐内容 */
@property (nonatomic, strong) NSMutableAttributedString *setMealContentString;
/** 套餐是否满足条件 */
@property (nonatomic, getter=isDissatisfy, assign) BOOL dissatisfy;
/** 套餐是否被选中 */
@property (nonatomic, getter=isSelected, assign) BOOL selected;

@end

@interface WSFChooseSetMealViewModel : NSObject

/** cell的ViewModel */
@property (nonatomic, strong) NSMutableArray<WSFChooseSetMealCellViewModel *> *cellViewModelArray;

/**
 初始化ViewModel

 @param setMealModelArray 套餐数组
 @param monetary 消费金额
 @param selectedMealNo 选中的套餐 （若没有传空字符串）
 @return self
 */
- (instancetype)initWithSetMealModelArray:(NSArray<WSFSetMealModel *> *)setMealModelArray monetary:(NSInteger)monetary selectedMealNo:(NSString *)selectedMealNo;

@end
NS_ASSUME_NONNULL_END
