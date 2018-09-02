//
//  WSFRPProfileInfoResApiModel.h
//  WinShare
//
//  Created by GZH on 2018/2/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"

/**
 账户信息
 */
@interface WSFRPProfileInfoResApiModel : MTLModel <MTLJSONSerializing>

/** 账户编号 */
@property (nonatomic, copy) NSString *Id;
/** 当前赢贝余额 */
@property (nonatomic, assign) CGFloat yBei;
/** 优惠券张数 */
@property (nonatomic, assign) NSInteger coupons;

@end
