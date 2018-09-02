//
//  WSFRPOrderRoomInfo.h
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
@class WSFRPPhotoApiModel;
@class WSFRPResultKeyInfo;

@interface WSFRPOrderRoomInfo : MTLModel <MTLJSONSerializing>

/** 空间编号*/
@property (nonatomic, copy) NSString *roomId;
/** 订单编号*/
@property (nonatomic, copy) NSString *orderId;
/** 门锁编号*/
@property (nonatomic, assign) NSInteger lockId;
/** 空间名称*/
@property (nonatomic, copy) NSString *roomName;
/** 地址*/
@property (nonatomic, copy) NSString *address;
/** 空间发布图*/
@property (nonatomic, strong) WSFRPPhotoApiModel *photo;
/** 启用时间*/
@property (nonatomic, strong) NSDate *beginTime;
/** 结束时间*/
@property (nonatomic, strong) NSDate *endTime;
/** 实际结束时间*/
@property (nonatomic, strong) NSDate *actualEndTime;
/** 钥匙信息*/
@property (nonatomic, strong) WSFRPResultKeyInfo *keyInfo;
/** 身份标识（1-用户；2-（VIP）商户）*/
@property (nonatomic, assign) NSInteger identity;

@end
