//
//  WSFCityChooseVC.h
//  WinShare
//
//  Created by GZH on 2017/12/19.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFBaseViewController.h"

typedef void(^CityNameBlack)(NSString *cityName);
@interface WSFCityChooseVC : WSFBaseViewController
/**  将选中的城市回调回去 */
@property (nonatomic, strong) CityNameBlack cityNameBlack;
@end
