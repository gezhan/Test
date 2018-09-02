//
//  WSFFieldTimeTV.h
//  WinShare
//
//  Created by GZH on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSFFieldSelectedVM;
@class WSFFieldDetailM;
@interface WSFFieldTimeTV : UITableView

/**  空间详情的model */
@property (nonatomic, strong) WSFFieldDetailM *detailModel;

- (instancetype)initWithPlaygroundSelectedVM:(WSFFieldSelectedVM *)selectedVM;

@end
