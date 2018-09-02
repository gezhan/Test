//
//  WSFDrinkTicketImmediateUseVC.h
//  WinShare
//
//  Created by devRen on 2017/10/28.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

/**
 饮品券立即使用弹框用法
 WSFDrinkTicketImmediateUseVC *vc = [[WSFDrinkTicketImmediateUseVC alloc] init];
 vc.couponCode = _ticketModel.couponCode;
 vc.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
 vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
 [self.viewController presentViewController:vc animated:NO completion:nil];
 */

#import "WSFBaseViewController.h"

typedef void(^ImmediateUseBackBlack)();

@interface WSFDrinkTicketImmediateUseVC : WSFBaseViewController

/** 优惠券代码 */
@property (nonatomic, copy) NSString *couponCode;
/** 点击完成时的回调 */
@property (nonatomic, copy) ImmediateUseBackBlack immediateUseBackBlack;

FOUNDATION_EXPORT NSString * WSFDrinkTicketImmediateUseConfirmNotification;

@end
