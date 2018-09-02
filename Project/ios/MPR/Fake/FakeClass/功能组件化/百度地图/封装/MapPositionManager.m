//
//  MapPositionManager.m
//  WinShare
//
//  Created by GZH on 2017/7/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "MapPositionManager.h"
typedef NS_ENUM(NSInteger, WSFFunctionClassType) {

    WSFFunctionClassType_default   = 0 ,
    WSFFunctionClassType_position      ,  //执行判断定位是否开启方法
    
};
@interface MapPositionManager ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate,BMKSuggestionSearchDelegate>
/**  定位是否开启的回调 */
@property (nonatomic, copy) void(^PositionBlock)(BOOL isOpen);
/**  定位开启时 返回定位经纬度 */
@property (nonatomic, copy) void(^locationBlock)(CLLocationCoordinate2D coordinate);
/**  定位开启时 返回反编码位置 */
@property (nonatomic, copy) void(^addressBlock)(CLPlacemark *placemark);
/**  定位开启时 返回POI检索信息的数组 */
@property (nonatomic, copy) void(^resultArray)(NSArray *array);
/**  城市关键字搜索的结果回调 */
@property (nonatomic, copy) void(^resultCityArray)(NSArray *array);
@property (nonatomic, assign) WSFFunctionClassType functionClassType;
//定位服务
@property (nonatomic, strong) BMKLocationService *locationService;
//附近位置检索对象
@property (nonatomic, strong) BMKPoiSearch *searcher;
//当前地点信息
@property (nonatomic, strong) CLPlacemark *placemark;
//城市的关键字搜索
@property (nonatomic, strong) BMKSuggestionSearch *sugSearch;
@end

@implementation MapPositionManager

+ (MapPositionManager *)sharedLocationManager{
    static MapPositionManager *locationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManager = [[self alloc]init];
    });
    return locationManager;
}

- (instancetype)init{
    self = [super init];
    if (self) {

        self.locationService = [[BMKLocationService alloc]init];
    }
    return self;
}

//开始定位
- (void)startLocationService {

    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
}

//结束定位
- (void)stopLocationService {
    
    self.locationService.delegate = nil;
    [self.locationService stopUserLocationService];
}

//判断定位功能是否开启
- (BOOL)judgePositionAction {
    //判断定位功能是否可用
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
        
        return YES;
        
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted){
        
        return NO;
    }
    return nil;
}

- (void)judgePositionWithBlock:(void (^)(BOOL))positionBlock {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        _functionClassType = WSFFunctionClassType_position;
        [self startLocationService];
        self.PositionBlock = positionBlock;
    }
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        if(positionBlock)positionBlock(YES);
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted){
        if(positionBlock)positionBlock(NO);
    }
}

#pragma mark - Public (公有方法)
//获取经纬度和反编码地理位置
- (void)getCoorinate:(void (^)(CLLocationCoordinate2D))coorHander
             address:(void (^)(CLPlacemark *))addressHander
               error:(ErrorBlock)errorBlock {
    
    if (!self.judgePositionAction) {
        if(errorBlock)errorBlock(PositioningShutDown);
        return;
    }
    
    [self startLocationService];
    self.locationBlock = coorHander;
    self.addressBlock = addressHander;
}

//获取当前地点的信息
- (void)getCurrentCityNameWithBlack:(void (^)(CLPlacemark *))cityNameBlack {
    if (_placemark) {
        if(cityNameBlack)cityNameBlack(_placemark);
    }else {
        [self getCoorinate:nil address:^(CLPlacemark *placemark) {
            _placemark = placemark;
            if(cityNameBlack)cityNameBlack(placemark);
        } error:nil];
    }
}

//输入关键字,返回POI搜索结果
- (void)getResultArrayWithKeyWordString:(NSString *) string
                           andPageIndex:(int) pageInde
                             pageNumber:(int) pageNumber
                                  array:(void (^)(NSArray<BMKPoiInfo *> *))array
                                  error:(ErrorBlock)errorBlock {
    if (!self.judgePositionAction) {
        if(errorBlock)errorBlock(PositioningShutDown);
        return;
    }
    //初始化检索对象
    self.searcher =[[BMKPoiSearch alloc]init];
    self.searcher.delegate = self;
    //发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = pageInde;
    option.pageCapacity = pageNumber;
    option.radius = 5000;
    self.resultArray = array;
    self.errorBlock = errorBlock;
    __weak typeof(self) weakSelf = self;
    [self getCoorinate:^(CLLocationCoordinate2D coordinate) {
        option.location = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
        option.keyword = string;
        BOOL flag = [weakSelf.searcher poiSearchNearBy:option];
        if(flag) {
            NSLog(@"关键字检索发送成功");
        }else {
            NSLog(@"关键字检索发送失败");
            if(errorBlock)errorBlock(ResultAbNormal_PARAMETER_ERROR);
        }
    } address:nil error:nil];    
}

//输入城市和关键字，搜索结果
- (void)getResultArrayWithCity:(NSString *)city
                 keyWordString:(NSString *) string
                         array:(void (^)(NSArray *array))array
                         error:(ErrorBlock)errorBlock {
    _sugSearch = [[BMKSuggestionSearch alloc]init];
    _sugSearch.delegate = self;
    BMKSuggestionSearchOption *option = [[BMKSuggestionSearchOption alloc]init];
    option.cityname = city;
    option.keyword  = string;
    self.resultCityArray = array;
    self.errorBlock = errorBlock;
    BOOL flag =  [_sugSearch suggestionSearch:option];
    if(flag) {
        NSLog(@"城市检索发送成功");
    }else {
        NSLog(@"城市检索发送失败");
        if(errorBlock)errorBlock(ResultAbNormal_PARAMETER_ERROR);
    }
}

//通过经纬度获取地理位置信息
- (void)getPositionWithCoordinatte:(CLLocationCoordinate2D)coordinate{
    CLLocation *location = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            _placemark = firstPlacemark;
            if (self.addressBlock) self.addressBlock(firstPlacemark);
        }
    }];
}

//传入经纬度获取反编码地理位置
- (void)getAddressWithCoorinate:(CLLocationCoordinate2D)coordinate
                        address:(void (^)(CLPlacemark *placemark))address
                          error:(ErrorBlock)errorBlock {
    CLLocation *location = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    //反地理编码
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0) {
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            if (address) address(firstPlacemark);
        }
    }];
}

//传入地理位置获对应经纬度
- (void)getCoderInfoWithAddress:(NSString *)address
                     coordinate:(void (^)(CLLocationCoordinate2D coor))coordinate
                          error:(ErrorBlock)errorBlock {
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *pl = [placemarks firstObject];
        CLLocationCoordinate2D coor;
        coor.latitude = pl.location.coordinate.latitude;
        coor.longitude = pl.location.coordinate.longitude;
        
        if(coordinate)coordinate(coor);
    }];
}

#pragma mark BMKLocationServiceDelegate
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error {
    //检索结果
    if (error == BMK_SEARCH_NO_ERROR) {
        if(self.resultArray)self.resultArray(poiResultList.poiInfoList);
    }else
        if (error == BMK_SEARCH_NETWOKR_ERROR || error == BMK_SEARCH_NETWOKR_TIMEOUT) {
            //网络连接错误
            if(self.errorBlock)self.errorBlock(ResultAbNormal_NETWOKR_ERROR);
        }else
            if (error == BMK_SEARCH_PARAMETER_ERROR) {
                //参数错误
                if(self.errorBlock)self.errorBlock(ResultAbNormal_PARAMETER_ERROR);
            }else{
                if(self.errorBlock)self.errorBlock(ResultAbNormal_UNKnown);
            }
    self.searcher.delegate = nil;
}

- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:(BMKSuggestionResult*)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        NSLog(@"%@", result);
        if(self.resultCityArray)self.resultCityArray(result.keyList);
    } else {
        NSLog(@"抱歉，未找到结果");
        if(self.errorBlock)self.errorBlock(ResultAbNormal_UNKnown);
    }
}

#pragma mark BMKLocationServiceDelegate---定位协议
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    if (_functionClassType == WSFFunctionClassType_position) {
        //定位成功回调YES
        if(self.PositionBlock)self.PositionBlock(YES);
        self.PositionBlock = nil;
         if(self.locationBlock)self.locationBlock(userLocation.location.coordinate);
        _functionClassType = WSFFunctionClassType_default;
    }else {
        //回调定位的经纬度
        if(self.locationBlock)self.locationBlock(userLocation.location.coordinate);
        //通过经纬度获取地理位置信息
        [self getPositionWithCoordinatte:userLocation.location.coordinate];
    }
    //获取一次成功之后就停止定位
    [self stopLocationService];
}

- (void)didFailToLocateUserWithError:(NSError *)error {
    //定位失败回调NO
    if(self.PositionBlock)self.PositionBlock(NO);
    self.PositionBlock = nil;
    _functionClassType = WSFFunctionClassType_default;
}



@end
