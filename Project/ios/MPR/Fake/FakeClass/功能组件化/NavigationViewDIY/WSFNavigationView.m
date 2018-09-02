//
//  WSFNavigationView.m
//  WinShare
//
//  Created by QIjikj on 2017/12/6.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFNavigationView.h"

@interface WSFNavigationView ()

@property (nonatomic, strong) UILabel *titleNameLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation WSFNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.bgImageView.backgroundColor = [UIColor whiteColor];
        self.bgImageView.alpha = 0;
        [self addSubview:self.bgImageView];
        
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.leftButton setBackgroundColor:[UIColor clearColor]];
      if (isPhoneX) {
        [self.leftButton setFrame:CGRectMake(0, 40, 44, 44)];
      }else {
        [self.leftButton setFrame:CGRectMake(0, 20, 44, 44)];
      }
        self.leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)) {
            self.leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        }
        [self.leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.leftButton];
        
        self.titleNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(44, 20, frame.size.width - 44 - 44, 44)];
        self.titleNameLabel.textAlignment = NSTextAlignmentCenter;
        self.titleNameLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.titleNameLabel];
        
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.rightButton setBackgroundColor:[UIColor clearColor]];
      if (isPhoneX) {
        [self.rightButton setFrame:CGRectMake(frame.size.width - 44, 40, 44, 44)];
      }else {
        [self.rightButton setFrame:CGRectMake(frame.size.width - 44, 20, 44, 44)];
      }
      
        [self.rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightButton];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - set赋值
- (void)setLeftBackgroundImage:(NSString *)leftBackgroundImage
{
    _leftBackgroundImage = leftBackgroundImage;
    [self.leftButton setImage:[UIImage imageNamed:leftBackgroundImage] forState:UIControlStateNormal];
}

- (void)setRightBackgroundImage:(NSString *)rightBackgroundImage
{
    _rightBackgroundImage = rightBackgroundImage;
    [self.rightButton setImage:[UIImage imageNamed:rightBackgroundImage] forState:UIControlStateNormal];
}

- (void)setTitleName:(NSString *)titleName
{
    _titleName = titleName;
    [self.titleNameLabel setText:titleName];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self.titleNameLabel setTextColor:titleColor];
}

#pragma mark - 协议方法回调
- (void)leftButtonClick
{
    if ([self.delegate respondsToSelector:@selector(navigationBarButtonLeftAction)]) {
        [self.delegate navigationBarButtonLeftAction];
    }
}

- (void)rightButtonClick
{
    if ([self.delegate respondsToSelector:@selector(navigationBarButtonRightAction)]) {
        [self.delegate navigationBarButtonRightAction];
    }
}

@end
