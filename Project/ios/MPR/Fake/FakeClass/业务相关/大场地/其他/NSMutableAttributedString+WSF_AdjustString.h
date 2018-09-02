//
//  NSMutableAttributedString+WSF_AdjustString.h
//  WinShare
//
//  Created by GZH on 2018/1/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (WSFAdjustString)

/**  富文本的调整，前后文字的大小和颜色不同
 *   改变富文本前边部分的大小和颜色
 */
+ (NSMutableAttributedString *)wsf_adjustOriginalString:(NSString *)string
                                       frontStringColor:(UIColor *)frontColor
                                        frontStringFont:(CGFloat)frontFont
                                           behindString:(NSString *)behindString;

/**  设置富文本的行间距
 *   string
 *   space   行间距的大小
 */
+ (NSMutableAttributedString *)wsf_setupLabelString:(NSString *)string lineSpace:(CGFloat)space;

@end
