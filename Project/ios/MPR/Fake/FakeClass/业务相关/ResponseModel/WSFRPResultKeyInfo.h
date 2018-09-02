//
//  WSFRPResultKeyInfo.h
//  WinShare
//
//  Created by GZH on 2018/1/29.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
@class WSFRPLockVersionInfo;

/**
 钥匙信息
 */
@interface WSFRPResultKeyInfo : MTLModel <MTLJSONSerializing>

/** 键盘密码ID*/
@property (nonatomic, assign) NSInteger keyBoardPwdId;
/** 键盘密码*/
@property (nonatomic, copy) NSString *keyBoardPwd;
/** 锁id*/
@property (nonatomic, assign) NSInteger lockId;
/** 钥匙id*/
@property (nonatomic, assign) NSInteger keyId;
/** 钥匙状态.110401-正常使用，110402-待接收，110405-已冻结，110408-已删除，110410-已重置*/
@property (nonatomic, copy) NSString *keyStatus;
/** 锁开门的关键信息，开门用的*/
@property (nonatomic, copy) NSString *lockKey;
/** 门锁蓝牙的mac地址*/
@property (nonatomic, copy) NSString *lockMac;
/** 锁开门标志位*/
@property (nonatomic, assign) NSInteger lockFlagPos;
/** Aes加解密key*/
@property (nonatomic, copy) NSString *aesKeyStr;
/** 钥匙有效期开始时间*/
@property (nonatomic, copy) NSString *startDate;
/** 钥匙有效期结束时间*/
@property (nonatomic, copy) NSString *endDate;
/** 用户类型：110301-管理员钥匙，110302-普通用户钥匙*/
@property (nonatomic, copy) NSString *userType;
/** 锁的蓝牙名称*/
@property (nonatomic, copy) NSString *lockName;
/** 锁别名*/
@property (nonatomic, copy) NSString *lockAlias;
/** 管理员钥匙会有，锁的管理员密码，锁管理相关操作需要携带，校验管理员权限*/
@property (nonatomic, copy) NSString *adminPwd;
/** 管理员钥匙会有，管理员键盘密码，管理员用该密码开门*/
@property (nonatomic, copy) NSString *noKeyPwd;
/** 二代锁的管理员钥匙会有，清空码，用于清空锁上的密码*/
@property (nonatomic, copy) NSString *deletePwd;
/** 锁电量*/
@property (nonatomic, assign) NSInteger electricQuantity;
/** 备注*/
@property (nonatomic, copy) NSString *remarks;
/** 锁所在时区和UTC时区时间的差数，单位milliseconds*/
@property (nonatomic, copy) NSString *timezoneRawOffset;
/** 锁版本*/
@property (nonatomic, strong) WSFRPLockVersionInfo *lockVersion;

@end
