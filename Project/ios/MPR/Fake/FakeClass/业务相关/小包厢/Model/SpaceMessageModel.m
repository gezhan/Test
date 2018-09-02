//
//  SpaceMessageModel.m
//  WinShare
//
//  Created by QIjikj on 2017/5/3.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "SpaceMessageModel.h"
#import "SpacePhotoModel.h"

@implementation SpaceMessageModel

- (instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        
        self.spaceId = dict[@"Id"];
        self.theMeter = [dict[@"TheMeter"] integerValue];
        self.roomName = dict[@"RoomName"];
        self.roomType = dict[@"RoomType"];
        self.capacity = [dict[@"Capacity"] integerValue];
        self.areaSize = [dict[@"AreaSize"] integerValue];
        self.price = [dict[@"Price"] integerValue];
        self.spaceDescription = dict[@"Description"];
        self.tel = dict[@"Tel"];
        self.address = dict[@"Address"];
        self.photosArray = [SpacePhotoModel getModelArrayFromModelArray:dict[@"Photos"]];
        self.lng = [dict[@"Long"] doubleValue];
        self.lat = [dict[@"Lat"] doubleValue];
        self.regionCode = dict[@"RegionCode"];
        self.openTime = dict[@"OpenTime"];
        self.closeTime = dict[@"CloseTime"];
        self.waitOnline = [dict[@"WaitOnline"] boolValue];
        
    }
    return self;
}

+ (SpaceMessageModel*)modelFromDict:(NSDictionary*)dict
{
    SpaceMessageModel *spaceMessageModel = [[SpaceMessageModel alloc] initWithDict:dict];
    return spaceMessageModel;
}

+ (NSMutableArray*)getModelArrayFromModelArray:(NSArray*)array
{
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i<mutableArray.count; i++) {
        NSDictionary *dic = mutableArray[i];
        SpaceMessageModel *model = [SpaceMessageModel modelFromDict:dic];
        [mutableArray replaceObjectAtIndex:i withObject:model];
    }
    return mutableArray;
}

+ (NSMutableArray*)getModelArrayForMapFromModelArray:(NSMutableArray *)array {
    
    NSMutableArray *allPointArray = [NSMutableArray array];
    //将model数据 ->相同经纬度的点添加到一个数组中
    NSMutableArray *pointCountArray = [NSMutableArray array];
    for (SpaceMessageModel *model in array) {
        if (![allPointArray containsObject:model] && ![pointCountArray containsObject:model]) {
            if(![allPointArray containsObject:model])[allPointArray addObject:model];
            
            if(pointCountArray.count > 0)[pointCountArray removeAllObjects];
            for (SpaceMessageModel *modelX in array) {
                if (model.lat == modelX.lat && model.lng == modelX.lng) {
                    if(![pointCountArray containsObject:model])[pointCountArray addObject:model];
                    if(![pointCountArray containsObject:modelX])[pointCountArray addObject:modelX];
                }
            }
            
//            if (![allPointArray containsObject:model] && ![pointCountArray containsObject:model]) {
//                [allPointArray addObject:model];
//            }

            model.pointCollectionArray = pointCountArray.mutableCopy;
            if(allPointArray.count == 10) break;
        }
    }
    return allPointArray;
}


@end
