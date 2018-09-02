//
//  UITableViewCell+HSLayoutHeight.h
//  WinShare
//
//  Created by GZH on 2017/8/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (HSLayoutHeight)

/**
 获取cell高度
 
 @return 返回cell高度
 */
-(CGFloat)getLayoutCellHeight;

/**
 获取cell高度
 
 @param flex 偏移量
 @return 返回cell高度
 */
-(CGFloat)getLayoutCellHeightWithFlex:(CGFloat)flex;

/**
 获取cell高度
 
 @param flex 偏移量
 @param bottomView 最底部的视图
 @return 返回cell高度
 */
-(CGFloat)getLayoutCellHeightWithFlex:(CGFloat)flex bottomView:(UIView *)bottomView;

/**
 获取cell高度
 
 @param flex 偏移量
 @param bottomView 最底部的视图
 @param defaultHeight 默认cell高度
 @return 返回cell高度
 */
-(CGFloat)getLayoutCellHeightWithFlex:(CGFloat)flex bottomView:(UIView *)bottomView defaultHeight:(CGFloat)defaultHeight;

@end
