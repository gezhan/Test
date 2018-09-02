//
//  WSFFieldBookSetMealView.h
//  WinShare
//
//  Created by QIjikj on 2018/1/17.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSFFieldBookSetMealVM;

NS_ASSUME_NONNULL_BEGIN

/**
 确定选中套餐的回调
 
 @param isHaveSetMeal 是否有选中套餐
 @param mealNo 套餐编号
 */
typedef void(^SelectedSetMealBlack)(BOOL isHaveSetMeal, NSString *mealNo, NSString *setMealId, NSString *priceString, NSString *priceNumber);

@interface WSFFieldBookSetMealView : UIView

/**
 确定选中套餐的回调
 */
@property (nonatomic, copy) SelectedSetMealBlack selectedSetMealBlack;

/**
 初始化view
 
 @param playgroundBookSetMealVM 数据
 @return self
 */
- (instancetype)initWithPlaygroundBookSetMealVM:(WSFFieldBookSetMealVM *)playgroundBookSetMealVM;

@end
NS_ASSUME_NONNULL_END


/** 使用举例
 
 WSFFieldPriceStallAPIModel *tempModel = [[WSFFieldPriceStallAPIModel alloc] init];
 tempModel.setMealId = @"123";
 tempModel.siteMealId = @"123";
 tempModel.mealNo = @"123";
 tempModel.minimum = 1000;
 tempModel.mealContent = @"梵蒂冈看了风华绝代孤苦伶仃房间观看了江东父的伤口附近的时刻房间都是雷锋精神的来访接待室了是江东父老看电视剧费拉达斯快放假了老附近的酸辣粉就打算离开";
 
 WSFFieldBookSetMealVM *tempVM = [[WSFFieldBookSetMealVM alloc] initWithPlaygroundPriceStallAPIModelArray:@[tempModel, tempModel, tempModel, tempModel, tempModel] didChoosedSetMealNo:@""];
 
 
 WSFFieldBookSetMealView *playgroundBookSetMealView = [[WSFFieldBookSetMealView alloc] initWithPlaygroundBookSetMealVM:tempVM];
 playgroundBookSetMealView.selectedSetMealBlack = ^(BOOL isHaveSetMeal, NSString * _Nonnull mealNo) {
 
 };
 
 */
