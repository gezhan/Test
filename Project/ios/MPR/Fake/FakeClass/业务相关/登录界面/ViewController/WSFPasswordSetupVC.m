//
//  WSFPasswordSetupVC.m
//  WinShare
//
//  Created by GZH on 2018/1/10.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFPasswordSetupVC.h"
#import "WSFPassWordSetupApi.h"
#import "WSFUserInfoManager.h"

@interface WSFPasswordSetupVC ()
@property (nonatomic, strong) UIButton *codeBtn; //获取验证码
@property (nonatomic, strong) UIButton *loginBtn; //进入
@property (nonatomic, strong) UITextField *textField;;   //手机号
@property (nonatomic, strong) UITextField *textField1;    //验证码
@end

@implementation WSFPasswordSetupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContentView];
}

- (void)setContentView {
    self.navigationItem.title = @"设置登录密码";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [rightBtn setTitle:@"跳过" forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn sizeToFit];
//    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = barBut;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 65, 44);
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font    = [UIFont systemFontOfSize:14];
    [rightBtn.titleLabel sizeToFit];
    UIView *rightBtnView = [[UIView alloc]initWithFrame:rightBtn.frame];
    [rightBtnView addSubview:rightBtn];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIBarButtonItem *rightSpaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightSpaceBarButton.width = 10;
    self.navigationItem.rightBarButtonItems = @[rightBarBtn, rightSpaceBarButton];
    
    /** 输入密码*/
    UIImageView *phoneImage = [UIImageView Z_createImageViewWithFrame:CGRectMake(40, 70 + 10, 19, 22) image:@"yanzm" layerMask:NO cornerRadius:1.0];
    [self.view addSubview:phoneImage];
    
    UITextField *textField = [UITextField Z_createTextFieldWithFrame:CGRectMake(35 + 32, 70, SCREEN_WIDTH - 102, 42) placeHodel:@"6-16位数字和字母组合的密码" textFont:14 colorStr:nil textClear:YES aligment:NSTextAlignmentLeft keyBoardType:UIKeyboardTypeDefault borderStyle:UITextBorderStyleNone];
    [textField becomeFirstResponder];
    textField.secureTextEntry = YES;
    [textField addTarget:self action:@selector(codeTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _textField = textField;
    [self.view addSubview:textField];
    
    UIView *lineView = [UIView Z_createViewWithFrame:CGRectMake(35, textField.bottom, SCREEN_WIDTH - 70, 0.5) colorStr:@"#1a1a1a"];
    [self.view addSubview:lineView];
    
    /** 确认密码 */
    UIImageView *securityImage = [UIImageView Z_createImageViewWithFrame:CGRectMake(40, phoneImage.bottom +29.5 + 10, 19, 22) image:@"yanzm" layerMask:NO cornerRadius:21];
    [self.view addSubview:securityImage];
    
    UITextField *textField1 = [UITextField Z_createTextFieldWithFrame:CGRectMake(textField.left, lineView.bottom + 20, textField.width, 42) placeHodel:@"确认密码" textFont:14 colorStr:nil textClear:YES aligment:NSTextAlignmentLeft keyBoardType:UIKeyboardTypeDefault borderStyle:UITextBorderStyleNone];
    textField1.secureTextEntry = YES;
    [textField1 addTarget:self action:@selector(codeTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _textField1 = textField1;
    [self.view addSubview:textField1];
    
    UIView *lineView1 = [UIView Z_createViewWithFrame:CGRectMake(35, textField1.bottom, lineView.width, 0.5) colorStr:@"#1a1a1a"];
    [self.view addSubview:lineView1];
    
    /**确定按钮*/
    _loginBtn = [UIButton Z_createButtonWithTitle:@"确定" buttonFrame:CGRectMake(35, lineView1.bottom + 35, SCREEN_WIDTH - 70, 42) layerMask:YES textFont:14 colorStr:nil cornerRadius:20];
    _loginBtn.userInteractionEnabled = NO;
    _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    [_loginBtn addTarget:self action:@selector(beSureAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_loginBtn];
}

/**  跳过 */
- (void)clickRightButton:(UIButton *)sender {
    NSLog(@"跳过");
    [WSFUserInfo saveSecretSetupState:NO];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLogin"];
    if (_tempVC) {
        [self.navigationController popToViewController:_tempVC animated:NO];
    }else {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

/**  确定按钮 */
- (void)beSureAction {
    //判断第一个输入框的密码格式是否符合要求
    if (![RegexTool judgePassWordLegal:_textField.text]) {
        [MBProgressHUD showMessage:@"密码格式不符合要求"];
        return;
    }
    //判断两次密码输入是否一致
    if (![_textField.text isEqualToString:_textField1.text]) {
        [MBProgressHUD showMessage:@"两次密码输入不一致"];
        return;
    }
    [self modifySecretAction];
}

/**  设置密码 */
- (void)modifySecretAction {
    WSFPassWordSetupApi *pWSetupApi = [[WSFPassWordSetupApi alloc]initWithTheNewPwd:_textField.text];
    [pWSetupApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
      NSData *jsonData = [request.responseObject dataUsingEncoding:NSUTF8StringEncoding];
      NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        if ([request.responseObject[@"Code"] isEqual:@0]) {
            [WSFUserInfo saveSecretSetupState:YES];
            [self clickRightButton:nil];
            [MBProgressHUD showMessage:messageDic[@"Data"]];
        }else {
            [MBProgressHUD showMessage:messageDic[@"Message"]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

/**  按钮是否亮起的判断 */
-(void)codeTextFieldDidChange:(UITextField *)codeTextField{
    if (_textField.text.length > 0 && _textField1.text.length > 0) {
        _loginBtn.userInteractionEnabled = YES;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#2b84c6"];
    }else {
        _loginBtn.userInteractionEnabled = NO;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
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
