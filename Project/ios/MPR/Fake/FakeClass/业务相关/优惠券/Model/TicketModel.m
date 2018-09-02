//
//  TicketModel.m
//  WinShare
//
//  Created by GZH on 2017/5/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "TicketModel.h"

@implementation TicketModel

- (instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        
        self.couponId = dict[@"CouponId"];
        self.couponName = dict[@"Name"];
        self.couponCode = dict[@"CouponCode"];
        self.profileId = dict[@"ProfileId"];
        
        self.amount = [dict[@"Amount"] doubleValue];
        self.amountType = dict[@"AmountType"];
        self.limits = dict[@"Limits"];
        self.limitAmount = dict[@"LimitAmount"];
        self.isUsed = [dict[@"IsUsed"] boolValue];
        self.isOverdue = [dict[@"IsOverdue"] boolValue];
        self.isCanUse = [dict[@"IsCanUse"] boolValue];
        
        self.createTime = dict[@"CreateTime"];
        self.endTime = dict[@"EndTime"];
        
    }
    return self;
}

+ (TicketModel *)modelFromDict:(NSDictionary*)dict
{
    TicketModel *model = [[TicketModel alloc] initWithDict:dict];
    return model;
}

+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array
{
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i<mutableArray.count; i++) {
        NSDictionary *dic = mutableArray[i];
        TicketModel *model = [TicketModel modelFromDict:dic];
        [mutableArray replaceObjectAtIndex:i withObject:model];
    }
    return mutableArray;
}

@end
