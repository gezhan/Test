//
//  WSFHomePageTVVM.m
//  WinShare
//
//  Created by GZH on 2018/1/22.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFHomePageTVVM.h"
#import "WSFHomePageTVModel.h"
#import "WSFRPKeyValueStrModel.h"
#import "WSFRPPhotoApiModel.h"

@implementation WSFHomePageCellVM

@end

@implementation WSFHomePageTVVM



- (void)refershHomePageTModel:(WSFHomePageTVModel *)homeModel coordinate:(CLLocationCoordinate2D )coor {
    if(self.dataSource.count > 0)[self.dataSource removeAllObjects];
    for (int i = 0; i < homeModel.records.count; i++) {
        WSFHomePageListModel *listModel = homeModel.records[i];
        WSFHomePageCellVM *model = [[WSFHomePageCellVM alloc]init];
        model.roomId = listModel.roomId;
        model.roomName = listModel.roomName;
        model.address = listModel.address;
        model.price = listModel.price;
        model.theMeter = [NSString stringWithFormat:@"%@  |", [NSString distanceSizeFormatWithOriginMeter:listModel.theMeter]];
        model.roomType = listModel.roomType;
        model.capacity = [NSString stringWithFormat:@"%ld人会议室  |", (long)listModel.capacity];
        model.path = listModel.picture.path;
        model.uRL = listModel.picture.uRL;
        model.jumpTypeKey = listModel.typeOfRoom.key;
        model.jumpTypeValue = listModel.typeOfRoom.value;
        model.coor = coor;
        [self.dataSource addObject:model];
    }
}

- (void)addHomePageTModel:(WSFHomePageTVModel *)homeModel coordinate:(CLLocationCoordinate2D )coor { 
    for (int i = 0; i < homeModel.records.count; i++) {
        WSFHomePageListModel *listModel = homeModel.records[i];
        WSFHomePageCellVM *model = [[WSFHomePageCellVM alloc]init];
        model.roomId = listModel.roomId;
        model.roomName = listModel.roomName;
        model.address = listModel.address;
        model.price = listModel.price;
        model.theMeter = [NSString stringWithFormat:@"%@  |", [NSString distanceSizeFormatWithOriginMeter:listModel.theMeter]];
        model.roomType = listModel.roomType;
        model.capacity = [NSString stringWithFormat:@"%ld人会议室  |", (long)listModel.capacity];
        model.path = listModel.picture.path;
        model.uRL = listModel.picture.uRL;
        model.jumpTypeKey = listModel.typeOfRoom.key;
        model.jumpTypeValue = listModel.typeOfRoom.value;
        model.coor = coor;
        [self.dataSource addObject:model];
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

//// 获取距离大小
//- (NSString *)distanceSizeFormatWithOriginMeter:(NSInteger)originMeter {
//    NSString *sizeUnitString;
//    float size = originMeter;
//    if(size < 1000){
//        sizeUnitString = [NSString stringWithFormat:@"%.1fm", size];
//    }else{
//
//        size /= 1000;
//        sizeUnitString = [NSString stringWithFormat:@"%.1fkm", size];
//    }
//    return sizeUnitString;
//}



@end
