//
//  WSFRPRoomBigApiModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
#import "WSFRPRoomFacilitiesModel.h"
#import "WSFRPPhotoApiModel.h"
#import "WSFRPRoomSiteMealsModel.h"

/**
 大场地详情
 */
@interface WSFRPRoomBigApiModel : MTLModel <MTLJSONSerializing>

/** 空间编号 */
@property (nonatomic, copy) NSString *Id;
/** 空间名称 */
@property (nonatomic, copy) NSString *roomName;
/** 空间类别 */
@property (nonatomic, copy) NSString *roomType;
/** 距离(单位/米) */
@property (nonatomic, assign) CGFloat theMeter;
/** 可容纳人数 */
@property (nonatomic, assign) NSInteger capacity;
/** 建筑面积单位平方米 */
@property (nonatomic, assign) CGFloat areaSize;
/** 价格 */
@property (nonatomic, assign) CGFloat price;
/** 空间描述 */
@property (nonatomic, copy) NSString *Description;
/** 联系人 */
@property (nonatomic, copy) NSString *tel;
/** 空间内设 */
@property (nonatomic, strong) NSArray<WSFRPRoomFacilitiesModel *> *deviceItems;
/** 地址 */
@property (nonatomic, copy) NSString *address;
/** 空间发布图 */
@property (nonatomic, strong) NSArray<WSFRPPhotoApiModel *> *photos;
/** 经度 */
@property (nonatomic, assign) CGFloat Long;
/** 纬度 */
@property (nonatomic, assign) CGFloat lat;
/** 所在地编号 */
@property (nonatomic, copy) NSString *regionCode;
/** 空间分享地址 */
@property (nonatomic, copy) NSString *roomShareUrl;
/** 套餐 */
@property (nonatomic, strong) NSArray<WSFRPRoomSiteMealsModel *> *setMeals;

@end
