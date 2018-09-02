//
//  WSFPersonalIdentityVC.m
//  WinShare
//
//  Created by GZH on 2018/1/9.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFPersonalIdentityVC.h"
#import "WSFPersonalSecretVC.h"

@interface WSFPersonalIdentityVC ()
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIButton *loginBtn;
/**  手机号 */
@property (nonatomic, strong) NSString *phoneNumber;
/**  验证码发送成功返回ResetID */
@property (nonatomic, strong) NSString *resetId;
@end

@implementation WSFPersonalIdentityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
    
    //获取验证码
    [self getSecurityCodeAction];
}

- (void)setContentView {
    self.navigationItem.title = @"身份验证";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    _phoneNumber = [WSFUserInfo getPhone];
    
    /** 手机号*/
    NSString *tempTitle = [NSString stringWithFormat:@"验证码已发送到手机%@", _phoneNumber];
    UILabel *promptLabel = [UILabel Z_createLabelWithFrame:CGRectMake(35, 70 + 10, SCREEN_WIDTH - 84, 22) title:tempTitle textFont:13 colorStr:@"#1a1a1a" aligment:NSTextAlignmentLeft];
    promptLabel.attributedText = [self adjustOriginalString:promptLabel.text frontStringColor:[UIColor colorWithHexString:@"#808080"] frontStringFont:13 behindString:_phoneNumber];
    [self.view addSubview:promptLabel];
    
    /** 获取验证码*/
    UIButton *codeBtn = [UIButton Z_createButtonWithTitle:@"获取验证码" buttonFrame:CGRectMake(SCREEN_WIDTH - 35 -100, 70 + 42 + 0.5 + 20, 100, 42) layerMask:YES textFont:14 colorStr:@"#f99740" cornerRadius:21];
    _codeBtn = codeBtn;
    [codeBtn setBackgroundImage:[UIImage imageNamed:@"juxing_gray_small"] forState:UIControlStateNormal];
    [codeBtn addTarget:self action:@selector(getSecurityCodeAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:codeBtn];
    
    /** 验证码*/
    UIImageView *securityImage = [UIImageView Z_createImageViewWithFrame:CGRectMake(40, promptLabel.bottom +29.5 + 10, 19, 22) image:@"yanzm" layerMask:NO cornerRadius:21];
    [self.view addSubview:securityImage];
    
    UITextField *textField = [UITextField Z_createTextFieldWithFrame:CGRectMake(35 + 32, codeBtn.top, SCREEN_WIDTH - securityImage.right - codeBtn.width - 35 - 20, 42) placeHodel:@"请输入验证码" textFont:14 colorStr:nil textClear:YES aligment:NSTextAlignmentLeft keyBoardType:UIKeyboardTypeNumberPad borderStyle:UITextBorderStyleNone];
    _textField = textField;
    [textField addTarget:self action:@selector(codeTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [textField becomeFirstResponder];
    [self.view addSubview:textField];
    
    UIView *lineView1 = [UIView Z_createViewWithFrame:CGRectMake(35, textField.bottom, SCREEN_WIDTH - 70 - codeBtn.width - 10, 0.5) colorStr:@"#1a1a1a"];
    [self.view addSubview:lineView1];
    
    /**确定按钮*/
    UIButton *loginBtn = [UIButton Z_createButtonWithTitle:@"确定" buttonFrame:CGRectMake(35, lineView1.bottom + 35, SCREEN_WIDTH - 70, 42) layerMask:YES textFont:14 colorStr:nil cornerRadius:20];
    _loginBtn = loginBtn;
    loginBtn.userInteractionEnabled = NO;
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [loginBtn addTarget:self action:@selector(compareVerificationCodeAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:loginBtn];
}

/**  获取验证码 */
- (void)getSecurityCodeAction {
    [self.view endEditing:YES];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:_phoneNumber forKey:@"AccountName"];
    [paramDic setValue:@"1" forKey:@"AccountType"];
    [paramDic setValue:[WSFUserInfo getUUID] forKey:@"IMEI"];
    [paramDic setValue:@"0" forKey:@"DeviceType"];
    [WSFNetworkClient POST_Path:PostSecretRegisteredCodeURL params:paramDic completed:^(NSData *stringData, id JSONDict) {
        if ([JSONDict[@"Code"] isEqual:@0]) {
            _resetId = JSONDict[@"Data"];
            [MBProgressHUD showMessage:@"发送成功"];
            [self timeDown];
        }else {
            [MBProgressHUD showMessage:JSONDict[@"Message"]];
        }
    } failed:^(NSError *error) {
        NSLog(@"----------%@",error);
    }];
}

/**  时间的倒计时 */
- (void)timeDown {
    [CountDownServer startCountDown:60 andStateOneing:^(NSString *btnTitle) {
        //倒计时正在进行时
        _codeBtn.userInteractionEnabled = NO;
        [_codeBtn setTitle:btnTitle forState:UIControlStateNormal];
        [_codeBtn setBackgroundImage:[UIImage imageNamed:@"juxing_gray_small"] forState:UIControlStateNormal];
    } stateTwocompleted:^{
        //倒计时完成
        _codeBtn.userInteractionEnabled = YES;
        [_codeBtn setBackgroundImage:[UIImage imageNamed:@"juxing_orange"] forState:UIControlStateNormal];
        [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }];
}

//对比验证码
- (void)compareVerificationCodeAction {
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:_resetId forKey:@"ResetId"];
    [paramDic setValue:_textField.text forKey:@"Code"];
    [WSFNetworkClient POST_Path:PostSecretContrastRegisteredCodeURL params:paramDic completed:^(NSData *stringData, id JSONDict) {
        if ([JSONDict[@"Code"] isEqual:@0]) {
            [_hud setHidden:YES];
            [self setupNewPassword];
        }else {
            [_hud setHidden:YES];
            [MBProgressHUD showMessage:JSONDict[@"Message"]];
        }
    } failed:^(NSError *error) {
         [_hud setHidden:YES];
        NSLog(@"----------%@",error);
    }];
}

//设置新密码
- (void)setupNewPassword {
    WSFPersonalSecretVC *secretVC = [[WSFPersonalSecretVC alloc]init];
    [self.navigationController pushViewController:secretVC animated:NO];
}

-(void)codeTextFieldDidChange:(UITextField *)codeTextField{
    if (codeTextField.text.length > 0) {
        _loginBtn.userInteractionEnabled = YES;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#2b84c6"];
    }else {
        _loginBtn.userInteractionEnabled = NO;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    }
}

//发送电话号码的富文本
- (NSMutableAttributedString *)adjustOriginalString:(NSString *)string
                                   frontStringColor:(UIColor *)frontColor
                                    frontStringFont:(CGFloat)frontFont
                                       behindString:(NSString *)behindString {
    //富文本前边部分的长度
    CGFloat frontstringLength = string.length - behindString.length;
    //富文本前边部分的设置
    NSMutableAttributedString *richText = [[NSMutableAttributedString alloc]initWithString:string];
    [richText addAttribute:NSFontAttributeName
                     value:[UIFont systemFontOfSize:frontFont]
                     range:NSMakeRange(0, frontstringLength)];
    [richText addAttribute:NSForegroundColorAttributeName
                     value:frontColor
                     range:NSMakeRange(0, frontstringLength)];
    return richText;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:NO];
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
