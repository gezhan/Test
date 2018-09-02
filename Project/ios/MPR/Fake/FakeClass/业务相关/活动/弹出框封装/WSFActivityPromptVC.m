//
//  WSFActivityPromptVC.m
//  WinShare
//
//  Created by GZH on 2018/3/2.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityPromptVC.h"

@interface WSFActivityPromptVC ()

@end

@implementation WSFActivityPromptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupContentView];
    
}


- (void)setupContentView {
    UIView *backView = [UIView Z_createViewWithFrame:CGRectZero colorStr:@"#ffffff"];
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 10.0;
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(240, 134));
    }];
 
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [btn setTitleColor:[UIColor colorWithHexString:@"#2b84c6"] forState:UIControlStateNormal];
    [btn setTitle:@"我知道了" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(backView);
        make.height.mas_equalTo(49);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [backView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(backView);
        make.bottom.mas_equalTo(btn.mas_top);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    label.text = [NSString stringWithFormat:@"报名人数不足(%ld)人活动可能会取消", (long)_peopleNumber];
    [backView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(backView).offset(24);
        make.bottom.mas_equalTo(lineView).offset(-24);
    }];
    
}


- (void)btnAction {
    [self dismissViewControllerAnimated:NO completion:nil];
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
