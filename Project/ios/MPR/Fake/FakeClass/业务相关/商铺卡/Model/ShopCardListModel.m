//
//  ShopCardListModel.m
//  WinShare
//
//  Created by Gzh on 2017/9/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopCardListModel.h"

@implementation ShopCardListModel

- (instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        self.roomId = dict[@"RoomId"];
        self.roomName = dict[@"RoomName"];
        self.roomCardDuration = dict[@"RoomCardDuration"];
        self.roomCardLeaveMinutes = dict[@"RoomCardLeaveMinutes"];
        self.endContractTime = dict[@"EndContractTime"];
        
    }
    return self;
}

+ (ShopCardListModel *)modelFromDict:(NSDictionary *)dict
{
    ShopCardListModel *model = [[ShopCardListModel alloc] initWithDict:dict];
    return model;
}

+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array
{
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i<mutableArray.count; i++) {
        NSDictionary *dic = mutableArray[i];
        ShopCardListModel *model = [ShopCardListModel modelFromDict:dic];
        [mutableArray replaceObjectAtIndex:i withObject:model];
    }
    return mutableArray;
}

@end
