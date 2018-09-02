//
//  WSFFieldFieldM.h
//  WinShare
//
//  Created by GZH on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
#import "WSFRPKeyValueStrModel.h"

//@interface WSFFieldTimeTypeM : MTLModel <MTLJSONSerializing>
///**  场次id */
//@property (nonatomic, assign) NSInteger fieldKey;
///**  场次 */
//@property (nonatomic, strong) NSString *fieldTime;
//@end

@interface WSFFieldSetMealsM : MTLModel <MTLJSONSerializing>
/**  价格档位ID */
@property (nonatomic, strong) NSString *setMealId;
/**  所属套餐ID */
@property (nonatomic, strong) NSString *siteMealId;
/**  价格档位编号(例：价格档位2) */
@property (nonatomic, strong) NSString *mealNo;
/**  价格 */
@property (nonatomic, assign) NSInteger minimum;
/**  套餐内容  */
@property (nonatomic, strong) NSString *mealContent;
@end

@interface WSFFieldFieldM : MTLModel <MTLJSONSerializing>
/** 套餐ID */
@property (nonatomic, strong) NSString *siteMealId;
/** 所属空间ID */
@property (nonatomic, strong) NSString *roomId;
/** 场类型（上午场，下午场） */
@property (nonatomic, strong) WSFRPKeyValueStrModel *timeType;
/** 开始时间 */
@property (nonatomic, strong) NSString *beginTime;
/** 结束时间 */
@property (nonatomic, strong) NSString *endTime;
/** 价格档位 */
@property (nonatomic, strong) NSArray<WSFFieldSetMealsM*> *meals;
@end
