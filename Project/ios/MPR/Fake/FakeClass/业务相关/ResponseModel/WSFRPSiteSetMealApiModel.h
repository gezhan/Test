//
//  WSFRPSiteSetMealApiModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"

/**
 套餐价格档位
 */
@interface WSFRPSiteSetMealApiModel : MTLModel <MTLJSONSerializing>

/** 价格档位ID */
@property (nonatomic, copy) NSString *setMealId;
/** 所属套餐ID */
@property (nonatomic, copy) NSString *siteMealId;
/** 价格档位编号(例：价格档位2) */
@property (nonatomic, copy) NSString *mealNo;
/** 价格 */
@property (nonatomic, assign) CGFloat minimum;
/** 套餐内容 */
@property (nonatomic, copy) NSString *mealContent;

@end
