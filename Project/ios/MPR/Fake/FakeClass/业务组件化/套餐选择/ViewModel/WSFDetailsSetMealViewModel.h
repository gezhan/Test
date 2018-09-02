//
//  WSFDetailsSetMealViewModel.h
//  WinShare
//
//  Created by devRen on 2017/12/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WSFSetMealModel;

NS_ASSUME_NONNULL_BEGIN
@interface WSFDetailsSetMealViewModel : NSObject

/** 套餐内容数组 */
@property (nonatomic, strong) NSMutableArray<NSMutableAttributedString *> *setContentArray;
/** 套餐编号数组 */
@property (nonatomic, strong) NSMutableArray<NSString *> *setNoArray;
/** 是否有省略号 */
@property (nonatomic, getter=isHaveDots,assign) BOOL haveDots;

/**
 初始化方法

 @param setMealModelArray 套餐模型数组
 @return self
 */
- (instancetype)initWithSetMealModelArray:(NSArray<WSFSetMealModel *> *)setMealModelArray;

@end
NS_ASSUME_NONNULL_END
