//
//  WSFRPRoomSiteMealsModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
#import "WSFRPKeyValueStrModel.h"
#import "WSFRPSiteSetMealApiModel.h"

/**
 套餐
 */
@interface WSFRPRoomSiteMealsModel : MTLModel <MTLJSONSerializing>

/** 套餐ID */
@property (nonatomic, copy) NSString *siteMealId;
/** 所属空间ID */
@property (nonatomic, copy) NSString *roomId;
/** 场类型（上午场，下午场） */
@property (nonatomic, strong) WSFRPKeyValueStrModel *timeType;
/** 开始时间 */
@property (nonatomic, copy) NSString *beginTime;
/** 结束时间 */
@property (nonatomic, copy) NSString *endTime;
/** 价格档位 */
@property (nonatomic, strong) NSArray<WSFRPSiteSetMealApiModel *> *setMeals;

@end
