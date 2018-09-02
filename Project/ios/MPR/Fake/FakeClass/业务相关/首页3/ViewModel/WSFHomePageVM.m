//
//  WSFHomePageVM.m
//  WinShare
//
//  Created by GZH on 2018/1/19.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFHomePageVM.h"
#import "WSFHomePageHotModel.h"
#import "WSFRPKeyValueStrModel.h"
#import "WSFRPKeyValueStrModel.h"
#import "WSFRPPhotoApiModel.h"

@implementation WSFHomePageCarouselItemVM

@end

@implementation WSFHomePageHotRoomVM

@end

@implementation WSFHomePageVM

- (instancetype)initWithHomePageModel:(WSFHomePageHotModel *)homeModel {
    self = [super init];
    if (self) {
    
        //轮播
        for (int i = 0; i < homeModel.carousel.count; i++) {
            WSFHomePageCarouselModel *carouseM = homeModel.carousel[i];
            WSFHomePageCarouselItemVM *itemVM = [[WSFHomePageCarouselItemVM alloc]init];
            itemVM.Id = carouseM.Id;
            itemVM.jumpRoomId = carouseM.jumpRoomId;
            itemVM.jumpUrl = carouseM.jumpUrl;
            itemVM.sort = carouseM.sort;
            itemVM.picture = [NSString replaceString:carouseM.picture.path];
            itemVM.jumpTypeKey = carouseM.jumpType.key;
            itemVM.jumpTypeValue = carouseM.jumpType.value;
            [self.carouselArray addObject:itemVM];
        }
        
        //热门空间
        for (int i = 0; i < homeModel.hotRoom.count; i++) {
            WSFHomePageHotRoomModel *hotRoomM = homeModel.hotRoom[i];
            WSFHomePageHotRoomVM *itemVM = [[WSFHomePageHotRoomVM alloc]init];
            itemVM.Id = hotRoomM.Id;
            itemVM.roomId = hotRoomM.roomId;
            itemVM.roomName = hotRoomM.roomName;
            itemVM.sort = hotRoomM.sort;
            if (hotRoomM.typeOfRoom.key == 1) {
                //小包厢
                itemVM.price = [NSString stringWithFormat:@"￥%@/h", hotRoomM.price];
            }else {
                //大场地
                itemVM.price = [NSString stringWithFormat:@"￥%@/场", hotRoomM.price];
            }
            itemVM.picture = [NSString replaceString:hotRoomM.picture.path];
            itemVM.typeOfRoomKey = hotRoomM.typeOfRoom.key;
            itemVM.typeOfRoomValue = hotRoomM.typeOfRoom.value;
            [self.hotRoomArray addObject:itemVM];
        }
    }
    return self;
}


- (NSMutableArray *)carouselArray {
    if (_carouselArray == nil) {
        _carouselArray = [NSMutableArray array];
    }
    return _carouselArray;
}
- (NSMutableArray *)hotRoomArray {
    if (_hotRoomArray == nil) {
        _hotRoomArray = [NSMutableArray array];
    }
    return _hotRoomArray;
}


@end
