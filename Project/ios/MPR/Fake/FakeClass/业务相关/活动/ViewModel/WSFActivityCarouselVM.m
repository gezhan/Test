//
//  WSFActivityCarouselVM.m
//  WinShare
//
//  Created by GZH on 2018/3/9.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityCarouselVM.h"
#import "WSFRPCarouselSetApiModel.h"
@implementation WSFActivityCarouselM

@end

@implementation WSFActivityCarouselVM

- (instancetype)initWithCarouselModelArray:(NSArray<WSFRPCarouselSetApiModel*> *)carouselModelArray {
    self = [super init];
    if (self) {
        
        for (int i = 0; i < carouselModelArray.count; i++) {
            WSFRPCarouselSetApiModel *carouselVM = carouselModelArray[i];
            WSFActivityCarouselM *carouselM = [[WSFActivityCarouselM alloc]init];
            carouselM.picture = [NSString replaceString:carouselVM.picture.path];
            carouselM.Id = carouselVM.Id;
            carouselM.jumpTypeValue = carouselVM.jumpType.value;
            carouselM.jumpTypeKey = carouselVM.jumpType.key;
            carouselM.jumpRoomId = carouselVM.jumpRoomId;
            carouselM.jumpRoomName = carouselVM.jumpRoomName;
            carouselM.jumpUrl = carouselVM.jumpUrl;
            carouselM.sort = carouselVM.sort;
            [self.photosUrlArray addObject:carouselM.picture];
            [self.dataSource addObject:carouselM];
        }
        
    }
    return self;
}

- (NSMutableArray *)photosUrlArray {
    if (_photosUrlArray == nil) {
        _photosUrlArray = [NSMutableArray array];
    }
    return _photosUrlArray;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
