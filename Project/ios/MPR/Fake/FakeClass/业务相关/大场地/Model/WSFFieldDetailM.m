//
//  WSFFieldDetailM.m
//  WinShare
//
//  Created by GZH on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldDetailM.h"
#import "SpacePhotoModel.h"
#import "SpaceGoodsModel.h"
#import "WSFFieldFieldM.h"
@implementation WSFFieldDetailM


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
        self.address = dict[@"Address"];
        self.photosArray = [SpacePhotoModel getModelArrayFromModelArray:dict[@"Photos"]];
        self.lng = [dict[@"Long"] doubleValue];
        self.lat = [dict[@"Lat"] doubleValue];
        self.regionCode = dict[@"RegionCode"];
        self.roomShareUrl = dict[@"RoomShareUrl"];
        self.setMealModelArray = [MTLJSONAdapter modelsOfClass:WSFFieldFieldM.class fromJSONArray:dict[@"SetMeals"] error:nil];
    }
    return self;
}

+ (WSFFieldDetailM*)modelFromDict:(NSDictionary*)dict
{
    WSFFieldDetailM *detailModel = [[WSFFieldDetailM alloc] initWithDict:dict];
    return detailModel;
}

+ (NSMutableArray*)getModelArrayFromModelArray:(NSArray*)array
{
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i<mutableArray.count; i++) {
        NSDictionary *dic = mutableArray[i];
        WSFFieldDetailM *model = [WSFFieldDetailM modelFromDict:dic];
        [mutableArray replaceObjectAtIndex:i withObject:model];
    }
    return mutableArray;
}

@end
