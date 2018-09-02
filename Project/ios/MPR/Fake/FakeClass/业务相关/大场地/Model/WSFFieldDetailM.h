//
//  WSFFieldDetailM.h
//  WinShare
//
//  Created by GZH on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SpacePhotoModel;
@class SpaceGoodsModel;
@class WSFFieldFieldM;
@interface WSFFieldDetailM : NSObject
@property (nonatomic, copy) NSString *spaceId;
@property (nonatomic, copy) NSString *roomName;
@property (nonatomic, copy) NSString *roomType;
@property (nonatomic, assign) NSInteger theMeter;
@property (nonatomic, assign) NSInteger capacity;
@property (nonatomic, assign) NSInteger areaSize;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, copy) NSString *spaceDescription;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, strong) NSArray <SpaceGoodsModel *> *devicesArray;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) NSArray <SpacePhotoModel *> *photosArray;
@property (nonatomic, assign) double lng;
@property (nonatomic, assign) double lat;
@property (nonatomic, copy) NSString *regionCode;
@property (nonatomic, copy) NSString *roomShareUrl;// 空间分享地址
@property (nonatomic, strong) NSArray *fieldModelArray;//场次
@property (nonatomic, strong) NSArray <WSFFieldFieldM *> *setMealModelArray;// 套餐

- (instancetype)initWithDict:(NSDictionary*)dict;
+ (WSFFieldDetailM*)modelFromDict:(NSDictionary*)dict;
+ (NSMutableArray*)getModelArrayFromModelArray:(NSArray*)array;
@end
