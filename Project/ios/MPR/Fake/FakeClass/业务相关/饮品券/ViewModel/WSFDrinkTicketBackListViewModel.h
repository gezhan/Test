//
//  WSFDrinkTicketBackListViewModel.h
//  WinShare
//
//  Created by devRen on 2017/10/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSFDrinkTicketBackListModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface WSFDrinkTicketBackListViewModel : NSObject

/** 第一个月查询记录 */
@property (nonatomic, readonly, strong) NSMutableArray<WSFDrinkTicketBackAPIModel *> * firstMonthRecords;
/** 第二个月查询记录 */
@property (nonatomic, readonly, strong) NSMutableArray<WSFDrinkTicketBackAPIModel *> *secondMonthRecords;
/** 第一个月月份 */
@property (nonatomic, readonly, copy) NSString *firstMonth;
/** 第二个月月份 */
@property (nonatomic, readonly, copy) NSString *secondMonth;
/** 第一个月总额 */
@property (nonatomic, readonly, copy) NSString *firstMonthTotalAmount;
/** 第二个月总额 */
@property (nonatomic, readonly, copy) NSString *secondMonthTotalAmount;

/**
 加入新的数据

 @param backListModel 获取到的数据
 */
- (void)addNewDataFromNetwork:(nonnull WSFDrinkTicketBackListModel *)backListModel;

/** 清空数据 */
- (void)removeAllData;

@end
NS_ASSUME_NONNULL_END
