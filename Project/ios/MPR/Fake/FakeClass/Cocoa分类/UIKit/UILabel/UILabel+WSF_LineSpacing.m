//
//  UILabel+WSF_LineSpacing.m
//  WinShare
//
//  Created by devRen on 2017/11/28.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "UILabel+WSF_LineSpacing.h"

@implementation UILabel (WSF_LineSpacing)

- (void)wsf_setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing {
    if (lineSpacing < 0.01 || !text) {
        self.text = text;
        return;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    self.attributedText = attributedString;
}

- (void)wsf_setAttributedText:(NSMutableAttributedString *)butedText lineSpacing:(CGFloat)lineSpacing {
    if (lineSpacing < 0.01 || !butedText) {
        self.attributedText = butedText;
        return;
    }
    
    [butedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [butedText length])];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    [butedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [butedText length])];
    
    self.attributedText = butedText;
}


@end
