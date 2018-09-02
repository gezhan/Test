//
//  ShopCardListModel.h
//  WinShare
//
//  Created by Gzh on 2017/9/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "HSModel.h"

@interface ShopCardListModel : HSModel

@property (nonatomic, copy) NSString *roomId;/** 空间编号 */
@property (nonatomic, copy) NSString *roomName;/** 空间名称 */
@property (nonatomic, copy) NSString *roomCardDuration;/** 每月可用时长（分钟） */
@property (nonatomic, copy) NSString *roomCardLeaveMinutes;/** 商铺卡剩余可用分钟 */
@property (nonatomic, copy) NSString *endContractTime;/** 合同结束时间 */

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (ShopCardListModel *)modelFromDict:(NSDictionary *)dict;
+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array;

@end
