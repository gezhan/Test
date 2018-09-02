//
//  MapViewManager.h
//  WinShare
//
//  Created by GZH on 2017/10/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaiduHeader.h"

@interface MapViewManager : NSObject

@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) BMKMapView *mapVCView;

/** 地图单例 */
+ (MapViewManager *) shareMapViewInstance;

/** view(PopViewOfBaidu)里边的地图view  */
- (BMKMapView *) getMapView;

/** vc(BaiduMapVC)里边的地图view  */
- (BMKMapView *) getMapVCView;

@end
