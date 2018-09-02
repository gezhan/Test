//
//  WSFActivityIntroduceListVC.m
//  WinShare
//
//  Created by QIjikj on 2018/2/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityIntroduceListVC.h"
#import "WSFActivityIntroduceAddVC.h"
#import "WSFActivityIntroduceListTView.h"
#import "WSFActivityIntroduceListTVM.h"

@interface WSFActivityIntroduceListVC ()
@property (nonatomic, strong) WSFActivityIntroduceListTView *activityIntroduceListTView;
@end

@implementation WSFActivityIntroduceListVC

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationContent];
    
    [self setupViewContent];
    
    [self setupDataFromSVR];
    
}

#pragma mark - 请求网络数据
- (void)setupDataFromSVR {
    WSFActivityIntroduceListTVM *activityIntroduceListTVM = [[WSFActivityIntroduceListTVM alloc] initWithNULL];
    self.activityIntroduceListTView.activityIntroduceListTVM = activityIntroduceListTVM;
}

#pragma mark - 界面搭建
- (void)setupNavigationContent {
    self.navigationItem.title = @"活动介绍";
    
    //right按钮
    // 新增介绍
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 44);
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn setTitle:@"新增活动" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:SYSTEMFONT_12];
    [rightBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *rightBtnView = [[UIView alloc]initWithFrame:rightBtn.frame];
    [rightBtnView addSubview:rightBtn];
    UIBarButtonItem * rightBarbutton = [[UIBarButtonItem alloc]initWithCustomView:rightBtnView];
    
    // 占位
    UIBarButtonItem *rightSpaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightSpaceBarButton.width = -10;
    
    self.navigationItem.rightBarButtonItems = @[rightSpaceBarButton, rightBarbutton];
}

- (void)setupViewContent {
    [self.view addSubview:self.activityIntroduceListTView];
}

#pragma mark - 懒加载
- (WSFActivityIntroduceListTView *)activityIntroduceListTView {
    if (!_activityIntroduceListTView) {
        _activityIntroduceListTView = [[WSFActivityIntroduceListTView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    }
    return _activityIntroduceListTView;
}

#pragma mark - 点击事件
- (void)clickRightButton:(UIButton *)btn {
    WSFActivityIntroduceAddVC *activityAddVC = [[WSFActivityIntroduceAddVC alloc] init];
    [self.navigationController pushViewController:activityAddVC animated:NO];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
