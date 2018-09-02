//
//  WSFActivitySignUpVC.m
//  WinShare
//
//  Created by QIjikj on 2018/2/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivitySignUpVC.h"
#import "WSFActivityApplyApi.h"
//#import "WSFOrderDetailActivityVC.h"

@interface WSFActivitySignUpVC ()
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@end

@implementation WSFActivitySignUpVC

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"填写报名信息";
    self.view.backgroundColor = HEX_COLOR_0xF5F5F5;
    
    [self setupViewContent];
    
}


#pragma mark - 基础界面搭建
- (void)setupViewContent {
    
    self.priceLabel.text = [NSString stringWithFormat:@"活动价格：¥%lf", self.activityPrice];
    
    //
    UIView *nameBgView = [[UIView alloc] init];
    nameBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameBgView];
    [nameBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.top.mas_equalTo(self.priceLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    
    UILabel *nameTipLabel = [[UILabel alloc] init];
    nameTipLabel.text = @"联系姓名";
    nameTipLabel.font = SYSTEMFONT_14;
    nameTipLabel.textColor = HEX_COLOR_0x1A1A1A;
    [nameBgView addSubview:nameTipLabel];
    [nameTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameBgView.mas_left).offset(10);
        make.centerY.mas_equalTo(nameBgView.mas_centerY).offset(0);
    }];
    
    //
    UIView *phonoBgView = [[UIView alloc] init];
    phonoBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phonoBgView];
    [phonoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.top.mas_equalTo(nameBgView.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    
    UILabel *phonoTipLabel = [[UILabel alloc] init];
    phonoTipLabel.text = @"联系电话";
    phonoTipLabel.font = SYSTEMFONT_14;
    phonoTipLabel.textColor = HEX_COLOR_0x1A1A1A;
    [phonoBgView addSubview:phonoTipLabel];
    [phonoTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phonoBgView.mas_left).offset(10);
        make.centerY.mas_equalTo(phonoBgView.mas_centerY);
    }];
    
    //
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setBackgroundColor:HEX_COLOR_0x2B84C6];
    bottomBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 50 - 64, SCREEN_WIDTH, 50);
    
    if (self.activityPrice == 0) {
        [bottomBtn setTitle:@"马上报名" forState:UIControlStateNormal];
    }else {
        [bottomBtn setTitle:@"提交信息并    Z_F" forState:UIControlStateNormal];
    }
    
    [bottomBtn addTarget:self action:@selector(bottomBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    
    //
    self.priceLabel.text = [NSString stringWithFormat:@"活动价格：¥%0.2lf", self.activityPrice];
    
    self.nameTextField.text = @"";
    self.nameTextField.placeholder = @"请输入联系姓名";
    [nameBgView addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameTipLabel.mas_right).offset(10);
        make.right.mas_equalTo(nameBgView.mas_right).offset(-10);
        make.centerY.mas_equalTo(nameBgView.mas_centerY).offset(0);
    }];
    
    self.phoneTextField.text = @"";
    self.phoneTextField.placeholder = @"请输入联系电话";
    [phonoBgView addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phonoTipLabel.mas_right).offset(10);
        make.right.mas_equalTo(phonoBgView.mas_right).offset(-10);
        make.centerY.mas_equalTo(phonoBgView.mas_centerY).offset(0);
    }];
}

#pragma mark - 点击提交信息
- (void)bottomBtnAction {
    
}

#pragma mark - 懒加载
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = SYSTEMFONT_14;
        _priceLabel.textColor = HEX_COLOR_0x1A1A1A;
        [self.view addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(self.view).offset(10);
        }];
    }
    return _priceLabel;
}

- (UITextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc] init];
        _nameTextField.font = SYSTEMFONT_14;
        _nameTextField.textColor = HEX_COLOR_0x1A1A1A;
    }
    return _nameTextField;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] init];
        _phoneTextField.font = SYSTEMFONT_14;
        _phoneTextField.textColor = HEX_COLOR_0x1A1A1A;
    }
    return _phoneTextField;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 强制结束编辑状态
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
