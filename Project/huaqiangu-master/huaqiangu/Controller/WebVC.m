//
//  WebVC.m
//  huaqiangu
//
//  Created by JasonG on 2017/6/12.
//  Copyright © 2017年 Jiangwei. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, self.view.frame.origin.y, mainscreenwidth, mainscreenhight - self.view.frame.origin.y)];
    
    self.webV.scalesPageToFit = YES;

    [self.view addSubview:self.webV];
    
    [self.webV setScalesPageToFit:YES];
    
    self.navigationItem.titleView = [CommUtils navTittle:@"全民免息"];
    
    self.navigationItem.leftBarButtonItem = [LMButton setNavleftButtonWithImg:@"back" andSelector:@selector(backAction) andTarget:self];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    self.webV.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self.webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:AdLink]]];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
}



#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
//    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}


-(void)backAction{
    LM_POP;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
