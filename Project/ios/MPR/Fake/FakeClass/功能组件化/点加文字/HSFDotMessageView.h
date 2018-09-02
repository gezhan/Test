//
//  HSFDotMessageView.h
//  WinShare
//
//  Created by QIjikj on 2017/10/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSFDotMessageView : UIView

/** 样式简图
 |————————————————————————————|
 |* wenziwenziwenziwenziwenzi |
 |  wenziwenziwenziwenziwenzi |
 |  wenziwenzi                |
 |* wenziwenziwenzi           |
 |* wenziwenziwenziwenziwenzi |
 |  wenziwenzi                |
 |————————————————————————————|
 */
#pragma mark - 标题点+内容文字
- (instancetype)initWithContentArray:(NSArray<NSString *> *)contentArr contentFont:(NSInteger)contentFont contentColor:(UIColor *)contentColor dotSize:(CGSize)dotSize dotColor:(UIColor *)dotColor groupHeight:(NSInteger)groupHeight;

- (void)resetContentArray:(NSArray <NSString *>*)contentArr contentFont:(NSInteger)contentFont contentColor:(UIColor *)contentColor dotSize:(CGSize)dotSize dotColor:(UIColor *)dotColor groupHeight:(NSInteger)groupHeight;

- (void)resetContentArray:(NSArray <NSString *>*)contentArr;

/** 样式简图
 |——————————————————————————————————|
 |biaoti1 wenziwenziwenziwenziwenzi |
 |        wenziwenziwenziwenziwenzi |
 |        wenziwenzi                |
 |biaoti2 wenziwenziwenzi           |
 |biaoti3 wenziwenziwenziwenziwenzi |
 |        wenziwenzi                |
 |——————————————————————————————————|
 */
#pragma mark - 标题文字+内容文字
- (instancetype)initWithContentArray:(NSArray<NSString *> *)contentArr contentfont:(NSInteger)contentFont contentColor:(UIColor *)contentColor titleArray:(NSArray<NSString *> *)titleArr titleFont:(NSInteger)titleFont titleColor:(UIColor *)titleColor groupHeight:(NSInteger)groupHeight;

- (void)resetContentArray:(NSArray<NSString *> *)contentArr contentfont:(NSInteger)contentFont contentColor:(UIColor *)contentColor titleArray:(NSArray<NSString *> *)titleArr titleFont:(NSInteger)titleFont titleColor:(UIColor *)titleColor groupHeight:(NSInteger)groupHeight;

@end
