//
//  WSFRPBusinessCardDetailModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"

/**
 商铺卡一个月使用明细
 */
@interface WSFRPBusinessCardDetailModel : MTLModel <MTLJSONSerializing>

/** 使用类型（结算；取消订单；预定） */
@property (nonatomic, copy) NSString *useType;
/** 时长(单位：分钟) */
@property (nonatomic, assign) NSInteger duration;
/** 发生时间 */
@property (nonatomic, strong) NSDate *creteTime;

@end
