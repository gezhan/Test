//
//  WSFDrinkTicketBackListModel.h
//  WinShare
//
//  Created by devRen on 2017/10/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface WSFDrinkTicketBackAPIModel : NSObject

/** 饮品券ID */
@property (nonatomic, copy) NSString *couponId;
/** 饮品券名称 */
@property (nonatomic, copy) NSString *name;
/** 面值（金额(单位元)/折扣率/时长（单位h）） */
@property (nonatomic, assign) double amount;
/** 限制条件(字典值包含：地区限制、金额限制、时间限制、空间限制、    Z_F限制) */
@property (nonatomic, copy) NSArray *limits;
/** 兑换日期 */
@property (nonatomic, copy) NSString *backTime;

/**
 初始化模型 （字典->模型）
 
 @param dict json数据
 @return 模型数据
 */
- (nonnull instancetype)initWithDict:(nonnull NSDictionary *)dict;

/**
 根据数组初始化模型 （字典array->模型array）

 @param array json数据array
 @return 模型数据array
 */
+ (nonnull NSArray<WSFDrinkTicketBackAPIModel *> *)drinkTicketBackAPIModelWithArray:(nonnull NSArray *)array;

@end

@interface WSFDrinkTicketTotalAmountAPIModel : NSObject

/** 月份 */
@property (nonatomic, assign) NSInteger month;
/** 回收总额 */
@property (nonatomic, copy) NSString *total;

/**
 初始化模型 （字典->模型）
 
 @param dict json数据
 @return 模型数据
 */
- (nonnull instancetype)initWithDict:(nonnull NSDictionary *)dict;

/**
 根据数组初始化模型 （字典array->模型array）
 
 @param array json数据array
 @return 模型数据array
 */
+ (nonnull NSArray<WSFDrinkTicketTotalAmountAPIModel *> *)drinkTicketTotalAmountAPIModelWithArray:(nonnull NSArray *)array;

@end

@interface WSFDrinkTicketBackListModel : NSObject

/** 每页数量 */
@property (nonatomic, assign) NSInteger pageSize;
/** 第几页 */
@property (nonatomic, assign) NSInteger pageIndex;
/** 总记录数 */
@property (nonatomic, assign) NSInteger totalCount;
/** 每月总记 (仅两个月) */
@property (nonatomic, copy) NSArray<WSFDrinkTicketTotalAmountAPIModel *> *totalAmount;
/** 查询记录 */
@property (nonatomic, copy) NSArray<WSFDrinkTicketBackAPIModel *> *records;

/**
 初始化模型 （字典->模型）
 
 @param dict json数据
 @return 模型数据
 */
- (nonnull instancetype)initWithDict:(nonnull NSDictionary *)dict;

@end
NS_ASSUME_NONNULL_END
