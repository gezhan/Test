//
//  MapViewManager.m
//  WinShare
//
//  Created by GZH on 2017/10/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "MapViewManager.h"

@interface MapViewManager ()<BMKMapViewDelegate>

@end

@implementation MapViewManager

+ (MapViewManager *) shareMapViewInstance {
    
    static MapViewManager *mapManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mapManager = [[self alloc]init];
    });
    return mapManager;
}

- (BMKMapView *)getMapView {
    if (_mapView == nil) {
        _mapView = [[BMKMapView alloc]init];
    }
    return _mapView;
}

- (BMKMapView *)getMapVCView {
    if (_mapVCView == nil) {
        _mapVCView = [[BMKMapView alloc]init];
    }
    return _mapVCView;
}

@end
