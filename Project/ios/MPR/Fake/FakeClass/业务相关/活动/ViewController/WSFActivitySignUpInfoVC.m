//
//  WSFActivitySignUpInfoVC.m
//  WinShare
//
//  Created by GZH on 2018/2/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivitySignUpInfoVC.h"
#import "WSFActivitySignUpInfoView.h"
#import "WSFActivityPersonalInfoTV.h"

@interface WSFActivitySignUpInfoVC ()

@property (nonatomic, strong) WSFActivitySignUpInfoView *upView; //上边基本信息的View
@property (nonatomic, strong) WSFActivityPersonalInfoTV *infoTableView;

@end

@implementation WSFActivitySignUpInfoVC

- (WSFActivityPersonalInfoTV *)infoTableView {
    if (_infoTableView == nil) {
        _infoTableView = [[WSFActivityPersonalInfoTV alloc]init];
        [self.view addSubview:_infoTableView];
        [_infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.upView.mas_bottom);
            make.left.bottom.right.equalTo(self.view);
        }];
    }
    return _infoTableView;
}

- (WSFActivitySignUpInfoView *)upView {
    if (_upView == nil) {
        _upView = [[WSFActivitySignUpInfoView alloc]init];
        [self.view addSubview:_upView];
        [_upView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self.view);
            make.height.mas_equalTo(108);
        }];
    }
    return _upView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
}

- (void)setupContentView {
    self.navigationItem.title = @"狼人杀";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    
    //right按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 65, 44);
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font    = [UIFont systemFontOfSize:14];
    [rightBtn.titleLabel sizeToFit];
    UIView *rightBtnView = [[UIView alloc]initWithFrame:rightBtn.frame];
    [rightBtnView addSubview:rightBtn];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIBarButtonItem *rightSpaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightSpaceBarButton.width = 10;
    self.navigationItem.rightBarButtonItems = @[rightBarBtn, rightSpaceBarButton];
    
    self.upView.hidden = NO;
    self.infoTableView.hidden = NO;

}


/**  查看详情 */
- (void)rightBtnAction {
    NSLog(@"----查看详情" );
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
