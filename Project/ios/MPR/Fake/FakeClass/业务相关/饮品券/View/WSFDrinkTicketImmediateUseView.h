//
//  WSFDrinkTicketImmediateUseView.h
//  WinShare
//
//  Created by devRen on 2017/10/28.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface WSFDrinkTicketImmediateUseView : UIView

/**
 通过饮品券 code 初始化 View

 @param meaasge 饮品券 code
 @return self
 */
- (nonnull instancetype)initWithQRCodeMessage:(nonnull NSString *)meaasge;

/** 完成按钮 */ 
@property (nonatomic, strong) UIButton *confirmButton;

@end
NS_ASSUME_NONNULL_END
