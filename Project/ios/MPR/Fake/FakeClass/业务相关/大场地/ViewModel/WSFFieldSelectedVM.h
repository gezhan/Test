//
//  WSFFieldSelectedVM.h
//  WinShare
//
//  Created by GZH on 2018/1/18.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WSFFieldSelectedModel;

@interface WSFFieldMealContentCellVM : NSObject
/**  价格档位ID */
@property (nonatomic, strong) NSString *setMealId;
/**  所属套餐ID */
@property (nonatomic, strong) NSString *siteMealId;
/**  价格档位编号(例：价格档位2) */
@property (nonatomic, strong) NSString *mealNo;
/**  价格 */
@property (nonatomic, strong) NSString *minimum;
/**  价格 */
@property (nonatomic, assign) NSInteger minimumInteger;
/**  套餐内容  */
@property (nonatomic, strong) NSString *mealContent;
@end

@interface WSFFieldSelectedCellVM : NSObject
/**  套餐ID */
@property (nonatomic, strong) NSString *siteMealId;
/**  所属空间ID */
@property (nonatomic, strong) NSString *roomId;
/**  开始结束时间 */
@property (nonatomic, strong) NSString *beginEndTime;
/**  价格档位 */
@property (nonatomic, strong) NSMutableArray<WSFFieldMealContentCellVM*> *setMealArray;
@end


@interface WSFFieldSelectedVM : NSObject

/**  提示语句 */
@property (nonatomic, strong) NSString *tip;
/**  消费模式是否提示 */
@property (nonatomic, assign) BOOL isTip;
/**  存储场次的数据 */
@property (nonatomic, strong) NSMutableArray<WSFFieldSelectedCellVM*> *dataSource;

- (instancetype)initWithselectedModel:(WSFFieldSelectedModel *)playgroundModel;

@end
