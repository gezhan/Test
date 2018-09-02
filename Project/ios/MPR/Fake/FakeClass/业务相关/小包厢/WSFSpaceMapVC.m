//
//  WSFSpaceMapVC.m
//  WinShare
//
//  Created by GZH on 2017/12/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFSpaceMapVC.h"
#import "WSFSpaceMapView.h"

@interface WSFSpaceMapVC ()

@property (nonatomic, strong) WSFSpaceMapView *mapView;

@end

@implementation WSFSpaceMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"位置";
    
    [self setContentView];
}

- (void)setContentView {
//    self.currentCoor = CLLocationCoordinate2DMake(30.243403, 120.216634);
//    self.currentAddress = @"浙江省杭州市江干区解放东路";
    _mapView = [[WSFSpaceMapView alloc]initWithFrame:CGRectZero currentAddress:self.currentAddress currentCoor:self.currentCoor];
    [self.view addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //左下角定位按钮
    UIButton *positionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    positionBtn.frame = CGRectMake(12, self.view.frame.size.height - 12 - 64 - 30, 30, 30);
    [positionBtn setImage:[UIImage imageNamed:@"map_position_black"] forState:UIControlStateNormal];
    [positionBtn addTarget:self action:@selector(positioningSelfLocationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:positionBtn];
    [positionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.bottom.equalTo(self.view.mas_bottom).offset(-12);
        make.width.height.equalTo(@30);
    }];
}

- (void)positioningSelfLocationAction {
    [_mapView startLocationServiceAction];
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
