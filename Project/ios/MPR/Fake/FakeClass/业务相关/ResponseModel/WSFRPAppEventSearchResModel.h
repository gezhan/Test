//
//  WSFRPAppEventSearchResModel.h
//  WinShare
//
//  Created by GZH on 2018/3/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSFRPPhotoApiModel.h"
#import "WSFRPKeyValueStrModel.h"

/**
 活动列表的VC
 */
@interface WSFRPAppEventSearchResModel : MTLModel <MTLJSONSerializing>
/** 活动ID */
@property (nonatomic, strong) NSString *Id;
/** 活动图片 */
@property (nonatomic, strong) WSFRPPhotoApiModel *picture;
/** 活动名称 */
@property (nonatomic, strong) NSString *name;
/** 地理位置 */
@property (nonatomic, strong) NSString *address;
/** 活动起始时间 */
@property (nonatomic, strong) NSString *eventBeginTime;
/** 活动截止时间 */
@property (nonatomic, strong) NSString *eventEndTime;
/** 活动时间(字符串) */
@property (nonatomic, strong) NSString *eventTheTime;
/** 报名费用 */
@property (nonatomic, strong) NSString *enrolmentFee;
/** 活动状态 */
@property (nonatomic, strong) WSFRPKeyValueStrModel *eventStatus;
/** 活动人数 */
@property (nonatomic, strong) NSString *man;
@end
