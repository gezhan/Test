//
//  WSFCityTableView.h
//  WinShare
//
//  Created by GZH on 2017/12/19.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSFCityViewModel;

typedef void(^CityNameBlack)(NSString *cityName);

@interface WSFCityTableView : UITableView
/**  数据源 */
@property (nonatomic, strong) WSFCityViewModel *viewModel;
/** 当前地点的信息 */
@property (nonatomic, copy) CLPlacemark *placemark;
/**  将选中的城市回调回去 */
@property (nonatomic, strong) CityNameBlack cityNameBlack;
@end
