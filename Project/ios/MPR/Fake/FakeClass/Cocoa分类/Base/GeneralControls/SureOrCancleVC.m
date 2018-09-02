//
//  SureOrCancleVC.m
//  WinShare
//
//  Created by GZH on 2017/5/8.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "SureOrCancleVC.h"

@interface SureOrCancleVC ()
{
    UIView *_baseView;
    UIView *overView;
}
@end

@implementation SureOrCancleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setContentView];
    
}

- (void)setContentView {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    overView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    overView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    [window addSubview:overView];
    
    _baseView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-(540/2))/2, (SCREEN_HEIGHT-100)/2, 540/2, 100)];
    _baseView.backgroundColor = [UIColor whiteColor];
    _baseView.layer.cornerRadius = 6;
    _baseView.clipsToBounds = YES;
    [overView addSubview:_baseView];
    
    UILabel *remindLab = [[UILabel alloc] initWithFrame:CGRectMake(12, (_baseView.height-44-40)/2, _baseView.width-12*2, 40)];
    remindLab.font = [UIFont systemFontOfSize:16];
    remindLab.textColor = [UIColor colorWithHexString:@"#333333"];
    remindLab.numberOfLines = 2;
    remindLab.text = self.titleStr;
    
    remindLab.textAlignment = NSTextAlignmentCenter;
    [_baseView addSubview:remindLab];
    
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, _baseView.height-44, _baseView.width, 44)];
    baseView.backgroundColor = [UIColor whiteColor];
    [_baseView addSubview:baseView];
    
    //顶部横线
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _baseView.width, .5)];
    topView.backgroundColor = [UIColor colorWithHexString:@"#d5d7dc"];
    [baseView addSubview:topView];
    
    
    NSArray *titleArr = @[@"确定",@"取消"];
    
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(_baseView.width/2.0), 0, _baseView.width/2.0, 44);
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.tag = i;
        [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:btn];
        
    }
    
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(baseView.width/2.0, (44-20)/2, .5, 20)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#d5d7dc"];
    [baseView addSubview:lineView];
    
}


- (void)btnAction:(UIButton *)btn
{
    [overView removeFromSuperview];
    overView = nil;
    [self dismissViewControllerAnimated:NO completion:nil];
    if (btn.tag == 0) {
        if (self.clickSureBlock)_clickSureBlock();
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
