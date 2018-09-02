//
//  ViewOfBaiduMap.m
//  WinShare
//
//  Created by GZH on 2017/5/2.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ViewOfBaiduMap.h"
#import "AppDelegate.h"
#import "MapViewManager.h"

@interface ViewOfBaiduMap ()<BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate,BMKMapViewDelegate>

/**  标注 */
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) BMKPointAnnotation *annotation;

@end

@implementation ViewOfBaiduMap

- (void)setCoor:(CLLocationCoordinate2D)coor
{
    _coor = coor;
    self.annotation.coordinate = coor;
    if (_mapView.annotations > 0) {
        [self.mapView removeAnnotations:_mapView.annotations];
    }
    [self.mapView addAnnotation:self.annotation];
    [self.mapView setCenterCoordinate:coor animated:NO];
}

- (void)setLocationAddress:(NSString *)locationAddress {
    _locationAddress = locationAddress;
    self.locationLabel.text = locationAddress;
   
    [self setHeightBlock:_heightBlock];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        [self setupViewContent];
        
    }
    return self;
}

- (void)setupViewContent
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    titleLabel.text = @"位置信息";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
    }];

    if ([MapViewManager shareMapViewInstance].mapView) {
        _mapView = [[MapViewManager shareMapViewInstance] mapView];
    }else {
        _mapView = [[MapViewManager shareMapViewInstance] getMapView];
    }
    _mapView.delegate = self;
    [self addSubview:_mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 180));
    }];
    
    //类型--> 标准地图
    [self.mapView setMapType:BMKMapTypeStandard];
    
    self.mapView.zoomLevel=15;
    
    //给定经纬度定位到该位置，并显示大头针
    self.annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 30.239708;
    coor.longitude = 120.215866;
    self.annotation.coordinate = coor;
    [self.mapView addAnnotation:self.annotation];
    [self.mapView setCenterCoordinate:coor animated:NO];

    self.locationLabel = [[UILabel alloc] init];
    self.locationLabel.font = [UIFont systemFontOfSize:16];
    self.locationLabel.numberOfLines = 0;
    self.locationLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.locationLabel.text = @"江干区钱江新城迪凯银座1100";
    [self addSubview:self.locationLabel];
    __weak typeof(self) weakSelf = self;
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(weakSelf.mapView.mas_bottom).offset(10);
        make.right.mas_equalTo(weakSelf.mapView.mas_right).offset(0);
    }];

}

//初始化标注
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"cell"];
        if (annotationView == nil) {
            annotationView = [[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"cell"];
        }
        annotationView.frame=CGRectMake(0, 0, 27, 36);
        annotationView.image = [UIImage imageNamed:@"didian"];
        annotationView.canShowCallout = YES;
        
        return annotationView;
    }
    return nil;
    
}


- (void)setHeightBlock:(HeightBlock)heightBlock {
    _heightBlock = heightBlock;

    CGRect rect = [self.locationLabel getFrameWithFreeHight:CGPointMake(0, 0) maxWidth:SCREEN_WIDTH-20];
    
    if(_heightBlock)_heightBlock(235 + rect.size.height);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)dealloc {
    _mapView.delegate = nil;
}

@end
