//
//  WSFChooseSetMealView.h
//  WinShare
//
//  Created by devRen on 2017/12/4.
//  Copyright © 2017年 QiJikj. All rights reserved.
//
//  选择套餐弹框view

#import <UIKit/UIKit.h>
@class WSFChooseSetMealViewModel;

NS_ASSUME_NONNULL_BEGIN
/**
 确定选中套餐的回调

 @param isHaveSetMeal 是否有选中套餐
 @param mealNo 套餐编号
 */
typedef void(^SelectedSetMealBlack)(BOOL isHaveSetMeal, NSString *mealNo);

@interface WSFChooseSetMealView : UIView

/**
 确定选中套餐的回调
 */
@property (nonatomic, copy) SelectedSetMealBlack selectedSetMealBlack;

/**
 初始化view

 @param chooseSetMealViewModel viewmodel
 @return self
 */
- (instancetype)initWithChooseSetMealViewModel:(WSFChooseSetMealViewModel *)chooseSetMealViewModel;

@end
NS_ASSUME_NONNULL_END
