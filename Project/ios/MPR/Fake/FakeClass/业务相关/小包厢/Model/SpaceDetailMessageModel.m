//
//  SpaceDetailMessageModel.m
//  WinShare
//
//  Created by QIjikj on 2017/5/10.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "SpaceDetailMessageModel.h"
#import "SpacePhotoModel.h"
#import "SpaceGoodsModel.h"
#import "WSFSetMealModel.h"

@implementation SpaceDetailMessageModel

- (instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        
        self.spaceId = dict[@"Id"];
        self.roomName = dict[@"RoomName"];
        self.roomType = dict[@"RoomType"];
        self.theMeter = [dict[@"TheMeter"] integerValue];
        self.capacity = [dict[@"Capacity"] integerValue];
        self.areaSize = [dict[@"AreaSize"] integerValue];
        self.price = [dict[@"Price"] integerValue];
        self.spaceDescription = dict[@"Description"];
        self.tel = dict[@"Tel"];
        self.devicesArray = [SpaceGoodsModel getModelArrayFromModelArray:dict[@"DeviceItems"]];
        self.operatetype = [dict[@"OperateType"] integerValue];
        self.address = dict[@"Address"];
        self.photosArray = [SpacePhotoModel getModelArrayFromModelArray:dict[@"Photos"]];
        self.lng = [dict[@"Long"] doubleValue];
        self.lat = [dict[@"Lat"] doubleValue];
        self.regionCode = dict[@"RegionCode"];
        self.openTime = dict[@"OpenTime"];
        self.closeTime = dict[@"CloseTime"];
        self.waitOnline = [dict[@"WaitOnline"] boolValue];
        self.minimum = [dict[@"Minimum"] integerValue];
        self.roomShareUrl = dict[@"RoomShareUrl"];
        NSError *error = nil;
        self.setMealModelArray = [MTLJSONAdapter modelsOfClass:WSFSetMealModel.class fromJSONArray:dict[@"SetMeals"] error:&error];
        
    }
    return self;
}

+ (SpaceDetailMessageModel*)modelFromDict:(NSDictionary*)dict
{
    SpaceDetailMessageModel *spaceDetailMessageModel = [[SpaceDetailMessageModel alloc] initWithDict:dict];
    return spaceDetailMessageModel;
}

+ (NSMutableArray*)getModelArrayFromModelArray:(NSArray*)array
{
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i<mutableArray.count; i++) {
        NSDictionary *dic = mutableArray[i];
        SpaceDetailMessageModel *model = [SpaceDetailMessageModel modelFromDict:dic];
        [mutableArray replaceObjectAtIndex:i withObject:model];
    }
    return mutableArray;
}

@end
