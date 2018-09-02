//
//  TicketModel.h
//  WinShare
//
//  Created by GZH on 2017/5/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketModel : HSModel
                                                         /** 优惠券id */
@property (nonatomic, copy) NSString *couponId;
                                                         /** 优惠券名称 */
@property (nonatomic, copy) NSString *couponName;
                                                         /** 优惠券号码 */
@property (nonatomic, copy) NSString *couponCode;
                                                         /** 账户编号 */
@property (nonatomic, copy) NSString *profileId;

                                                         /** 面值（金额（单位元）／折扣率／减时长） */
@property (nonatomic, assign) double amount;
                                                         /** 折扣类型（减金额／折扣券／减时长） */
@property (nonatomic, copy) NSString *amountType;
                                                         /** 限制条件，包括：地区限制、金额限制、时间限制、空间限制、    Z_F限制 */
@property (nonatomic, strong) NSArray *limits;
                                                         /** 限制条件-金额限制（eg：满100元可用） */
@property (nonatomic, copy) NSString *limitAmount;
                                                         /** 是否已使用 */
@property (nonatomic, assign) BOOL isUsed;
                                                         /** 是否过期 */
@property (nonatomic, assign) BOOL isOverdue;
                                                         /** 是否能够使用 */
@property (nonatomic, assign) BOOL isCanUse;

                                                         /** 生成日期 */
@property (nonatomic, copy) NSString *createTime;
                                                         /** 有效期截止日期 */
@property (nonatomic, copy) NSString *endTime;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (TicketModel *)modelFromDict:(NSDictionary *)dict;
+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array;

@end
