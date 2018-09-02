//
//  WSFBookSetMealView.h
//  WinShare
//
//  Created by devRen on 2017/12/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//
//  订单时间选择套餐view


// 说明
//
// 初始化方式：[[WSFBookSetMealView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 82)]
//
// 更新 *推荐最优组合*
// [self.mealView recommendBestSetMeal:@"套餐一：" setMeal:attrStr];
// [self.mealView mas_remakeConstraints:^(MASConstraintMaker *make) {
//     make.left.top.right.equalTo(self.view);
//     make.bottom.equalTo(self.mealView.setMealLabel.mas_bottom).mas_offset(10);
// }];
//
// 更新 *无可选套餐*
// [self.mealView noRecommend];
// [self.mealView mas_remakeConstraints:^(MASConstraintMaker *make) {
//     make.left.top.right.equalTo(self.view);
//     make.height.equalTo(@82);
// }];

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface WSFBookSetMealView : UIView

@property (nonatomic, strong) UIButton *setMealButton;      // 套餐选择按钮
@property (nonatomic, strong) UILabel *setMealLabel;        // 套餐

/**
 初始化方法

 @param frame 坐标
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 推荐最优组合套餐

 @param setMealName 套餐名
 @param setMeal 套餐富文本
 */
- (void)recommendBestSetMeal:(NSString *)setMealName setMeal:(NSMutableAttributedString *)setMeal;

/** 无可选套餐 */
- (void)noSetMeal;

/**
 非推荐最优组合，手动选中套餐

 @param setMealName 套餐名
 @param setMeal 套餐富文本
 */
- (void)noRecommendSetMeal:(NSString *)setMealName setMeal:(NSMutableAttributedString *)setMeal;

/** view的默认高度 */
FOUNDATION_EXPORT NSInteger WSFBookSetMealViewDefaultHeight;

@end
NS_ASSUME_NONNULL_END
