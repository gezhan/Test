//
//  WSFDrinkTicketTableView.h
//  WinShare
//
//  Created by devRen on 2017/10/27.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketModel.h"

@interface WSFDrinkTicketTView : UITableView

/** 饮品券model数组 */
@property (nonatomic, strong) NSArray <TicketModel *> *drinkTicketArray;
/** 是否有失效的优惠券数据 */
@property (nonatomic, assign) BOOL isHaveDisableTicket;

@end
