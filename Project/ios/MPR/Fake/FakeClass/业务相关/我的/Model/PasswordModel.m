//
//  PasswordModel.m
//  WinShare
//
//  Created by GZH on 2017/5/25.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "PasswordModel.h"

@implementation PasswordModel


- (instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        
        self.RoomName = [dict[@"RoomName"] isEqual:[NSNull null]]? @"" : dict[@"RoomName"];
        self.OrderTime = [dict[@"OrderTime"] isEqual:[NSNull null]]? @"" : dict[@"OrderTime"];
        self.Password = [dict[@"Password"] isEqual:[NSNull null]]? @[] : dict[@"Password"];
       
    }
    return self;
}

+ (PasswordModel*)modelFromDict:(NSDictionary*)dict
{
    PasswordModel *model = [[PasswordModel alloc] initWithDict:dict];
    return model;
}

+ (NSMutableArray*)getModelArrayFromModelArray:(NSArray*)array
{
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i<mutableArray.count; i++) {
        NSDictionary *dic = mutableArray[i];
        PasswordModel *model = [PasswordModel modelFromDict:dic];
        [mutableArray replaceObjectAtIndex:i withObject:model];
    }
    return mutableArray;
}


@end
