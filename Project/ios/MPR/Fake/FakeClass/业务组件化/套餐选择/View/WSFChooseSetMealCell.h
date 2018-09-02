//
//  WSFChooseSetMealCell.h
//  WinShare
//
//  Created by devRen on 2017/12/4.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface WSFChooseSetMealCell : UITableViewCell

/** 套餐 */
@property (nonatomic, strong) UILabel *setMealLabel;
/** 套餐名 */
@property (nonatomic, strong) UILabel *setMealNameLabel;
/** 选择按钮 */
@property (nonatomic, strong) UIImageView *chooseImageView;
/** 不满足条件 */
@property (nonatomic, strong) UILabel *dissatisfyLabel;

/**
 通知设置是否选中，调整图片样式

 @param isSelected 是否选中
 */
- (void)theSetMealIsSelected:(BOOL)isSelected;

@end
NS_ASSUME_NONNULL_END
