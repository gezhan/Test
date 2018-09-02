//
//  ShopListDetailHeadModel.m
//  WinShare
//
//  Created by GZH on 2017/7/12.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopListDetailHeadModel.h"

@implementation ShopListDetailHeadModel

- (instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        
        self.incomeAmount = [dict[@"IncomeAmount"] doubleValue];
        self.ongoing = [dict[@"Ongoing"] integerValue];
        self.finished = [dict[@"Finished"] integerValue];
        self.expectedAmount = [dict[@"ExpectedAmount"] doubleValue];
        
    }
    return self;
}

+ (ShopListDetailHeadModel *)modelFromDict:(NSDictionary *)dict
{
    ShopListDetailHeadModel *model = [[ShopListDetailHeadModel alloc] initWithDict:dict];
    return model;
}

+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array
{
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i<mutableArray.count; i++) {
        NSDictionary *dic = mutableArray[i];
        ShopListDetailHeadModel *model = [ShopListDetailHeadModel modelFromDict:dic];
        [mutableArray replaceObjectAtIndex:i withObject:model];
    }
    return mutableArray;
}

@end
