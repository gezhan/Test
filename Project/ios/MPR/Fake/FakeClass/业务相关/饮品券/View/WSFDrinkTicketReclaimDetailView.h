//
//  WSFDrinkTicketReclaimDetailView.h
//  WinShare
//
//  Created by devRen on 2017/10/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TicketModel;

@interface WSFDrinkTicketReclaimDetailView : UIView

/**
 通过 TicketModel 初始化 view

 @param drinkTicketModel 饮品券model
 @return self
 */
- (instancetype)initWithDrinkTicketModel:(TicketModel *)drinkTicketModel;

/** 确定按钮 */
@property (nonatomic, strong) UIButton *confirmButton;

@end
