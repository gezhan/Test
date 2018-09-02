//
//  WSFRPRoomMealListModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"

/**
 套餐
 */
@interface WSFRPRoomMealListModel : MTLModel <MTLJSONSerializing>

/** 套餐编号 */
@property (nonatomic, copy) NSString *Id;
/** 所属空间ID */
@property (nonatomic, copy) NSString *roomId;
/** 套餐编号 */
@property (nonatomic, copy) NSString *mealNo;
/** 最低限额 */
@property (nonatomic, assign) NSInteger minimum;
/** 套餐内容 */
@property (nonatomic, copy) NSString *mealContent;

@end
