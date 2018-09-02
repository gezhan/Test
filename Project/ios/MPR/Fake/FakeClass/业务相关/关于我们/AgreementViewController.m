//
//  AgreementViewController.m
//  WinShare
//
//  Created by GZH on 2017/5/8.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURLRequest *fileRequest;


@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"用户协议";
    
    [self setupViewContent];
}

- (void)setupViewContent
{
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height)];
    self.webView.delegate = self;
    self.webView.contentMode = UIViewContentModeScaleAspectFit;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scalesPageToFit = NO;//自动对页面进行缩放以适应屏幕
    self.webView.mediaPlaybackRequiresUserAction = YES;
    
    self.view = self.webView;
    
    NSURL *fileUrl = [[NSURL alloc] init];
//    fileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/service.html", BaseUrl]];
  fileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://xwbxjd.oss-cn-hangzhou.aliyuncs.com/app/user_agreement.html"]];
    self.fileRequest = [NSURLRequest requestWithURL:fileUrl];
    [self.webView loadRequest:self.fileRequest];

}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    @weakify(self);
    BOOL showBool = kNetworkNotReachability;
    [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
        @strongify(self);
        [self.webView loadRequest:self.fileRequest];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
