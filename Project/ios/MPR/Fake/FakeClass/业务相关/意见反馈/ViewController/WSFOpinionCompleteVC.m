//
//  WSFOpinionCompleteVC.m
//  WinShare
//
//  Created by GZH on 2017/12/4.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFOpinionCompleteVC.h"
#import "WSFOpinionBackVC.h"

@interface WSFOpinionCompleteVC ()

@end

@implementation WSFOpinionCompleteVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationItem.title = @"意见反馈";
    
    [self setContentView];
}

- (void)setContentView {
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"opinion_ganxie"];
    [self.view addSubview:imageView];
    [imageView sizeToFit];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(-64);
    }];
    
    UIButton *sureBtn = [[UIButton alloc]init];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"#2b84c6"];
    [sureBtn addTarget:self action:@selector(beSureAction) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@44);
    }];
}

/**  确定 */
- (void)beSureAction {
    NSLog(@"----确定");
    [self doBackAction];
}

- (void)doBackAction {
    
    NSArray *vcArray = self.navigationController.viewControllers;
    WSFBaseViewController *destributeVC = nil;
    for (UIViewController *tempVC in vcArray) {
        if ([tempVC isKindOfClass:[WSFOpinionBackVC class]]) {
            destributeVC = (WSFBaseViewController *)tempVC;
        }
    }
    
    if (destributeVC.dismiss) {
        [destributeVC doBackAction];
    }else {
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:NO];
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
