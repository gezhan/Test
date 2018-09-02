//
//  WSFSpaceMapView.m
//  WinShare
//
//  Created by GZH on 2017/12/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFSpaceMapView.h"
#import "BaiduHeader.h"
#import "MapPositionManager.h"
#import "MapViewManager.h"
#import "WSFSpaceMapPositionView.h"
#import "CustormPointAnnotation.h"

#define zoomLEVEl 15.0   //地图比例尺级别

@interface WSFSpaceMapView ()<BMKMapViewDelegate, BMKLocationServiceDelegate>
/**  地图View */
@property (nonatomic, strong) BMKMapView *mapView;
/**  定位 */
@property (nonatomic, strong) BMKLocationService *locService;
/**  需要显示的地址名称 */
@property (nonatomic, strong) NSString *address;
/**  需要显示的地址的经纬度  */
@property (nonatomic, assign) CLLocationCoordinate2D currentCoordinate;
/**  用户的经纬度 */
@property (nonatomic, assign) CLLocationCoordinate2D userCoordinate;
/**  地图上边的paopaoView */
@property (nonatomic, strong) WSFSpaceMapPositionView *positionView;
/**  是否点击重新定位的按钮 */
@property (nonatomic, assign) BOOL isRePosition;
@end

@implementation WSFSpaceMapView
- (instancetype)initWithFrame:(CGRect)frame currentAddress:(NSString *)address currentCoor:(CLLocationCoordinate2D)coor{
    self = [super initWithFrame:frame];
    if (self) {
        _address = address;
        _currentCoordinate = coor;
        [self setContentView];
    }
    return self;
}
- (void)setContentView {
    if ([MapViewManager shareMapViewInstance].mapView) {
        _mapView = [[MapViewManager shareMapViewInstance] mapView];
    }else {
        _mapView = [[MapViewManager shareMapViewInstance] getMapView];
    }
    _mapView.delegate = self;
    [self addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_mapView setMapType:BMKMapTypeStandard];
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.zoomLevel = zoomLEVEl;
    
    BMKLocationViewDisplayParam *testParam = [[BMKLocationViewDisplayParam alloc] init];
    testParam.isAccuracyCircleShow = false;// 精度圈是否显示
    testParam.locationViewImgName = @"icon_center_point";// 定位图标名称
    testParam.locationViewOffsetX = 0;
    testParam.locationViewOffsetY = 0;
    testParam.canShowCallOut = NO;
    [_mapView updateLocationViewWithParam:testParam];
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    
    
    [_locService startUserLocationService];
    [self addPointAnnotation];
}
/**  开始定位 */
- (void)startLocationServiceAction {
    _isRePosition = YES;
    [_locService startUserLocationService];
}
/**  添加标注 */
- (void)addPointAnnotation {
    if(_mapView.annotations.count > 0) [_mapView removeAnnotations:_mapView.annotations];
    CustormPointAnnotation *annotation = [[CustormPointAnnotation alloc]init];
    annotation.coordinate = _currentCoordinate;
    annotation.title = @"";
    annotation.subtitle = @"";
    [_mapView addAnnotation:annotation];
    [_mapView selectAnnotation:annotation animated:NO];
    _mapView.centerCoordinate = _currentCoordinate;
}
#pragma mark BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [_mapView updateLocationData:userLocation];
    [_locService stopUserLocationService];
    if(_isRePosition == YES) _mapView.centerCoordinate = userLocation.location.coordinate, _isRePosition = NO;
}
//初始化标注
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[CustormPointAnnotation class]]) {
        BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"cell"];
        if (annotationView == nil) {
            annotationView = [[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"cell"];
        }
        annotationView.canShowCallout = YES;
        annotationView.image = [UIImage imageNamed:@"didian"];
        if (_positionView == nil) {
            _positionView = [[WSFSpaceMapPositionView alloc]initWithFrame:CGRectMake(24, 0, SCREEN_WIDTH - 48, 55)];
            _positionView.label.text = _address;
        }
        BMKActionPaopaoView *pView =  [[BMKActionPaopaoView alloc]initWithCustomView:_positionView];
        annotationView.paopaoView = nil;
        annotationView.paopaoView = pView;
        return annotationView;
    }
    return nil;
}



-  (void)dealloc {
    _mapView.delegate = nil;
    _locService.delegate = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
