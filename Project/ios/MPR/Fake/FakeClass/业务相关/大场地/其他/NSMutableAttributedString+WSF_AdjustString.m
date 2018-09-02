//
//  NSMutableAttributedString+WSF_AdjustString.m
//  WinShare
//
//  Created by GZH on 2018/1/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "NSMutableAttributedString+WSF_AdjustString.h"

@implementation NSMutableAttributedString (WSFAdjustString)

+ (NSMutableAttributedString *)wsf_adjustOriginalString:(NSString *)string
                                       frontStringColor:(UIColor *)frontColor
                                        frontStringFont:(CGFloat)frontFont
                                           behindString:(NSString *)behindString {
    //富文本前边部分的长度
    CGFloat frontstringLength = string.length - behindString.length;
    //富文本前边部分的设置
    NSMutableAttributedString *richText = [[NSMutableAttributedString alloc]initWithString:string];
    [richText addAttribute:NSFontAttributeName
                     value:[UIFont systemFontOfSize:frontFont]
                     range:NSMakeRange(0, frontstringLength)];
    [richText addAttribute:NSForegroundColorAttributeName
                     value:frontColor
                     range:NSMakeRange(0, frontstringLength)];
    return richText;
}


+ (NSMutableAttributedString *)wsf_setupLabelString:(NSString *)string lineSpace:(CGFloat)space {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    return attributedString;
}

@end
