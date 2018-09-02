//
//  TicketTView.h
//  WinShare
//
//  Created by GZH on 2017/8/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TicketModel;

@interface TicketTView : UITableView

@property (nonatomic, assign) BOOL skip;
@property (nonatomic, strong) NSArray <TicketModel *> *ticketArray;

/** 之前绑定的的优惠券ID，没有绑定过的话，传空字符串 */
@property (nonatomic, copy) NSString *previousTicketedId;

/** 是否有失效的优惠券数据 */
@property (nonatomic, assign) BOOL isHaveDisableTicket;

@end
