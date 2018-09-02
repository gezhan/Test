//
//  PositionLocationView.m
//  WinShare
//
//  Created by GZH on 2017/5/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "PositionLocationView.h"
#import "PositionLocationVC.h"

@interface PositionLocationView ()
@property (nonatomic, strong) CLGeocoder *geocoder;  //实现经纬度和地址的互换
@end

@implementation PositionLocationView


-(CLGeocoder *)geocoder {
    if (_geocoder==nil) {
        _geocoder=[[CLGeocoder alloc]init];
    }
    return _geocoder;
}


- (void)setLocationStr:(NSString *)locationStr {
    _locationStr = locationStr;
    _locationLabel.text = locationStr;
}



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIView *backView = [UIView Z_createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) colorStr:nil];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(translucentBackgroundBtn)];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.4;
        [backView addGestureRecognizer:tap];
        [self addSubview:backView];

        
        
        UIView *view = [UIView Z_createViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) colorStr:@"#ffffff"];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToVCAction)];
        [view addGestureRecognizer:tap1];
        [self addSubview:view];
        [view addSubview:self.locationImage];
        [view addSubview:self.locationLabel];
        [view addSubview:self.signImage];
        
    }
    return self;
}

- (UIImageView *)locationImage {
    if (_locationImage == nil) {
        self.locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 13, 15)];
        _locationImage.image = [UIImage imageNamed:@"dibiao"];
    }
    return _locationImage;
}

- (UILabel *)locationLabel {
    if (_locationLabel == nil) {
        self.locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(_locationImage.right + 10, 0, SCREEN_WIDTH - _locationImage.right - 10 - 30, 45)];
        _locationLabel.text = @"杭州市";
    }
    return _locationLabel;
}

- (UIImageView *)signImage {
    if (_signImage == nil) {
        self.signImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 9, 15, 9, 16)];
        _signImage.image = [UIImage imageNamed:@"xiangyou"];
    }
    return _signImage;
}


- (void)pushToVCAction {
    PositionLocationVC *positionVC = [[PositionLocationVC alloc]init];
    positionVC.positionBlock = ^(NSString *str, CLLocationCoordinate2D coor) {
        if(_backBlock)_backBlock(str, coor);
    };
    positionVC.locationStr = _locationLabel.text;
    [self.viewController.navigationController pushViewController:positionVC animated:NO];
}

- (void)translucentBackgroundBtn {
    [self.geocoder geocodeAddressString:_locationLabel.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *pl = [placemarks firstObject];
        CLLocationCoordinate2D coor;
        coor.latitude = pl.location.coordinate.latitude;
        coor.longitude = pl.location.coordinate.longitude;
        

        if(_backBlock)_backBlock(_locationLabel.text, coor);
    }];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
