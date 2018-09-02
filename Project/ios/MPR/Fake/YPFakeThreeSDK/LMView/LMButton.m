//
//  LMButton.m
//  AiMianDan
//
//  Created by li on 14-6-17.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import "LMButton.h"

@implementation LMButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(UIButton *)lmcustomBt:(CGRect)rect andTarget:(id)target andtag:(NSInteger)tag andimage:(NSString *)imageOne selectImage:(NSString *)imageTwo andaction:(SEL)action
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=rect;
    button.tag=tag;
    button.backgroundColor=[UIColor clearColor];
    [button setImage:[UIImage imageNamed:imageOne] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageTwo] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+(UIBarButtonItem *)setNavleftButtonWithImg:(NSString *)img andSelector:(SEL)action andTarget:(id)target{
    //导航左侧返回按钮
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame=CGRectMake(0, 0, 44, 44);
    [bt setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:bt];
    return leftButton;
}
+(UIBarButtonItem *)setNavleftComboButtonWithImg:(NSString *)img andSelector:(SEL)action andTarget:(id)target{
    //导航左侧返回按钮
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame=CGRectMake(0, 0, 44, 44);
    [bt setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:bt];
    return leftButton;
}

//设定大小
+(UIBarButtonItem *)setSizeButton:(CGRect)rect WithImg:(NSString *)img andSelector:(SEL)action andTarget:(id)target
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame=rect;
    [bt setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:bt];
    return leftButton;
}
//导航栏右侧按钮文字
+(UIBarButtonItem *)setNavright:(NSString *)title andcolor:(UIColor *)color andSelector:(SEL)action andTarget:(id)target
{
//    UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:action];
//    [barbtn setTitle:title];
//    [barbtn setTintColor:color];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] init];
    [anotherButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [anotherButton setTitle:title];
    [anotherButton setTintColor:color];
    anotherButton.action=action;
    anotherButton.target=target;
    return anotherButton;
}

//设置title
+(UIButton *)lmTitleBt:(CGRect)rect andTarget:(id)target andtag:(NSInteger)tag andimage:(NSString *)image andTitle:(NSString*)title andaction:(SEL)action
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=rect;
    button.tag=tag;
    button.backgroundColor=[UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitleColor:LMButtonColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
