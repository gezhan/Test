//
//  WSFFieldVM.m
//  WinShare
//
//  Created by GZH on 2018/1/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldVM.h"
#import "WSFFieldModel.h"

@implementation WSFFieldCellVM

@end

@implementation WSFFieldVM


- (void)refershHomePageTModel:(WSFFieldModel *)homeModel {
    if(self.dataSource.count > 0)[self.dataSource removeAllObjects];
    for (int i = 0; i < homeModel.records.count; i++) {
        WSFFieldListModel *listModel = homeModel.records[i];
        WSFFieldCellVM *model = [[WSFFieldCellVM alloc]init];
        model.roomId = listModel.roomId;
        model.roomName = listModel.roomName;
        model.address = listModel.address;
        model.price = listModel.price;
        model.theMeter = [NSString stringWithFormat:@"%@  |", [NSString distanceSizeFormatWithOriginMeter:listModel.theMeter]];
        model.roomType = listModel.roomType;
        model.capacity = [NSString stringWithFormat:@"%ld人会议室  |", (long)listModel.capacity];
        model.path = listModel.picture.path;
        model.uRL = listModel.picture.uRL;
        [self.dataSource addObject:model];
    }
}

- (void)addHomePageTModel:(WSFFieldModel *)homeModel{
    for (int i = 0; i < homeModel.records.count; i++) {
        WSFFieldListModel *listModel = homeModel.records[i];
        WSFFieldCellVM *model = [[WSFFieldCellVM alloc]init];
        model.roomId = listModel.roomId;
        model.roomName = listModel.roomName;
        model.address = listModel.address;
        model.price = listModel.price;
        model.theMeter = [NSString stringWithFormat:@"%@  |", [NSString distanceSizeFormatWithOriginMeter:listModel.theMeter]];
        model.roomType = listModel.roomType;
        model.capacity = [NSString stringWithFormat:@"%ld人会议室  |", (long)listModel.capacity];
        model.path = listModel.picture.path;
        model.uRL = listModel.picture.uRL;
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



@end
