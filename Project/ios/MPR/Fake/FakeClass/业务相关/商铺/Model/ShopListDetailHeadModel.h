//
//  ShopListDetailHeadModel.h
//  WinShare
//
//  Created by GZH on 2017/7/12.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopListDetailHeadModel : NSObject

@property (nonatomic, assign) CGFloat incomeAmount;//已经收入（实际收入，现在包括赢贝）
@property (nonatomic, assign) NSInteger ongoing;//未结算订单数
@property (nonatomic, assign) NSInteger finished;//已完成订单数
@property (nonatomic, assign) CGFloat expectedAmount;//预计收入（为结算订单的定金）

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (ShopListDetailHeadModel *)modelFromDict:(NSDictionary *)dict;
+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array;

@end
