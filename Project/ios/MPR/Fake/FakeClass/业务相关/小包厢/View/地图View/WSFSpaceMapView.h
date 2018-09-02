//
//  WSFSpaceMapView.h
//  WinShare
//
//  Created by GZH on 2017/12/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSFSpaceMapView : UIView

/**  
 * address： 需要展示的地址
 * coor   ： 当前需要展示的地址的经纬度
 */
- (instancetype)initWithFrame:(CGRect)frame currentAddress:(NSString *)address currentCoor:(CLLocationCoordinate2D)coor;

/**  开始定位 */
- (void)startLocationServiceAction;
@end
