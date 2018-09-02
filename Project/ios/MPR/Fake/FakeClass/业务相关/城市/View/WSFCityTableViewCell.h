//
//  WSFCityTableViewCell.h
//  WinShare
//
//  Created by GZH on 2017/12/25.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CityNameBlack)(NSString *cityName);
@interface WSFCityTableViewCell : UITableViewCell
/**  将选中的城市回调回去 */
@property (nonatomic, strong) CityNameBlack cityNameBlack;
/** 当前地点的信息 */
@property (nonatomic, copy) CLPlacemark *placemark;
@end
