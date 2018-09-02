//
//  WSFDrinkTicketReclaimTView.h
//  WinShare
//
//  Created by devRen on 2017/10/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSFDrinkTicketBackListViewModel.h"

@interface WSFDrinkTicketReclaimTView : UITableView

/** 回收饮品券model */
@property (nonatomic, strong) WSFDrinkTicketBackListViewModel *backListViewModel;

@end
