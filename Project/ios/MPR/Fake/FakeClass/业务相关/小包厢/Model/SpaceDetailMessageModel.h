//
//  SpaceDetailMessageModel.h
//  WinShare
//
//  Created by QIjikj on 2017/5/10.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SpacePhotoModel;
@class SpaceGoodsModel;
@class WSFSetMealModel;

typedef NS_ENUM(NSUInteger, SpaceOperatetype){
    SpaceOreratetypeSelf = 0,
    SpaceOreratetypeJoint
};

@interface SpaceDetailMessageModel : NSObject

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
@property (nonatomic, assign) SpaceOperatetype operatetype;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) NSArray <SpacePhotoModel *> *photosArray;
@property (nonatomic, assign) double lng;
@property (nonatomic, assign) double lat;
@property (nonatomic, copy) NSString *regionCode;
@property (nonatomic, copy) NSString *openTime;
@property (nonatomic, copy) NSString *closeTime;
@property (nonatomic, assign) BOOL waitOnline;//等待上线（ture-即将上线，false-已经上线）
@property (nonatomic, assign) NSInteger minimum;// 起订金额
@property (nonatomic, copy) NSString *roomShareUrl;// 空间分享地址
@property (nonatomic, strong) NSArray <WSFSetMealModel *> *setMealModelArray;// 套餐

- (instancetype)initWithDict:(NSDictionary*)dict;

+ (SpaceDetailMessageModel*)modelFromDict:(NSDictionary*)dict;
+ (NSMutableArray*)getModelArrayFromModelArray:(NSArray*)array;

@end
