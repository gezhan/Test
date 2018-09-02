//
//  UILabel+WSF_LineSpacing.h
//  WinShare
//
//  Created by devRen on 2017/11/28.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (WSF_LineSpacing)

/**
 设置 UILabel 行距

 @param text Label中的文字
 @param lineSpacing 行距
 */
- (void)wsf_setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing;


/**
 给富文本设置行距

 @param butedText 富文本
 @param lineSpacing 行距
 */
- (void)wsf_setAttributedText:(NSMutableAttributedString *)butedText lineSpacing:(CGFloat)lineSpacing;

@end
