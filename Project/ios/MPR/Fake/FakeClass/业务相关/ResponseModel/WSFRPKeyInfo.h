//
//  WSFRPKeyInfo.h
//  WinShare
//
//  Created by GZH on 2018/1/29.
//  Copyright © 2018年 QiJikj. All rights reserved.
//  电子钥匙信息

#import "Mantle.h"
@class WSFRPLockVersionInfo;


/**
 电子钥匙信息
 */
@interface WSFRPKeyInfo : MTLModel <MTLJSONSerializing>

/** 钥匙id*/
@property (nonatomic, assign) NSInteger keyId;
/** 锁id*/
@property (nonatomic, assign) NSInteger lockId;
/** 用户类型：110301-管理员钥匙，110302-普通用户钥匙*/
@property (nonatomic, copy) NSString *userType;
/** 钥匙状态，参考：http://open.sciener.cn/doc/api/keyStatus*/
@property (nonatomic, copy) NSString *keyStatus;
/** 锁的蓝牙名称*/
@property (nonatomic, copy) NSString *lockName;
/** 锁别名*/
@property (nonatomic, copy) NSString *lockAlias;
/** 锁开门的关键信息，开门用的*/
@property (nonatomic, copy) NSString *lockKey;
/** 门锁蓝牙的mac地址*/
@property (nonatomic, copy) NSString *lockMac;
/** 锁开门标志位*/
@property (nonatomic, assign) NSInteger lockFlagPos;
/** 管理员钥匙会有，锁的管理员密码，锁管理相关操作需要携带，校验管理员权限*/
@property (nonatomic, copy) NSString *adminPwd;
/** 管理员钥匙会有，管理员键盘密码，管理员用该密码开门*/
@property (nonatomic, copy) NSString *noKeyPwd;
/** 二代锁的管理员钥匙会有，清空码，用于清空锁上的密码*/
@property (nonatomic, copy) NSString *deletePwd;
/** 锁电量*/
@property (nonatomic, assign) NSInteger electricQuantity;
/** Aes加解密key*/
@property (nonatomic, copy) NSString *aesKeyStr;
/** 锁版本*/
@property (nonatomic, strong) WSFRPLockVersionInfo *lockVersion;
/** 钥匙有效期开始时间*/
@property (nonatomic, copy) NSString *startDate;
/** 钥匙有效期结束时间*/
@property (nonatomic, copy) NSString *endDate;
/** 锁所在时区和UTC时区时间的差数，单位milliseconds*/
@property (nonatomic, copy) NSString *timezoneRawOffset;
/** 备注*/
@property (nonatomic, copy) NSString *remarks;

@end
