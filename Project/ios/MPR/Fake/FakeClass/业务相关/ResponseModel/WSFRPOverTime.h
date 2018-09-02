//
//  WSFRPOverTime.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"


/**
 超时结算
 */
@interface WSFRPOverTime : MTLModel <MTLJSONSerializing>

/**     Z_F调用*/
@property (nonatomic, copy) NSString *orderString;
/** 返回渠道1-ZFB调用OrderString；2-无需调用*/
@property (nonatomic, assign) NSInteger status;

@end
