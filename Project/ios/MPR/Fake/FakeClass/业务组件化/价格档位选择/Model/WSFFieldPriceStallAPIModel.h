//
//  WSFFieldPriceStallAPIModel.h
//  WinShare
//
//  Created by QIjikj on 2018/1/17.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"

@interface WSFFieldPriceStallAPIModel : MTLModel<MTLJSONSerializing>

/** 价格档位id*/
@property (nonatomic, copy) NSString *setMealId;
/** 所属套餐id*/
@property (nonatomic, copy) NSString *siteMealId;
/** 价格档位编号*/
@property (nonatomic, copy) NSString *mealNo;
/** 价格*/
@property (nonatomic, assign) NSInteger minimum;
/** 套餐内容*/
@property (nonatomic, copy) NSString *mealContent;

@end
