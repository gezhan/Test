//
//  WSFActivityEditVC.m
//  WinShare
//
//  Created by GZH on 2018/2/27.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityEditVC.h"
#import "WSFActivityEditTV.h"

@interface WSFActivityEditVC ()
@property (nonatomic, strong) UIButton *submitButton;      //提交按钮
@property (nonatomic, strong) WSFActivityEditTV *editTV;  //tableView
@end

@implementation WSFActivityEditVC

#pragma mark  --懒加载--
- (WSFActivityEditTV *)editTV {
    if (_editTV == nil) {
        _editTV = [[WSFActivityEditTV alloc]init];
        [self.view addSubview:_editTV];
        [_editTV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.mas_equalTo(_submitButton.mas_top);
        }];
    }
    return _editTV;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [[UIButton alloc] init];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        _submitButton.backgroundColor = HEX_COLOR_0x2B84C6;
        [self.view addSubview:_submitButton];
        [_submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.height.equalTo(@50);
        }];
    }
    return _submitButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupContentView];
}

- (void)setupContentView {
    self.navigationItem.title = @"编辑活动";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    self.submitButton.hidden = NO;
    self.editTV.hidden = NO;
}

- (void)submitAction {
    NSLog(@"------提交" );
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
