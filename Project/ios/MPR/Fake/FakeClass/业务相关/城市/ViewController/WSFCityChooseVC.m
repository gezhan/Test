//
//  WSFCityChooseVC.m
//  WinShare
//
//  Created by GZH on 2017/12/19.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFCityChooseVC.h"
#import "WSFCityApi.h"
#import "WSFCityTableView.h"
#import "WSFCityModel.h"
#import "WSFCityViewModel.h"
#import "WSFSpaceListMapManager.h"

@interface WSFCityChooseVC ()
/**  城市的tableView */
@property (nonatomic, strong) WSFCityTableView *cityTableView;

@end

@implementation WSFCityChooseVC

- (WSFCityTableView *)cityTableView {
    if (_cityTableView == nil) {
        _cityTableView = [[WSFCityTableView alloc]init];
        _cityTableView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        [self.view addSubview:_cityTableView];
        [_cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        __weak typeof(self) weakSelf = self;
        _cityTableView.cityNameBlack = ^(NSString *cityName) {
            [weakSelf doBackActionWithCityName:cityName];
        };
        [[WSFSpaceListMapManager shareManager] getCurrentCityInformationWithBlock:^(CLPlacemark * _Nonnull placemark) {
            weakSelf.cityTableView.placemark = placemark;
        }];
    }
    return _cityTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"城市选择";
    self.view.backgroundColor = [UIColor whiteColor];
    [self netRequest];
}


- (void)netRequest {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if ([WSFSpaceListMapManager shareManager].regionArray.count > 0) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        WSFCityViewModel *viewModel = [[WSFCityViewModel alloc]initWithCityModelArray:[WSFSpaceListMapManager shareManager].regionArray];
        self.cityTableView.viewModel = viewModel;
    }else {
        WSFCityApi *cityApi = [[WSFCityApi alloc]init];
        [cityApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
          NSData *jsonData = [request.responseObject dataUsingEncoding:NSUTF8StringEncoding];
          NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSArray *regionArray = [MTLJSONAdapter modelsOfClass:WSFCityArrayModel.class fromJSONArray:messageDic[@"Data"][@"Regions"] error:nil];
            [[WSFSpaceListMapManager shareManager] saveRegionData:regionArray];
            WSFCityViewModel *viewModel = [[WSFCityViewModel alloc]initWithCityModelArray:regionArray];
            self.cityTableView.viewModel = viewModel;
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }];
    }
}

- (void)doBackActionWithCityName:(NSString *)cityName {
    if(_cityNameBlack)_cityNameBlack(cityName);
    [self.navigationController popViewControllerAnimated:NO];
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
