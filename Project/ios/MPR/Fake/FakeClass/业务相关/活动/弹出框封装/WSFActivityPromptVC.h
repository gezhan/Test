//
//  WSFActivityPromptVC.h
//  WinShare
//
//  Created by GZH on 2018/3/2.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFBaseViewController.h"
/**
 商家-活动详情界面的弹出框
 
 使用方法：
 WSFActivityPromptVC *promptVC = [[WSFActivityPromptVC alloc] init];
 promptVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
 promptVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
 promptVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
 [self.navigationController presentViewController:promptVC animated:YES completion:nil];
 */
@interface WSFActivityPromptVC : WSFBaseViewController

@property (nonatomic, assign) NSInteger peopleNumber;

@end
