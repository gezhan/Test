//
//  SpaceMessageModel.h
//  WinShare
//
//  Created by QIjikj on 2017/5/3.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SpacePhotoModel;

@interface SpaceMessageModel : NSObject

@property (nonatomic, copy) NSString *spaceId;
@property (nonatomic, assign) NSInteger theMeter;
@property (nonatomic, copy) NSString *roomName;
@property (nonatomic, copy) NSString *roomType;
@property (nonatomic, assign) NSInteger capacity;
@property (nonatomic, assign) NSInteger areaSize;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, copy) NSString *spaceDescription;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) NSArray <SpacePhotoModel *> *photosArray;
@property (nonatomic, assign) double lng;
@property (nonatomic, assign) double lat;
@property (nonatomic, copy) NSString *regionCode;
@property (nonatomic, copy) NSString *openTime;
@property (nonatomic, copy) NSString *closeTime;
@property (nonatomic, assign) BOOL waitOnline;//等待上线（ture-即将上线，false-已经上线）
/**  同一个经纬度有多个空间位置时候的model数组 */
@property (nonatomic, strong) NSMutableArray<SpaceMessageModel*> *pointCollectionArray;

- (instancetype)initWithDict:(NSDictionary*)dict;

+ (SpaceMessageModel*)modelFromDict:(NSDictionary*)dict;
+ (NSMutableArray*)getModelArrayFromModelArray:(NSArray*)array;

+ (NSMutableArray *)getModelArrayForMapFromModelArray:(NSMutableArray *)array;

@end


















