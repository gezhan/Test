//
//  SpaceGoodsModel.h
//  WinShare
//
//  Created by QIjikj on 2017/5/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpaceGoodsModel : NSObject

/** 设别类别编号 */
@property (nonatomic, assign) NSInteger diviceTypeId;
/** 设备类别名称 */
@property (nonatomic, copy) NSString *diviceType;
/** 设备数量 */
@property (nonatomic, assign) NSInteger diviceAmount;

- (instancetype)initWithDict:(NSDictionary*)dict;

+ (SpaceGoodsModel*)modelFromDict:(NSDictionary*)dict;
+ (NSMutableArray*)getModelArrayFromModelArray:(NSArray*)array;

@end
