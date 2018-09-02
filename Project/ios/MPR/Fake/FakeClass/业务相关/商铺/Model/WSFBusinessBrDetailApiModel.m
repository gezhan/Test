//
//  WSFBusinessBrDetailApiModel.m
//  WinShare
//
//  Created by QIjikj on 2018/1/22.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFBusinessBrDetailApiModel.h"

@implementation WSFBusinessBrDetailApiModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.orderId = dict[@"OrderId"];
        self.status = dict[@"Status"];
        self.useTime = dict[@"UseTime"];
        self.siteMeal = dict[@"SiteMeal"];
        self.setMeal = dict[@"SetMeal"];
        self.discountsAmount = [dict[@"DiscountsAmount"] doubleValue];
        self.totalAmount = [dict[@"TotalAmount"] doubleValue];
        self.payAmount = [dict[@"PayAmount"] doubleValue];
        
    }
    return self;
}

+ (WSFBusinessBrDetailApiModel *)modelFromDict:(NSDictionary *)dict
{
    WSFBusinessBrDetailApiModel *model = [[WSFBusinessBrDetailApiModel alloc] initWithDict:dict];
    return model;
}

+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array
{
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i<mutableArray.count; i++) {
        NSDictionary *dic = mutableArray[i];
        WSFBusinessBrDetailApiModel *model = [WSFBusinessBrDetailApiModel modelFromDict:dic];
        [mutableArray replaceObjectAtIndex:i withObject:model];
    }
    return mutableArray;
}

@end
