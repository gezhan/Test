//
//  WSFPersonalSetUpVC.m
//  WinShare
//
//  Created by GZH on 2018/1/9.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFPersonalSetUpVC.h"
#import "WSFPersonalIdentityVC.h"
#import "TheLoginVC.h"
#import "WSFHomePageVC.h"

@interface WSFPersonalSetUpVC ()
@property (nonatomic, strong) UIView *upBackView; //上边的一条白色View
@property (nonatomic, strong) UIView *downBackView; //上边的一条白色View
@property (nonatomic, strong) UILabel *phoneNumberLabel; //手机号码的label
@property (nonatomic, strong) UILabel *setupLabel; //是否设置的Label
@property (nonatomic, strong) UIButton *exitBtn;//退出按钮
@end

@implementation WSFPersonalSetUpVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([WSFUserInfo getSecretSetupState]) {
        _setupLabel.text = @"已设置";
        _setupLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
    }else {
        _setupLabel.text = @"未设置";
        _setupLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
}

- (void)setContentView {
    self.navigationItem.title = @"个人设置";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    self.upBackView.hidden = NO;
    self.downBackView.hidden = NO;
    self.exitBtn.hidden = NO;
}


- (UIView *)upBackView {
    if (_upBackView == nil) {
        _upBackView = [[UIView alloc]init];
        _upBackView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [self.view addSubview:_upBackView];
        [_upBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(15);
            make.left.right.equalTo(self.view);
            make.height.equalTo(@49);
        }];
        UILabel *phoneLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:@"手机号" textFont:16 colorStr:@"#1a1a1a" aligment:NSTextAlignmentLeft];
        [phoneLabel sizeToFit];
        [_upBackView addSubview:phoneLabel];
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_upBackView).offset(12);
            make.top.equalTo(_upBackView.mas_top).offset((49-phoneLabel.height)/2);
        }];
        
        UILabel *phoneNumberLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:[WSFUserInfo getPhone] textFont:16 colorStr:@"#cccccc" aligment:NSTextAlignmentRight];
        _phoneNumberLabel = phoneNumberLabel;
        [phoneNumberLabel sizeToFit];
        [_upBackView addSubview:phoneNumberLabel];
        [phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_upBackView).offset(-12);
            make.top.equalTo(_upBackView.mas_top).offset((49-phoneNumberLabel.height)/2);
        }];
    }
    return _upBackView;
}


- (UIView *)downBackView {
    if (_downBackView == nil) {
        _downBackView = [[UIView alloc]init];
        _downBackView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [self.view addSubview:_downBackView];
        [_downBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_upBackView.mas_bottom).offset(15);
            make.left.right.equalTo(self.view);
            make.height.equalTo(@49);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(identityValidation)];
        [_downBackView addGestureRecognizer:tap];
        
        UILabel *phoneLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:@"密码管理" textFont:16 colorStr:@"#1a1a1a" aligment:NSTextAlignmentLeft];
        [phoneLabel sizeToFit];
        [_downBackView addSubview:phoneLabel];
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_downBackView).offset(12);
            make.top.equalTo(_downBackView.mas_top).offset((49 - phoneLabel.height)/2);
        }];
        
        UIImageView *image = [UIImageView Z_createImageViewWithFrame:CGRectZero image:@"xiangyou" layerMask:NO cornerRadius:0.0];
        [_downBackView addSubview:image];
        [image sizeToFit];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_downBackView).offset(-12);
            make.top.equalTo(@((49-image.height)/2));
        }];
        
        
        UILabel *setupLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:@"已设置" textFont:16 colorStr:@"#1a1a1a" aligment:NSTextAlignmentRight];
        _setupLabel = setupLabel;
        [setupLabel sizeToFit];
        [_downBackView addSubview:setupLabel];
        [setupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(image).offset(-12);
            make.top.equalTo(_downBackView.mas_top).offset((49-setupLabel.height)/2);
        }];
        
    }
    return _downBackView;
}

- (UIButton *)exitBtn {
    if (_exitBtn == nil) {
        _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_exitBtn setFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
        [_exitBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithHexString:@"#2b84c6"]] forState:UIControlStateNormal];
        [_exitBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithHexString:@"#cccccc"]] forState:UIControlStateSelected];
        [_exitBtn setTitle:@"退出账号" forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(exitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_exitBtn];
        [_exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.height.equalTo(@50);
        }];
    }
    return _exitBtn;
}


/**  退出 */
- (void)exitBtnAction {
    SureOrCancleVC *sureVC = [[SureOrCancleVC alloc] init];
    __weak typeof(self) weakSelf = self;
    sureVC.clickSureBlock = ^(void) {
        [weakSelf exitAction];
    };
    sureVC.titleStr = @"是否确定退出当前账号?";
    sureVC.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    //淡出淡入
    sureVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    sureVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [self.navigationController presentViewController:sureVC animated:NO completion:nil];
}

/**  跳到身份验证 */
- (void)identityValidation {
    WSFPersonalIdentityVC *identityVC = [[WSFPersonalIdentityVC alloc]init];
    [self.navigationController pushViewController:identityVC animated:NO];
}

- (void)exitAction {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"everLogin"];
    TheLoginVC *loginVC = [[TheLoginVC alloc]init];
    NSArray *controllerArray = self.navigationController.viewControllers;
    if (controllerArray.count > 2 && [[controllerArray objectAtIndex:controllerArray.count - 3] isKindOfClass:[WSFHomePageVC class]]) {
        loginVC.loginType = WSFPopType_PopRootType;
    }else {
        loginVC.loginType = WSFPopType_PopLastTwoLayerType;
    }
    [self.navigationController pushViewController:loginVC animated:NO];

    
    /**  清除缓存数据 */
    [WSFUserInfo emptyDataAction];
    
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
