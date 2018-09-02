//
//  ViewOfBaiduMap.h
//  WinShare
//
//  Created by GZH on 2017/5/2.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaiduHeader.h"

typedef void(^HeightBlock)(CGFloat);

@interface ViewOfBaiduMap : UIView

@property (nonatomic, strong) BMKMapView *mapView;

//经度
@property (nonatomic, assign) CLLocationCoordinate2D coor;

//地址
@property (nonatomic, strong) NSString *locationAddress;

@property (nonatomic, copy)HeightBlock heightBlock;

@end
