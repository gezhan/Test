//
//  WSFRPAppEventApiResModel.h
//  WinShare
//
//  Created by GZH on 2018/3/8.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
#import "WSFRPPhotoApiModel.h"
#import "WSFRPKeyValueStrModel.h"
#import "WSFRPEventIntroApiResModel.h"
/**
 * 活动详情
 */
@interface WSFRPAppEventApiResModel : MTLModel <MTLJSONSerializing>
/**  活动ID */
@property (nonatomic, strong) NSString *Id;
/**  活动名称 */
@property (nonatomic, strong) NSString *name;
/**  当前人数 */
@property (nonatomic, assign) NSInteger man;
/**  人数上限(0-无限制) */
@property (nonatomic, assign) NSInteger manTop;
/**  人数下限(0-无限制) */
@property (nonatomic, assign) NSInteger manDown;
/**  报名费用(0-免费)） */
@property (nonatomic, strong) NSNumber *enrolmentFee;
/**  联系电话 */
@property (nonatomic, strong) NSString *tel;
/**  举办空间ID */
@property (nonatomic, strong) NSString *roomId;
/**  举办空间名字 */
@property (nonatomic, strong) NSString *roomName;
/**  报名起始日期 */
@property (nonatomic, strong) NSString *applyBeginDate;
/**  报名截止日期 */
@property (nonatomic, strong) NSString *applyEndDate;
/**  活动起始时间 */
@property (nonatomic, strong) NSString *eventBeginTime;
/**  活动截止时间 */
@property (nonatomic, strong) NSString *eventEndTime;
/**  活动日期 */
@property (nonatomic, strong) NSString *eventDate;
/**  活动地址（空间地址） */
@property (nonatomic, strong) NSString *address;
/**  经度 */
@property (nonatomic, strong) NSNumber *lng;
/**  纬度 */
@property (nonatomic, strong) NSNumber *lat;
/**  活动分享地址 */
@property (nonatomic, strong) NSString *shareUrl;
/** 活动图片 */
@property (nonatomic, strong) NSArray<WSFRPPhotoApiModel*> *picture;
/** 活动介绍 */
@property (nonatomic, strong) NSArray<WSFRPEventIntroApiResModel*> *intros;
/** 活动状态 */
@property (nonatomic, strong) WSFRPKeyValueStrModel *eventStatus;

@end
