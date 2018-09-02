//
//  WSFActivitySelectSpaceVC.m
//  WinShare
//
//  Created by QIjikj on 2018/2/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivitySelectSpaceVC.h"
#import "WSFActivitySelectSpaceTView.h"
#import "WSFActivitySelectSpaceTVM.h"

@interface WSFActivitySelectSpaceVC ()
@property (nonatomic, strong) WSFActivitySelectSpaceTView *activitySelectSpaceTView;
@property (nonatomic, strong) UIButton *bottomBtn;
@end

@implementation WSFActivitySelectSpaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"举办空间";
    
    [self setupViewContent];
    
    [self loadDataFromSVR];
}

- (void)setupViewContent {
    [self.view addSubview:self.activitySelectSpaceTView];
    
    self.bottomBtn.hidden = NO;
}

- (void)loadDataFromSVR {
    WSFActivitySelectSpaceTVM *tableVM = [[WSFActivitySelectSpaceTVM alloc] initWithNULL];
    self.activitySelectSpaceTView.activitySelectSpaceTVM = tableVM;
}

#pragma mark - 懒加载
- (WSFActivitySelectSpaceTView *)activitySelectSpaceTView {
    if (!_activitySelectSpaceTView) {
        _activitySelectSpaceTView = [[WSFActivitySelectSpaceTView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40) style:UITableViewStylePlain];
        /*
        //下拉刷新
        
        _activitySelectSpaceTView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            
        }];
        //上拉加载
        _activitySelectSpaceTView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            
        }];
         */
    }
    return _activitySelectSpaceTView;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setBackgroundColor:HEX_COLOR_0x2B84C6];
        [_bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_bottomBtn.titleLabel setFont:SYSTEMFONT_14];
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_bottomBtn];
        [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.left.bottom.equalTo(self.view);
            make.height.mas_equalTo(40);
        }];
    }
    return _bottomBtn;
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
