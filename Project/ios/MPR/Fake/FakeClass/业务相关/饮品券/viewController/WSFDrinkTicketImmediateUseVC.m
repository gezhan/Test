//
//  WSFDrinkTicketImmediateUseVC.m
//  WinShare
//
//  Created by devRen on 2017/10/28.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDrinkTicketImmediateUseVC.h"
#import "WSFDrinkTicketImmediateUseView.h"

@interface WSFDrinkTicketImmediateUseVC ()

@property (nonatomic, strong) WSFDrinkTicketImmediateUseView *immediateUseDrinkTicketView;

@end

@implementation WSFDrinkTicketImmediateUseVC

NSString * WSFDrinkTicketImmediateUseConfirmNotification = @"WSFDrinkTicketImmediateUseConfirmButtonClick";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.immediateUseDrinkTicketView.hidden = NO;
}

#pragma mark - 点击事件
- (void)confirmButtonClick {
    [self dismissViewControllerAnimated:NO completion:^{
        if (_immediateUseBackBlack) {
            _immediateUseBackBlack();
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:WSFDrinkTicketImmediateUseConfirmNotification object:_couponCode userInfo:nil];
    }];
}

#pragma mark - 懒加载
- (WSFDrinkTicketImmediateUseView *)immediateUseDrinkTicketView {
    if (!_immediateUseDrinkTicketView) {
        _immediateUseDrinkTicketView = [[WSFDrinkTicketImmediateUseView alloc] initWithQRCodeMessage:self.couponCode];
        [_immediateUseDrinkTicketView.confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_immediateUseDrinkTicketView];
        [_immediateUseDrinkTicketView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY);
            make.left.equalTo(self.view.mas_left).mas_equalTo(52);
            make.right.equalTo(self.view.mas_right).mas_equalTo(-52);
            make.height.equalTo(@216);
        }];
    }
    return _immediateUseDrinkTicketView;
}

@end
