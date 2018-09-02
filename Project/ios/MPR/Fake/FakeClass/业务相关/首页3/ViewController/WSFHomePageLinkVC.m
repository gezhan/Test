//
//  WSFHomePageLinkVC.m
//  WinShare
//
//  Created by GZH on 2018/1/29.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFHomePageLinkVC.h"

@interface WSFHomePageLinkVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURLRequest *fileRequest;

@end

@implementation WSFHomePageLinkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationItem.title = @"";
    
    [self setupViewContent];
}


- (void)setupViewContent {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height)];
    self.webView.delegate = self;
    self.webView.contentMode = UIViewContentModeScaleAspectFit;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scalesPageToFit = NO;
    self.webView.mediaPlaybackRequiresUserAction = YES;
    self.view = self.webView;
    NSURL *fileUrl = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@", self.requestURL]];
    self.fileRequest = [NSURLRequest requestWithURL:fileUrl];
    [self.webView loadRequest:self.fileRequest];
    
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    BOOL showBool = kNetworkNotReachability;
    [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
        [self.webView loadRequest:self.fileRequest];
    }];
}

#pragma mark - 懒加载


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
