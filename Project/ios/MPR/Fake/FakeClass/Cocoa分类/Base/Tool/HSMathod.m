//
//  HSMathod.m
//  WinShare
//
//  Created by GZH on 2017/5/5.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "HSMathod.h"
#import "MBProgressHUD.h"


@implementation HSMathod

//获取当前屏幕显示的viewController对象，不需要任何参数
+ (UIViewController *)getCurrentViewController
{
    // 定义一个变量存放当前屏幕显示的viewcontroller
    UIViewController *result = nil;
    
    // 得到当前应用程序的关键窗口（正在活跃的窗口）
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    // windowLevel是在 Z轴 方向上的窗口位置，默认值为UIWindowLevelNormal
    if (window.windowLevel != UIWindowLevelNormal)
    {
        // 获取应用程序所有的窗口
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            // 找到程序的默认窗口（正在显示的窗口）
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                // 将关键窗口赋值为默认窗口
                window = tmpWin;
                break;
            }
        }
    }
    // 获取窗口的当前显示视图
    UIView *frontView = [[window subviews] objectAtIndex:0];
    
    // 获取视图的下一个响应者，UIView视图调用这个方法的返回值为UIViewController或它的父视图
    id nextResponder = [frontView nextResponder];
    
    // 判断显示视图的下一个响应者是否为一个UIViewController的类对象
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

//通过字符串、限定的文本宽，得到文本高
+ (CGFloat)getHightForText:(NSString *)textStr limitWidth:(CGFloat)limitWidth fontSize:(CGFloat)fontSize
{
    CGRect textRect = [textStr boundingRectWithSize:CGSizeMake(limitWidth, MAXFLOAT)
                                            options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}
                                            context:nil];
    return textRect.size.height;
}

//通过字符串、限定的文本高，得到文本宽
+ (CGFloat)getWidthForText:(NSString *)textStr limitHight:(CGFloat)limitHight fontSize:(CGFloat)fontSize
{
    CGRect textRect = [textStr boundingRectWithSize:CGSizeMake(MAXFLOAT, limitHight)
                                            options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                         attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}
                                            context:nil];
    return textRect.size.width;
}

//通过字符串、字体大小，得到单行文本的size
+ (CGSize)getSizeForText:(NSString *)textStr fontSize:(CGFloat)fontSize
{
    CGFloat textH = [self getHightForText:textStr limitWidth:10000 fontSize:fontSize];
    CGFloat textW = [self getWidthForText:textStr limitHight:textH fontSize:fontSize];
    return CGSizeMake(textW, textH);
}

//通过字数、限定的文本宽、字体，得到文本高
+ (CGFloat)getHeightForTextNum:(NSInteger)num limitWidth:(CGFloat)limitWidth fontSize:(CGFloat)fontSize
{
    NSString *str = @"";
    for (int i = 0; i < num; i ++) {
        str = [str stringByAppendingString:@"囧"];
    }
    CGFloat textH = [self getHightForText:str limitWidth:limitWidth fontSize:fontSize];
    return textH;
}

//颜色转换成图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//显示一个等待加载的Gif图片，并返回该view
+ (UIView *)showLoadingGifToView:(UIView *)view
{
    NSData *data = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"jiazai" ofType:@"gif"]];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,110,110)];
    [webView setCenter:view.center];
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    webView.userInteractionEnabled = NO;
    [webView loadData:data MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:nil];
    
    UIView *waitView = [[UIView alloc] initWithFrame:view.frame];
    waitView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    waitView.alpha = 0.7;
    [waitView addSubview:webView];
    
    [view addSubview:waitView];
    
    return waitView;
}

+ (MBProgressHUD *)showLoading:(UIView *)view title:(NSString *)title{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view==nil?[[UIApplication sharedApplication].windows lastObject]:view animated:NO];
    hud.mode = MBProgressHUDModeCustomView;
    hud.minSize = CGSizeMake(110,110);//定义弹窗的大小
    
    UIImage *image = [[UIImage imageNamed:@"loading_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    NSMutableArray *imagesArray = [NSMutableArray array];
    for (int i = 1; i < 28; i++) {
        NSString *imageStr = [NSString stringWithFormat:@"loading_%d", i];
        [imagesArray addObject:[UIImage imageNamed:imageStr]];
    }
    
    UIImageView* mainImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
    mainImageView.image = [image resizingImageState];
    mainImageView.animationImages = imagesArray.copy;
    
    [mainImageView setAnimationDuration:1.0f];
    [mainImageView setAnimationRepeatCount:0];
    [mainImageView startAnimating];
    hud.customView = mainImageView;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.color = [UIColor clearColor];
    
    return hud;
}

// 拨打电话
+ (void)callPhoneWithNumber:(NSString *)telephoneNumber
{
    if (telephoneNumber.length == 0) {
        return;
    }
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", telephoneNumber];
    CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
    if (version >= 10.0) {
        /// 大于等于10.0系统使用此openURL方法
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}

@end
