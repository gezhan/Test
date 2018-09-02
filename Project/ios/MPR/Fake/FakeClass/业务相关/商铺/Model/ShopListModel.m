//
//  ShopListModel.m
//  WinShare
//
//  Created by QIjikj on 2017/7/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopListModel.h"
#import "SpacePhotoModel.h"

@implementation ShopListModel

- (instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        self.shopListModelType = [dict[@"TheType"][@"Key"] integerValue];
        self.roomId = dict[@"RoomId"];
        self.roomName = dict[@"RoomName"];
        self.roomType = dict[@"RoomType"];
        self.capacity = [dict[@"Capacity"] integerValue];
        self.areaSize = [dict[@"AreaSize"] integerValue];
        self.price = [dict[@"Price"] integerValue];
        self.address = dict[@"Address"];
        
        self.spacePhotoModel = [SpacePhotoModel modelFromDict:dict[@"Photo"]];
        
        self.incomeAmount = [dict[@"IncomeAmount"] doubleValue];
        self.expectedAmount = [dict[@"ExpectedAmount"] doubleValue];
        self.waitOnline = [dict[@"WaitOnline"] boolValue];
        
    }
    return self;
}

+ (ShopListModel *)modelFromDict:(NSDictionary *)dict
{
    ShopListModel *model = [[ShopListModel alloc] initWithDict:dict];
    return model;
}

+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array
{
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i<mutableArray.count; i++) {
        NSDictionary *dic = mutableArray[i];
        ShopListModel *model = [ShopListModel modelFromDict:dic];
        [mutableArray replaceObjectAtIndex:i withObject:model];
    }
    return mutableArray;
}


@end
