//
//  WSFRPSiteMealListModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
#import "WSFRPRoomSiteMealsModel.h"

/**
 套餐详情
 */
@interface WSFRPSiteMealListModel : MTLModel <MTLJSONSerializing>

/** 套餐 */
@property (nonatomic, strong) NSArray<WSFRPRoomSiteMealsModel *> *records;
/** 消费模式是否提示 */
@property (nonatomic, assign) BOOL isTip;
/** 消费模式提示内容 */
@property (nonatomic, copy) NSString *tip;

@end
