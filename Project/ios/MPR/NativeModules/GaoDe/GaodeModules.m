//
//  GaodeModules.m
//  MPR
//
//  Created by HWC on 2018/5/11.
//  Copyright © 2018年 Facebook. All rights reserved.
//


#import "GaodeModules.h"
#import "RootGdVC.h"

@interface GaodeModules()
@property(nonatomic, strong)RootGdVC *gaode;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property(nonatomic, strong)UINavigationController *navi;
@end
@implementation GaodeModules
RCT_EXPORT_MODULE(GaodeModules)
//RN跳转原生界面
RCT_EXPORT_METHOD(RNGaoDe:(RCTResponseSenderBlock)callBack){
  dispatch_async(dispatch_get_main_queue(), ^{

    _gaode = [[RootGdVC alloc]init];
    _gaode.callBack = callBack;
    
    self.navi = [[UINavigationController alloc] initWithRootViewController:_gaode];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.navi animated:YES completion:nil];
    
  });
}

- (AMapLocationManager *)locationManager {
  if (!_locationManager) {
    _locationManager = [[AMapLocationManager alloc]init];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    _locationManager.locationTimeout = 10;
    _locationManager.reGeocodeTimeout = 10;
  }
  return _locationManager;
}

RCT_EXPORT_METHOD(SetLocation:(RCTResponseSenderBlock)callBack){
  
  // 带逆地理信息的一次定位（返回坐标和地址信息）
  [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
  //   定位超时时间，最低2s，此处设置为2s
  self.locationManager.locationTimeout =2;
  //   逆地理请求超时时间，最低2s，此处设置为2s
  self.locationManager.reGeocodeTimeout = 2;
  [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (error)
    {
      NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
      
      [dic setObject:@"0" forKey:@"status"];
      switch (error.code) {
        case AMapLocationErrorUnknown:
          [dic setObject:@"未知错误" forKey:@"msg"];
          callBack(@[dic]);
          break;
        case AMapLocationErrorLocateFailed:
          [dic setObject:@"定位错误" forKey:@"msg"];
          callBack(@[dic]);
          break;
        case AMapLocationErrorReGeocodeFailed:
          [dic setObject:@"逆地理错误" forKey:@"msg"];
          callBack(@[dic]);
          break;
        case AMapLocationErrorTimeOut:
          [dic setObject:@"超时" forKey:@"msg"];
          callBack(@[dic]);
          break;
        case AMapLocationErrorCanceled:
          [dic setObject:@"取消" forKey:@"msg"];
          callBack(@[dic]);
          break;
        case AMapLocationErrorCannotFindHost:
          [dic setObject:@"找不到主机" forKey:@"msg"];
          callBack(@[dic]);
          break;
        case AMapLocationErrorBadURL:
          [dic setObject:@"URL异常" forKey:@"msg"];
          callBack(@[dic]);
          break;
        case AMapLocationErrorNotConnectedToInternet:
          [dic setObject:@"连接异常" forKey:@"msg"];
          callBack(@[dic]);
          break;
        case AMapLocationErrorCannotConnectToHost:
          [dic setObject:@"服务器连接失败" forKey:@"msg"];
          callBack(@[dic]);
          break;
        case AMapLocationErrorRegionMonitoringFailure:
          [dic setObject:@"地理围栏错误" forKey:@"msg"];
          callBack(@[dic]);
          break;
        case  AMapLocationErrorRiskOfFakeLocation:
          [dic setObject:@"存在虚拟定位风险" forKey:@"msg"];
          callBack(@[dic]);
          break;
        default:
          break;
      }
      
    }
    
    NSLog(@"location:%@", location);
    
    if (regeocode)
    {
      [dic setObject:@"1" forKey:@"status"];
      [dic setObject:[NSString stringWithFormat:@"%@",regeocode.province] forKey:@"province"];
      [dic setObject:[NSString stringWithFormat:@"%@",regeocode.city] forKey:@"city"];
      [dic setObject:[NSString stringWithFormat:@"%@",regeocode.district] forKey:@"district"];
      [dic setObject:[NSString stringWithFormat:@"%6lf",(double)location.coordinate.latitude] forKey:@"latitude"];
      [dic setObject:[NSString stringWithFormat:@"%6lf",(double)location.coordinate.longitude] forKey:@"longitude"];
      NSString *street = [NSString stringWithFormat:@"%@%@%@",regeocode.street,regeocode.number,regeocode.POIName];
      [dic setObject:street forKey:@"street"];
      callBack(@[dic]);
      NSLog(@"reGeocode:%@", regeocode);
    }
  }];
  
}


@end
