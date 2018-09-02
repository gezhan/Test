//
//  WSFBaseViewController.m
//  WinShare
//
//  Created by QIjikj on 2018/1/25.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFBaseViewController.h"

@interface WSFBaseViewController ()

@end

@implementation WSFBaseViewController

- (instancetype)init
{
    if (self = [super init]) {
        
        //在TabBar嵌套Nav时，该属性如果为yes，当这个控制器push的时候，底部的Bar，比如TabBar会滑走，也就是不会在push后的视图上显示出来，默认值为NO。
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //导航栏背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"background_blue_top"] forBarMetrics:UIBarMetricsDefault];
    
    //导航栏标题的字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
    
    //消除导航栏底部横线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    //左返回按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn setImage:[UIImage imageNamed:@"Arrow-white"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(doBackAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *leftBtnView = [[UIView alloc]initWithFrame:leftBtn.frame];
    [leftBtnView addSubview:leftBtn];
    UIBarButtonItem * leftBarbutton = [[UIBarButtonItem alloc]initWithCustomView:leftBtnView];
    
    UIBarButtonItem *leftSpaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftSpaceBarButton.width = -10;
    
    self.navigationItem.leftBarButtonItems = @[leftSpaceBarButton, leftBarbutton];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 在此决定是否开启左侧侧滑返回功能
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        self.navigationController.interactivePopGestureRecognizer.enabled = self.navigationController.viewControllers.count - 1;
    }
}

-(void)doBackAction
{
    if (self.dismiss) {
        [self dismissViewControllerAnimated:NO completion:nil];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (UIAlertController *)alertVC {
    if (!_alertVC) {
        _alertVC = [UIAlertController alertControllerWithTitle:@"定位服务未开启" message:@"请进入系统「设置」>>「隐藏」>>「定位功能」中打开开关，并允许全民好信使用定位服务" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [_alertVC addAction:cancleAction];
        UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"立即开启" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSURL * url = [NSURL URLWithString: UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        [_alertVC addAction:settingAction];
    }
    return _alertVC;
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"[%@ dealloc]", [self class]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
