//
//  LMButton.h
//  AiMianDan
//
//  Created by li on 14-6-17.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LMButtonColor [UIColor colorWithRed:131/255.0 green:131/255.0 blue:131/255.0 alpha:1.0]
@interface LMButton : UIButton
+(UIBarButtonItem *)setNavleftComboButtonWithImg:(NSString *)img andSelector:(SEL)action andTarget:(id)target;
+(UIButton *)lmcustomBt:(CGRect)rect andTarget:(id)target andtag:(NSInteger)tag andimage:(NSString *)imageOne selectImage:(NSString *)imageTwo andaction:(SEL)action;
+(UIBarButtonItem *)setNavleftButtonWithImg:(NSString *)img andSelector:(SEL)action andTarget:(id)target;
+(UIBarButtonItem *)setNavright:(NSString *)title andcolor:(UIColor *)color andSelector:(SEL)action andTarget:(id)target;
//设置title
+(UIButton *)lmTitleBt:(CGRect)rect andTarget:(id)target andtag:(NSInteger)tag andimage:(NSString *)image andTitle:(NSString*)title andaction:(SEL)action;
//设定大小
+(UIBarButtonItem *)setSizeButton:(CGRect)rect WithImg:(NSString *)img andSelector:(SEL)action andTarget:(id)target;
@end
