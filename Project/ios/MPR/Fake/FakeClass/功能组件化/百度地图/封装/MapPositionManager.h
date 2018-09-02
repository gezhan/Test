//
//  MapPositionManager.h
//  WinShare
//
//  Created by GZH on 2017/7/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaiduHeader.h"

typedef NS_ENUM(NSInteger, ErrorCode) {
    PositioningShutDown = 0,                  //定位功能未开启
    ResultAbNormal_NETWOKR_ERROR,            //网络连接错误
    ResultAbNormal_PARAMETER_ERROR,           //参数错误
    ResultAbNormal_UNKnown                     //未知错误
};

//回调失败原因
typedef void(^ErrorBlock)(ErrorCode);

@interface MapPositionManager : NSObject
@property (nonatomic, copy) ErrorBlock errorBlock;

//单例创建-------------------------------------------------------------

+ (MapPositionManager *)sharedLocationManager;

//-----基本功能---------------------------------------------------------

/**  判断定位功能是否可用--->>YES为可用，NO为不可用 */
- (void)judgePositionWithBlock:(void(^)(BOOL isOpen))positionBlock;


//------block回调-------------------------------------------------------
/**
  **---这里的方法只能一个调用完之后才能调用另一个
 */
/** 获取当前地点的信息 */
- (void)getCurrentCityNameWithBlack:(void (^)(CLPlacemark *placemark))cityNameBlack;

/**  获取经纬度和反编码地理位置---此方法先获取经纬度，再获取地址位置 */
- (void)getCoorinate:(void(^)(CLLocationCoordinate2D coordinate))coorHander address:(void(^)(CLPlacemark *placemark))addressHander error:(ErrorBlock)errorBlock;

/**  传入经纬度获取反编码地理位置--->反编码 */
- (void)getAddressWithCoorinate:(CLLocationCoordinate2D)coordinate
                        address:(void (^)(CLPlacemark *placemark))address
                          error:(ErrorBlock)errorBlock;

/**  传入地理位置获取经纬度--->编码 */
- (void)getCoderInfoWithAddress:(NSString *)address coordinate:(void (^)(CLLocationCoordinate2D coordinate))coordinate error:(ErrorBlock)errorBlock;



/**  输入关键字,返回POI搜索结果--返回的是检索出来的信息数组，存储的是SDK自带的model（BMKPoiInfo） */
/*
  **  string->关键字                             pageInde->分页索引，默认为0
  **  pageNumber->分页数量,默认为10，最多为50
 */
- (void)getResultArrayWithKeyWordString:(NSString *) string
                           andPageIndex:(int) pageInde
                             pageNumber:(int) pageNumber
                                  array:(void (^)(NSArray<BMKPoiInfo *> *))array
                                  error:(ErrorBlock)errorBlock;

/**  输入关键字,进行城市周边的关键字搜索 */
/*
 *  city   -> 城市
 *  string -> 关键字
 */
- (void)getResultArrayWithCity:(NSString *)city
                 keyWordString:(NSString *) string
                         array:(void (^)(NSArray *array))array
                         error:(ErrorBlock)errorBlock;


@end
