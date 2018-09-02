//
//  NSMutableAttributedString+WSFExtend.h
//  WinShare
//
//  Created by GZH on 2018/3/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (WSFExtend)
/**  获取富文本，并设置字体大小和颜色 */
+(NSMutableAttributedString *)wsf_attributeString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;

/**  拼接富文本 */
-(void)wsf_addString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;

/**  设置行间距 */
-(void)wsf_setLineSpace:(CGFloat)space range:(NSRange)range;

/**  设置居中 */
-(void)wsf_setTextAlignment:(NSTextAlignment)textAlignment lineSpace:(CGFloat)space range:(NSRange)range;

@end
