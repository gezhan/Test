//
//  ShopListDetailModel.h
//  WinShare
//
//  Created by GZH on 2017/7/12.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopListDetailModel : NSObject

@property (nonatomic, copy) NSString *orderId;// 订单编号
@property (nonatomic, copy) NSString *state;// 订单状态（已预订、已结算、已取消）
@property (nonatomic, strong) NSDate *beginTime;// 开始使用时间
@property (nonatomic, strong) NSDate *endTime;// 结束使用时间
@property (nonatomic, copy) NSString *coupon;// 优惠券
@property (nonatomic, assign) CGFloat zFB;// ZFB
@property (nonatomic, assign) CGFloat yBei;// 赢贝
@property (nonatomic, copy) NSString *mobile;// 用户手机号
@property (nonatomic, assign) BOOL isVip;// 用户是否为vip
@property (nonatomic, assign) NSInteger amount;// 小计
@property (nonatomic, copy) NSString *setMealNo;// 套餐编号
@property (nonatomic, copy) NSString *setMealContent;// 套餐内容

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (ShopListDetailModel *)modelFromDict:(NSDictionary *)dict;
+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array;

@end
