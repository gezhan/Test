//
//  WSFSpaceMapVC.h
//  WinShare
//
//  Created by GZH on 2017/12/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFBaseViewController.h"
#import "BaiduHeader.h"
@interface WSFSpaceMapVC : WSFBaseViewController
/**  将要显示的地址 */
@property (nonatomic, strong) NSString *currentAddress;
/**  将要显示地址的经纬度 */
@property (nonatomic, assign) CLLocationCoordinate2D currentCoor;
@end
