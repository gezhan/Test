//
//  WSFFieldSelectedVC.h
//  WinShare
//
//  Created by GZH on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFBaseViewController.h"
@class WSFFieldDetailM;
@interface WSFFieldSelectedVC : WSFBaseViewController
/**  空间ID */
@property (nonatomic, strong) NSString *roomId;
/**  空间详情的model */
@property (nonatomic, strong) WSFFieldDetailM *detailModel;
@end
