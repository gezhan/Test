//
//  LMLable.h
//  有礼网
//
//  Created by yuntu on 13-12-17.
//  Copyright (c) 2013年 yuntu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>
@interface LMLable : UILabel{
}
@property (nonatomic,retain)NSMutableAttributedString          *attString;

// 设置某段字的颜色
- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length;

// 设置某段字的字体
- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length;

// 设置某段字的风格
- (void)setStyle:(CTUnderlineStyle)style fromIndex:(NSInteger)location length:(NSInteger)length;

+(UILabel *)lmlablerect:(CGRect)rect anduiFontname:(NSString *)fontname andTextcolor:(UIColor *)color andSize:(NSInteger)size;

@end
