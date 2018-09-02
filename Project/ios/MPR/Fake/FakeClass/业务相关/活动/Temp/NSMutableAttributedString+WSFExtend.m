//
//  NSMutableAttributedString+WSFExtend.m
//  WinShare
//
//  Created by GZH on 2018/3/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "NSMutableAttributedString+WSFExtend.h"

@implementation NSMutableAttributedString (WSFExtend)

/**  获取富文本，并设置字体大小和颜色 */
+(NSMutableAttributedString *)wsf_attributeString:(NSString *)string font:(UIFont *)font color:(UIColor *)color {
    if (string == nil) string = @"" ;
    NSRange range = NSMakeRange(0,string.length);
    NSMutableAttributedString *tempString = [[NSMutableAttributedString alloc] initWithString:string];
    [tempString addAttribute:NSFontAttributeName value:font range:range];
    [tempString addAttribute:NSForegroundColorAttributeName value:color range:range];
    return tempString ;
}

/**  拼接富文本 */
-(void)wsf_addString:(NSString *)string font:(UIFont *)font color:(UIColor *)color {
    NSMutableAttributedString *tempString = [NSMutableAttributedString wsf_attributeString:string font:font color:color];
    [self appendAttributedString:tempString];
}

/**  设置行间距 */
-(void)wsf_setLineSpace:(CGFloat)space range:(NSRange)range {
    // 调整行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
}

/**  设置居中 */
-(void)wsf_setTextAlignment:(NSTextAlignment)textAlignment lineSpace:(CGFloat)space range:(NSRange)range {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:textAlignment];
    [paragraphStyle setLineSpacing:space];
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
}


@end
