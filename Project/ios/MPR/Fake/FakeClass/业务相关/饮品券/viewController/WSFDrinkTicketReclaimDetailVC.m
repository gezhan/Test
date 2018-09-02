//
//  WSFDrinkTicketReclaimDetailVC.m
//  WinShare
//
//  Created by devRen on 2017/10/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDrinkTicketReclaimDetailVC.h"
#import "WSFDrinkTicketReclaimDetailView.h"
#import "WSFDrinkTicketNetwork.h"
#import "TicketModel.h"
#import "WSFDrinkTicketReclaimListVC.h"

static NSString * const kDrinkTicketReclaimDetailVCTitle = @"饮品券回收";
static NSString * const kDrinkTicketQRBackSuccessMessage = @"回收成功";
static NSString * const kDrinkTicketQRBackFailedMessage = @"该饮品券已失效";

NSString * WSFDrinkTicketReclaimDetailBackNotification = @"WSFDrinkTicketReclaimDetailBackNotification";

@interface WSFDrinkTicketReclaimDetailVC ()

@property (nonatomic, strong) WSFDrinkTicketReclaimDetailView *detailView;
@property (nonatomic, strong) TicketModel *ticketModel;



@end

@implementation WSFDrinkTicketReclaimDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = kDrinkTicketReclaimDetailVCTitle;
    self.view.backgroundColor = HEX_COLOR_0xE6E6E6;
    [self getDrinkTicketDetail];
}

#pragma mark - 网络请求
- (void)getDrinkTicketDetail {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [WSFDrinkTicketNetwork getDrinkTicketDetailWithCouponCode:_couponCode
                                                      success:^(id data) {
                                                          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                          _ticketModel = [[TicketModel alloc] initWithDict:data];
                                                          [self.view addSubview:self.detailView];
                                                      }
                                                       failed:^(NSError *error) {
                                                          [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                      }];
}

- (void)postDrinkTicketQRBack {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [WSFDrinkTicketNetwork postDrinkTicketQRBackWithCouponCode:_couponCode
                                                       success:^(id data) {
                                                           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                           [MBProgressHUD showMessage:kDrinkTicketQRBackSuccessMessage];
                                                           [self doBackAction];
                                                           [[NSNotificationCenter defaultCenter] postNotificationName:WSFDrinkTicketReclaimDetailBackNotification object:nil userInfo:nil];
                                                       }
                                                        failed:^(NSError *error) {
                                                           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                           [MBProgressHUD showMessage:kDrinkTicketQRBackFailedMessage];
                                                       }];
}

#pragma mark - 点击事件
- (void)confirmButtonClick {
    [self postDrinkTicketQRBack];
}

#pragma mark - 返回
- (void)doBackAction {
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[WSFDrinkTicketReclaimListVC class]]) {
            [self.navigationController popToViewController:vc animated:NO];
        }
    }
}

#pragma mark - 懒加载
- (WSFDrinkTicketReclaimDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[WSFDrinkTicketReclaimDetailView alloc] initWithDrinkTicketModel:_ticketModel];
        _detailView.frame = CGRectMake(25, 10, SCREEN_WIDTH - 50, SCREEN_HEIGHT);
        [_detailView.confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailView;
}

@end
