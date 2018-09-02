//
//  WSFFieldBookSetMealCell.h
//  WinShare
//
//  Created by QIjikj on 2018/1/17.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSFFieldBookSetMealCell : UITableViewCell

/** 价格档次*/
@property (nonatomic, strong) UILabel *priceStallLabel;
/** 描述*/
@property (nonatomic, strong) UILabel *priceStallContentLabel;
/** 选择按钮*/
@property (nonatomic, strong) UIImageView *chooseImageView;

/**
 通知设置是否选中，调整图片样式
 @param isSelected 是否选中
 */
- (void)theSetMealIsSelected:(BOOL)isSelected;

@end
