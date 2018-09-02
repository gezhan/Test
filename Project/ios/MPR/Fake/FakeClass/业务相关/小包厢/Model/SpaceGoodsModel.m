//
//  SpaceGoodsModel.m
//  WinShare
//
//  Created by QIjikj on 2017/5/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "SpaceGoodsModel.h"

@implementation SpaceGoodsModel

- (instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        
        self.diviceTypeId = [dict[@"DiviceTypeId"] integerValue];
        self.diviceType = dict[@"DiviceType"];
        self.diviceAmount = [dict[@"Qty"] integerValue];
        
    }
    return self;
}

+ (SpaceGoodsModel*)modelFromDict:(NSDictionary*)dict
{
    SpaceGoodsModel *spaceGoodsModel = [[SpaceGoodsModel alloc] initWithDict:dict];
    return spaceGoodsModel;
}

+ (NSMutableArray*)getModelArrayFromModelArray:(NSArray*)array
{
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i<mutableArray.count; i++) {
        NSDictionary *dic = mutableArray[i];
        SpaceGoodsModel *model = [SpaceGoodsModel modelFromDict:dic];
        [mutableArray replaceObjectAtIndex:i withObject:model];
    }
    return mutableArray;
}

@end
