//
//  WSFPassWordLoginVC.m
//  WinShare
//
//  Created by GZH on 2018/1/10.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFPassWordLoginVC.h"
#import "WSFPassWordLoginApi.h"
#import "WSFUserInfoManager.h"

@interface WSFPassWordLoginVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *loginBtn; //进入
@property (nonatomic, strong) UITextField *phoneTextField;   //手机号
@property (nonatomic, strong) UITextField *codeTextField;    //验证码
@end

@implementation WSFPassWordLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
}

- (void)setContentView {
    self.navigationItem.title = @"密码登录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    /** 手机号*/
    UIImageView *phoneImage = [UIImageView Z_createImageViewWithFrame:CGRectMake(42, 70 + 10, 15, 22) image:@"shouji" layerMask:NO cornerRadius:1.0];
    [self.view addSubview:phoneImage];
    UITextField *textField = [UITextField Z_createTextFieldWithFrame:CGRectMake(35 + 32, 70, SCREEN_WIDTH - 102, 42) placeHodel:@"请输入手机号" textFont:14 colorStr:nil textClear:YES aligment:NSTextAlignmentLeft keyBoardType:UIKeyboardTypeNumberPad borderStyle:UITextBorderStyleNone];
    textField.delegate = self;
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _phoneTextField = textField;
    [textField becomeFirstResponder];
    [self.view addSubview:textField];
    UIView *lineView = [UIView Z_createViewWithFrame:CGRectMake(35, textField.bottom, SCREEN_WIDTH - 70, 0.5) colorStr:@"#1a1a1a"];
    [self.view addSubview:lineView];
    
    /** 验证码*/
    UIImageView *securityImage = [UIImageView Z_createImageViewWithFrame:CGRectMake(40, phoneImage.bottom +29.5 + 10, 19, 22) image:@"yanzm" layerMask:NO cornerRadius:21];
    [self.view addSubview:securityImage];
    UITextField *textField1 = [UITextField Z_createTextFieldWithFrame:CGRectMake(textField.left, lineView.bottom + 20, textField.width, 42) placeHodel:@"请输入密码" textFont:14 colorStr:nil textClear:YES aligment:NSTextAlignmentLeft keyBoardType:UIKeyboardTypeDefault borderStyle:UITextBorderStyleNone];
    textField1.delegate = self;
    textField1.secureTextEntry = YES;
    [textField1 addTarget:self action:@selector(codeTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _codeTextField = textField1;
    [self.view addSubview:textField1];
    
    UIView *lineView1 = [UIView Z_createViewWithFrame:CGRectMake(35, textField1.bottom, lineView.width, 0.5) colorStr:@"#1a1a1a"];
    [self.view addSubview:lineView1];
    
    /**进入按钮*/
    _loginBtn = [UIButton Z_createButtonWithTitle:@"进入" buttonFrame:CGRectMake(35, lineView1.bottom + 35, SCREEN_WIDTH - 70, 42) layerMask:YES textFont:14 colorStr:nil cornerRadius:20];
    _loginBtn.userInteractionEnabled = NO;
    _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_loginBtn];

    
}

#pragma mark ---进入按钮
- (void)loginAction {
    //判断手机号格式是否正确
    if (![RegexTool validateUserPhone:_phoneTextField.text]) {
        [MBProgressHUD showMessage:@"手机号格式不正确"];
        return;
    }
    //判断密码格式是否符合要求
    if (![RegexTool judgePassWordLegal:_codeTextField.text]) {
        [MBProgressHUD showMessage:@"密码格式不符合要求"];
        return;
    }
    [self secretLoginAction];
}

/**  密码登录 */
- (void)secretLoginAction {
  WSFPassWordLoginApi *loginApi = [[WSFPassWordLoginApi alloc]initWithTheaccountName:_phoneTextField.text pwd:_codeTextField.text];
  [loginApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
    NSData *jsonData = [request.responseObject dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    if ([messageDic[@"Code"] isEqual:@0]) {
      NSString *token = messageDic[@"Data"][@"Token"];
      NSString *profileId = messageDic[@"Data"][@"Profile"][@"Id"];
      [WSFUserInfo saveToken:token];
      [WSFUserInfo saveProfileId:profileId];
      [WSFUserInfo savePhone:_phoneTextField.text];
      NSInteger identify = [messageDic[@"Data"][@"Identity"] integerValue];
      [WSFUserInfo saveIdentify:identify];
      [WSFUserInfo saveSecretSetupState:YES];
      [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLogin"];

      
      if (_tempVC) {
        [self.navigationController popToViewController:_tempVC animated:NO];
      }else {
        [self.navigationController popToRootViewControllerAnimated:NO];
      }
    }else {
      [MBProgressHUD showMessage:request.responseObject[@"Message"]];
    }
  } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
    
  }];
}

#pragma mark ---监听textField
-(void)textFieldDidChange :(UITextField *)phoneTextField{
    if (phoneTextField.text.length == 11 && _codeTextField.text.length > 0) {
        _loginBtn.userInteractionEnabled = YES;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#2b84c6"];
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
    }else
        if (textField == _codeTextField) {
            if (range.location >= 16)
                return NO;
            return YES;
        }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
