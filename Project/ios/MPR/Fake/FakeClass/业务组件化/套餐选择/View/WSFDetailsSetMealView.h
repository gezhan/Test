//
//  WSFDetailsSetMealView.h
//  WinShare
//
//  Created by devRen on 2017/12/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//
//  空间详情中的套餐view

#import <UIKit/UIKit.h>
@class WSFDetailsSetMealViewModel;

NS_ASSUME_NONNULL_BEGIN
@interface WSFDetailsSetMealView : UIView

/**
 最底部的控件，用于布局
 */
@property (nonatomic, strong) UIView *bottomView;

/**
 初始化view
 
 @param detailsSetMealViewModel viewmodel
 @return self
 */
- (instancetype)initWithDetailsSetMealViewModel:(WSFDetailsSetMealViewModel *)detailsSetMealViewModel;

@end
NS_ASSUME_NONNULL_END
