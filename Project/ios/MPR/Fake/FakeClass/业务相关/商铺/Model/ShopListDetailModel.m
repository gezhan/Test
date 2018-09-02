//
//  ShopListDetailModel.m
//  WinShare
//
//  Created by GZH on 2017/7/12.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopListDetailModel.h"

@implementation ShopListDetailModel

- (instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        
        self.orderId = dict[@"OrderId"];
        self.state = dict[@"Status"];
        
        NSDateFormatter *oldDateFormatter = [[NSDateFormatter alloc] init];
        [oldDateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        
        self.beginTime = [oldDateFormatter dateFromString: dict[@"BeginTime"]];
        self.endTime = [oldDateFormatter dateFromString: dict[@"EndTime"]];
        
        self.coupon = dict[@"Coupon"];
        self.zFB = [dict[@"ZFB"] doubleValue];
        self.yBei = [dict[@"YBei"] doubleValue];
        self.mobile = dict[@"Mobile"];
        self.isVip = [dict[@"IsVip"] boolValue];
        self.amount = [dict[@"Amount"] integerValue];
        
        self.setMealNo = dict[@"MealNo"];
        self.setMealContent = dict[@"MealContent"];
        
    }
    return self;
}

+ (ShopListDetailModel *)modelFromDict:(NSDictionary *)dict
{
    ShopListDetailModel *model = [[ShopListDetailModel alloc] initWithDict:dict];
    return model;
}

+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array
{
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i<mutableArray.count; i++) {
        NSDictionary *dic = mutableArray[i];
        ShopListDetailModel *model = [ShopListDetailModel modelFromDict:dic];
        [mutableArray replaceObjectAtIndex:i withObject:model];
    }
    return mutableArray;
}

@end
