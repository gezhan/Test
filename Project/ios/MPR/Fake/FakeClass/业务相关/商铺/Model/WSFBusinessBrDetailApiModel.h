//
//  WSFBusinessBrDetailApiModel.h
//  WinShare
//
//  Created by QIjikj on 2018/1/22.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSFBusinessBrDetailApiModel : NSObject

@property (nonatomic, copy) NSString *orderId;// 订单编号
@property (nonatomic, copy) NSString *status;// 订单状态（已预订、已结算、已取消）
@property (nonatomic, copy) NSString *useTime;// 使用日期
@property (nonatomic, copy) NSString *siteMeal;// 场次
@property (nonatomic, copy) NSString *setMeal;// 套餐
@property (nonatomic, assign) CGFloat discountsAmount;// 优惠
@property (nonatomic, assign) CGFloat totalAmount;// 总价
@property (nonatomic, assign) CGFloat payAmount;// 定金

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (WSFBusinessBrDetailApiModel *)modelFromDict:(NSDictionary *)dict;
+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array;

@end
