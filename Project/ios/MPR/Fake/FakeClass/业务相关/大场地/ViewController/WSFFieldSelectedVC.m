//
//  WSFFieldSelectedVC.m
//  WinShare
//
//  Created by GZH on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldSelectedVC.h"
#import "WSFFieldRemindView.h"
#import "WSFFieldTimeTV.h"
#import "WSFFieldSelectedApi.h"
#import "WSFFieldSelectedVM.h"
#import "WSFFieldSelectedModel.h"
#import "WSFFieldDetailM.h"

@interface WSFFieldSelectedVC ()
/**  提醒View */
@property (nonatomic, strong) WSFFieldRemindView *remindView;
@property (nonatomic, strong) WSFFieldTimeTV *tableView;
@property (nonatomic, strong) WSFFieldSelectedVM *playgroundVM;

@property (nonatomic, strong) UIView *noNetView;
@end

@implementation WSFFieldSelectedVC
- (WSFFieldTimeTV *)tableView {
    if (_tableView == nil) {
        _tableView = [[WSFFieldTimeTV alloc]initWithPlaygroundSelectedVM:_playgroundVM];
        _tableView.detailModel = self.detailModel;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
            if (_remindView) {
                make.top.equalTo(_remindView.mas_bottom);
            }else {
                make.top.equalTo(self.view.mas_top).offset(-15);
            }
        }];
    }
    return _tableView;
}


- (WSFFieldRemindView *)remindView {
    if (!_remindView) {
        _remindView = [[WSFFieldRemindView alloc]init];
        [self.view addSubview:_remindView];
        [_remindView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.view);
            make.height.equalTo(@44);
        }];
        UILabel *lineLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:@"" textFont:0 colorStr:@"#efeff4" aligment:NSTextAlignmentLeft];
        [_remindView addSubview:lineLabel];
        lineLabel.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(_remindView);
            make.height.equalTo(@0.5);
        }];
    }
    return _remindView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self netRequest];
}

- (void)netRequest {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  WSFFieldSelectedApi *selectedApi = [[WSFFieldSelectedApi alloc]initWithTheRoomId:self.roomId];
  [selectedApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
    NSLog(@"调用接口:【%@】\n\n", request.currentRequest.URL);
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    NSData *jsonData = [request.responseObject dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *messageDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    WSFFieldSelectedModel *selectedModel = [MTLJSONAdapter modelOfClass:WSFFieldSelectedModel.class fromJSONDictionary:messageDic[@"Data"] error:nil];
    WSFFieldSelectedVM *playgroundVM  = [[WSFFieldSelectedVM alloc] initWithselectedModel:selectedModel];
    _playgroundVM = playgroundVM;
    
    //        NSLog(@"-----选择场次-opokp--------------%@", selectedModel);
    [self setContentView];
    if([self.view.subviews containsObject:_noNetView])[_noNetView removeFromSuperview];
  } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    // 网络请求是否超时
    BOOL isRequestOutTime = [request.error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"];
    
    if (kNetworkNotReachability ||isRequestOutTime) {
      [MBProgressHUD showMessage:@"网络不可用，请稍后再试"];
    }
    
    @weakify(self);
    BOOL showBool = (kNetworkNotReachability || isRequestOutTime);
    _noNetView = [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
      @strongify(self);
      [self netRequest];
    }];
  }];
}

- (void)setContentView {
    self.navigationItem.title = @"选择场次";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
   
    if (_playgroundVM.isTip) {
        self.remindView.hidden = NO;
        self.remindView.remindLabel.text = _playgroundVM.tip;
    }
    self.tableView.hidden = NO;
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
