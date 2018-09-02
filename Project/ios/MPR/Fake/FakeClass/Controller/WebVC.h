//
//  WebVC.h
//  huaqiangu
//
//  Created by JasonG on 2017/6/12.
//  Copyright © 2017年 Jiangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface WebVC : UIViewController<NJKWebViewProgressDelegate,UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webV;

@end
