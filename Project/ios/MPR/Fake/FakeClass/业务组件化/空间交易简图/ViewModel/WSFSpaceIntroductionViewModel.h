//
//  WSFSpaceIntroductionViewModel.h
//  WinShare
//
//  Created by devRen on 2017/12/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WSFRPOrderApiModel;

NS_ASSUME_NONNULL_BEGIN
@interface WSFSpaceIntroductionViewModel : NSObject

/** 预定时间 */
@property (nonatomic, copy) NSString *timeString;
/** 单价 */
@property (nonatomic, copy) NSString *priceString;
/** 时长 */
@property (nonatomic, copy) NSString *durationString;
/** 套餐 */
@property (nonatomic, copy) NSString *setMealString;
/** 图片URL */
@property (nonatomic, copy) NSURL *imageURL;
/** 是否有套餐 */
@property (nonatomic, getter=isHaveSetMeal, assign) BOOL haveSetMeal;

/**
 初始化方法

 @param orderIntroductionModel 订单model
 @return self
 */
- (instancetype)initWithOrderIntroductionModel:(WSFRPOrderApiModel *)orderIntroductionModel;

@end
NS_ASSUME_NONNULL_END
