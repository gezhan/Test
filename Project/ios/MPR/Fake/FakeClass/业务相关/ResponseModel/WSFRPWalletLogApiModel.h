//
//  WSFRPWalletLogApiModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"


/**
 赢贝流水明细
 */
@interface WSFRPWalletLogApiModel : MTLModel <MTLJSONSerializing>

/** 金额*/
@property (nonatomic, assign) CGFloat amount;
/** 操作行为*/
@property (nonatomic, copy) NSString *operation;
/** 时间*/
@property (nonatomic, strong) NSDate *theTime;

@end
