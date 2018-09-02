//
//  WSFActivityHistoryVC.m
//  WinShare
//
//  Created by GZH on 2018/2/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityHistoryVC.h"
#import "WSFActivityListTV.h"

@interface WSFActivityHistoryVC ()
@property (nonatomic, strong) WSFActivityListTV *activityListTV;  //tableView
@end

@implementation WSFActivityHistoryVC

- (WSFActivityListTV *)activityListTV {
    if (_activityListTV == nil) {
        _activityListTV = [[WSFActivityListTV alloc]init];
        [self.view addSubview:_activityListTV];
        [_activityListTV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-15);
            make.left.bottom.right.equalTo(self.view);
        }];
    }
    return _activityListTV;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
}


- (void)setupContentView {
    self.navigationItem.title = @"往期回顾";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.activityListTV.hidden = NO;
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
