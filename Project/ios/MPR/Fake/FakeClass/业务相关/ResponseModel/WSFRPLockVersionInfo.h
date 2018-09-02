//
//  WSFRPLockVersionInfo.h
//  WinShare
//
//  Created by GZH on 2018/1/29.
//  Copyright © 2018年 QiJikj. All rights reserved.
//  锁版本

#import "Mantle.h"

/**
 锁版本
 */
@interface WSFRPLockVersionInfo : MTLModel <MTLJSONSerializing>

/** 协议类型*/
@property (nonatomic, assign) NSInteger protocolType;
/** 协议版本*/
@property (nonatomic, assign) NSInteger protocolVersion;
/** 场景*/
@property (nonatomic, assign) NSInteger scene;
/** 公司*/
@property (nonatomic, assign) NSInteger groupId;
/** 应用商*/
@property (nonatomic, assign) NSInteger orgId;

@end
