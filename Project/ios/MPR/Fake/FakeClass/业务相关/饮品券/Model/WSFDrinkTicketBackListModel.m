//
//  WSFDrinkTicketBackListModel.m
//  WinShare
//
//  Created by devRen on 2017/10/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDrinkTicketBackListModel.h"

@implementation WSFDrinkTicketBackAPIModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _couponId = dict[@"CouponId"];
        _name = dict[@"Name"];
        _amount = [dict[@"Amount"] doubleValue];
        _limits = dict[@"Limits"];
        _backTime = dict[@"BackTime"];
    }
    return self;
}

+ (NSArray<WSFDrinkTicketBackAPIModel *> *)drinkTicketBackAPIModelWithArray:(NSArray *)array {
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in array) {
        [modelArray addObject:[[WSFDrinkTicketBackAPIModel alloc] initWithDict:dict]];
    }
    return modelArray;
}

@end

@implementation WSFDrinkTicketTotalAmountAPIModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _month = [dict[@"Key"] integerValue];
        _total = dict[@"Value"];
    }
    return self;
}

+ (NSArray<WSFDrinkTicketTotalAmountAPIModel *> *)drinkTicketTotalAmountAPIModelWithArray:(NSArray *)array {
    NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in array) {
        [modelArray addObject:[[WSFDrinkTicketTotalAmountAPIModel alloc] initWithDict:dict]];
    }
    return modelArray;
}

@end

@implementation WSFDrinkTicketBackListModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _pageSize = [dict[@"PageSize"] integerValue];
        _pageIndex = [dict[@"PageIndex"] integerValue];
        _totalCount = [dict[@"TotalCount"] integerValue];
        _totalAmount = [WSFDrinkTicketTotalAmountAPIModel drinkTicketTotalAmountAPIModelWithArray:dict[@"TotalAmount"]];
        _records = [WSFDrinkTicketBackAPIModel drinkTicketBackAPIModelWithArray:dict[@"Records"]];
    }
    return self;
}

@end
