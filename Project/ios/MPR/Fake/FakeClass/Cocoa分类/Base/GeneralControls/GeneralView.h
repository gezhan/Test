//
//  FootView.h
//  XiaoYing
//
//  Created by GZH on 2017/2/27.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeneralView : UIView
@property (nonatomic, strong)UIButton *generalBtn;
@end






//
////tableview最下部的按钮
//GeneralView *footView = [[GeneralView alloc] initWithFrame:CGRectMake(0, kScreen_Height-44-64, kScreen_Width, 44)];
//[footView.generalBtn setTitle:@"提交" forState:UIControlStateNormal];
//[footView.generalBtn addTarget:self action:@selector(judgeConditionsAction) forControlEvents:UIControlEventTouchUpInside];
//[self.view addSubview:footView];
