//
//  FullScreenBackView.m
//  WinShare
//
//  Created by GZH on 2017/5/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "FullScreenBackView.h"

@interface FullScreenBackView ()
{
    UIView *_overView;
    UIImageView *_imageView;
}
@end

@implementation FullScreenBackView

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupContentView];
}


- (void)setupContentView {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _overView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _overView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    [window addSubview:_overView];
    
    //-------window上边的视图
    [_overView addSubview:self.showView];
    
    //右上角的关闭按钮
    if (self.isShowCloseSymbol) {
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.image = [UIImage imageNamed:@"close"];
        _imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeAction)];
        [_imageView addGestureRecognizer:tap];
        [_overView addSubview:_imageView];
    }
}

- (void)updateViewConstraints
{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.showView.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.showView.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(25, 48));
    }];
    
    [super updateViewConstraints];
}

- (void)removeAction {
   
    [_overView removeFromSuperview];
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
