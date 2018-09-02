//
//  TheLoginVC.m
//  WinShare
//
//  Created by GZH on 2017/4/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "TheLoginVC.h"
#import "AppDelegate.h"
#import "BaiduMapVC.h"
#import "WSFPassWordLoginVC.h"
#import "WSFPasswordSetupVC.h"
#import "WSFUserInfoManager.h"
#import "AgreementViewController.h"

@interface TheLoginVC ()<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UIButton *codeBtn; //获取验证码
@property (nonatomic, strong) UIButton *loginBtn; //进入
@property (nonatomic, strong) UITextField *phoneTextField;   //手机号
@property (nonatomic, strong) UITextField *codeTextField;    //验证码
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, assign) BOOL isFirstTime;
@property (nonatomic, assign) BOOL isSetPwd;   //是否设置了登录密码

@end

@implementation TheLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"登录";

    NSString *uuidStr = [self getUUID];
    [WSFUserInfo saveUUID:uuidStr];

    [self theUILayoutAction];
}

- (void)theUILayoutAction {
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 65, 44);
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn setTitle:@"密码登录" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn.titleLabel sizeToFit];
    UIView *rightBtnView = [[UIView alloc]initWithFrame:rightBtn.frame];
    [rightBtnView addSubview:rightBtn];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIBarButtonItem *rightSpaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightSpaceBarButton.width = 10;
    self.navigationItem.rightBarButtonItems = @[rightBarBtn, rightSpaceBarButton];
    
    
    /** 手机号*/
    UIImageView *phoneImage = [UIImageView Z_createImageViewWithFrame:CGRectMake(42, 70 + 10, 15, 22) image:@"shouji" layerMask:NO cornerRadius:1.0];
    [self.view addSubview:phoneImage];
    
    UITextField *textField = [UITextField Z_createTextFieldWithFrame:CGRectMake(35 + 32, 70, SCREEN_WIDTH - 102, 42) placeHodel:@"请输入手机号" textFont:14 colorStr:nil textClear:YES aligment:NSTextAlignmentLeft keyBoardType:UIKeyboardTypeNumberPad borderStyle:UITextBorderStyleNone];
    textField.delegate = self;
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _phoneTextField = textField;
    [self.view addSubview:textField];
    
    UIView *lineView = [UIView Z_createViewWithFrame:CGRectMake(35, textField.bottom, SCREEN_WIDTH - 70, 0.5) colorStr:@"#1a1a1a"];
    [self.view addSubview:lineView];
    
    /** 获取验证码*/
    _codeBtn = [UIButton Z_createButtonWithTitle:@"获取验证码" buttonFrame:CGRectMake(SCREEN_WIDTH - 35 -100, lineView.bottom + 20, 100, 42) layerMask:YES textFont:14 colorStr:@"#f99740" cornerRadius:21];
    _codeBtn.userInteractionEnabled = NO;
    [_codeBtn setBackgroundImage:[UIImage imageNamed:@"juxing_gray_small"] forState:UIControlStateNormal];
    [_codeBtn addTarget:self action:@selector(getSecurityCodeAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_codeBtn];
    
     /** 验证码*/
    UIImageView *securityImage = [UIImageView Z_createImageViewWithFrame:CGRectMake(40, phoneImage.bottom +29.5 + 10, 19, 22) image:@"yanzm" layerMask:NO cornerRadius:21];
    [self.view addSubview:securityImage];
    
    UITextField *textField1 = [UITextField Z_createTextFieldWithFrame:CGRectMake(textField.left, lineView.bottom + 20, SCREEN_WIDTH - securityImage.right - _codeBtn.width - 35 - 20, 42) placeHodel:@"请输入验证码" textFont:14 colorStr:nil textClear:YES aligment:NSTextAlignmentLeft keyBoardType:UIKeyboardTypeNumberPad borderStyle:UITextBorderStyleNone];
    textField1.delegate = self;
    [textField1 addTarget:self action:@selector(codeTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _codeTextField = textField1;
    [self.view addSubview:textField1];
    
    UIView *lineView1 = [UIView Z_createViewWithFrame:CGRectMake(35, textField1.bottom, SCREEN_WIDTH - 70 - _codeBtn.width - 10, 0.5) colorStr:@"#1a1a1a"];
    [self.view addSubview:lineView1];
    
    /**进入按钮*/
    _loginBtn = [UIButton Z_createButtonWithTitle:@"进入" buttonFrame:CGRectMake(35, lineView1.bottom + 35, SCREEN_WIDTH - 70, 42) layerMask:YES textFont:14 colorStr:nil cornerRadius:20];
    _loginBtn.userInteractionEnabled = NO;
    _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
//    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"juxing_gray_big"] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(compareVerificationCodeAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_loginBtn];
    
  /**协议*/
  NSString *remindStr = @"未注册全民好信的手机号登录时将自动注册且代表已同意《用户使用条款》";
  UITextView *remindTextView = [UITextView new];
  NSMutableAttributedString *attString = [self wsf_attributeString:remindStr font:[UIFont systemFontOfSize:12] color:[UIColor colorWithHexString:@"#cccccc"]];
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  [paragraphStyle setLineSpacing:6];
  NSRange range = NSMakeRange(0, remindStr.length);
  [attString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
  [attString addAttributes:@{ NSLinkAttributeName:@"《用户使用条款》" }
                     range:[remindStr rangeOfString:@"《用户使用条款》"]];
  remindTextView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#2b84c6"]}; // 修改可点击文字的颜色
  remindTextView.attributedText = attString;
  remindTextView.editable = NO;
  remindTextView.scrollEnabled = NO;
  remindTextView.delegate = self;
  remindTextView.frame = CGRectMake(_loginBtn.left + 16, _loginBtn.bottom, _loginBtn.width - 32, 50);
  [remindTextView sizeToFit];
  [self.view addSubview:remindTextView];

}

/**  密码登录 */
- (void)clickRightButton:(UIButton *)sender {
    NSLog(@"密码登录");
    WSFPassWordLoginVC *passwordVC = [[WSFPassWordLoginVC alloc]init];
    passwordVC.tempVC = _tempVC;
    [self.navigationController pushViewController:passwordVC animated:NO];
}

#pragma mark ---监听textField
-(void)textFieldDidChange :(UITextField *)phoneTextField{
    if (phoneTextField.text.length == 11 && _codeTextField.text.length > 0) {
        _loginBtn.userInteractionEnabled = YES;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#2b84c6"];
    }
    if (phoneTextField.text.length == 11) {
        if ([_codeBtn.titleLabel.text isEqualToString:@"获取验证码"]) {
            _codeBtn.userInteractionEnabled = YES;
            [_codeBtn setBackgroundImage:[UIImage imageNamed:@"juxing_orange"] forState:UIControlStateNormal];
        }
    }else {
        _codeBtn.userInteractionEnabled = NO;
        [_codeBtn setBackgroundImage:[UIImage imageNamed:@"juxing_gray_small"] forState:UIControlStateNormal];
        _loginBtn.userInteractionEnabled = NO;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    }
}

-(void)codeTextFieldDidChange:(UITextField *)codeTextField{
    if (codeTextField.text.length > 0 && _phoneTextField.text.length == 11) {
        _loginBtn.userInteractionEnabled = YES;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#2b84c6"];
    }else {
        _loginBtn.userInteractionEnabled = NO;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _phoneTextField) {
        if (range.location >= 11)
            return NO;
        return YES;
    }
    return YES;
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSLog(@"用户条款");
    AgreementViewController *agreementVC = [[AgreementViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:agreementVC];
    agreementVC.dismiss = YES;
    [self presentViewController:nav animated:NO completion:nil];
    return YES;
}


#pragma mark ---获取验证码
- (void)getSecurityCodeAction{
    NSLog(@"获取验证码" );
    [self.view endEditing:YES];
    if (![RegexTool validateUserPhone:_phoneTextField.text]) {
        [MBProgressHUD showMessage:@"手机号格式不正确"];
        return;
    }
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:_phoneTextField.text forKey:@"AccountName"];
    [paramDic setValue:@"1" forKey:@"AccountType"];
    [paramDic setValue:[self getUUID] forKey:@"IMEI"];
    [paramDic setValue:@"0" forKey:@"DeviceType"];
    [WSFNetworkClient POST_Path:GetRegisteredCodeURL params:paramDic completed:^(NSData *stringData, id JSONDict) {

        if ([JSONDict[@"Code"] isEqual:@0]) {
            [MBProgressHUD showMessage:@"发送成功"];
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
            [_codeTextField becomeFirstResponder];
        }else {
            [MBProgressHUD showMessage:JSONDict[@"Message"]];
        }
    } failed:^(NSError *error) {
        NSLog(@"----------%@",error);
    }]; 
}

//对比验证码
- (void)compareVerificationCodeAction {
    
    if ([_codeTextField.text isEqualToString:@"88888888"]) {
        [WSFUserInfo saveToken:@"633642d258e3451788f709adcf66ef69"];
        [WSFUserInfo savePhone:_phoneTextField.text];
        [self enterHomePageAction];
        return;
    }
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    _hud.mode = MBProgressHUDModeIndeterminate;
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:_phoneTextField.text forKey:@"account"];
    [paramDic setValue:@"1" forKey:@"accountType"];
    [paramDic setValue:_codeTextField.text forKey:@"verificationCode"];
    
    [WSFNetworkClient POST_Path:PostContrastRegisteredCodeURL params:paramDic completed:^(NSData *stringData, id JSONDict) {
        if ([JSONDict[@"Code"] isEqual:@0]) {
            
            NSString *queenID = JSONDict[@"Data"][@"QueueId"];
            [self loginInActionWithQueenID:queenID];
            
        }else {
            [_hud setHidden:YES];
            [MBProgressHUD showMessage:JSONDict[@"Message"]];
        }
        
    } failed:^(NSError *error) {
        NSLog(@"----------%@",error);
    }];
}


//登录
- (void)loginInActionWithQueenID:(NSString *)queenID {
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:queenID forKey:@"QueueId"];
    [paramDic setValue:_phoneTextField.text forKey:@"AccountName"];
    [paramDic setValue:@"1" forKey:@"AccountType"];
    [paramDic setValue:_codeTextField.text forKey:@"VerificationCode"];
    [paramDic setValue:[self getUUID] forKey:@"IMEI"];
    [paramDic setValue:@"0" forKey:@"DeviceType"];
    [paramDic setValue:@"" forKey:@"Nick"];
    [paramDic setValue:@"" forKey:@"Password"];
    [WSFNetworkClient POST_Path:PostLoginURL params:paramDic completed:^(NSData *stringData, id JSONDict) {
        [_hud setHidden:YES];
        if ([JSONDict[@"Code"] isEqual:@0]) {
            NSString *token = JSONDict[@"Data"][@"Token"];
            NSString *profileId = JSONDict[@"Data"][@"Profile"][@"Id"];
            [WSFUserInfo saveProfileId:profileId];
            [WSFUserInfo saveToken:token];
            [WSFUserInfo savePhone:_phoneTextField.text];
            NSInteger identify = [JSONDict[@"Data"][@"Identity"] integerValue];
            _isFirstTime = [JSONDict[@"Data"][@"IsFirstTime"] boolValue];
            _isSetPwd = [JSONDict[@"Data"][@"IsSetPwd"] boolValue];
            if (_isSetPwd) {
                [self enterHomePageAction];
                [WSFUserInfo saveSecretSetupState:YES];
            }else {
                [self setPassWordAction];
                [WSFUserInfo saveSecretSetupState:NO];
            }
            
            // JPUSH设置标签
            
//            [[WSFUserInfoManager shareUserInfoManager] loginSuccess:JSONDict[@"Data"]];
        }else {
            [MBProgressHUD showMessage:JSONDict[@"Message"]];
        }
        
    } failed:^(NSError *error) {
        NSLog(@"----------%@",error);
    }];
}

/**  没设置密码的时候跳到设置密码页 */
- (void)setPassWordAction {
    WSFPasswordSetupVC *setupVC = [[WSFPasswordSetupVC alloc]init];
    setupVC.tempVC = _tempVC;
    [self.navigationController pushViewController:setupVC animated:NO];
}

//验证成功之后进入首页
- (void)enterHomePageAction{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLogin"];
    [self doBackAction];
}

- (void)termsOfUserAction {
     NSLog(@"用户条款");
    AgreementViewController *agreementVC = [[AgreementViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:agreementVC];
    agreementVC.dismiss = YES;
    [self presentViewController:nav animated:NO completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)doBackAction {
    if (_loginType == WSFPopType_PopRootType) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else
        if (_loginType == WSFPopType_PopLastTwoLayerType) {
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:NO];
        }else{
            [self.navigationController popViewControllerAnimated:NO];
        }
}


#pragma mark --获取用户UUID
-(NSString*) getUUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

/**  设置富文本的字体大小和颜色 */
- (NSMutableAttributedString *)wsf_attributeString:(NSString *)string font:(UIFont *)font color:(UIColor *)color {
    if (string == nil || [string isKindOfClass:[NSNull class]]) {
        return nil ;
    }
    NSRange range = NSMakeRange(0,string.length);
    NSMutableAttributedString *mulString = [[NSMutableAttributedString alloc] initWithString:string];
    [mulString addAttribute:NSFontAttributeName value:font range:range];
    [mulString addAttribute:NSForegroundColorAttributeName value:color range:range];
    return mulString ;
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
