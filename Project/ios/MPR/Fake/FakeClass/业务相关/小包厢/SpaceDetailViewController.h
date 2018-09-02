//
//  SpaceDetailViewController.h
//  WinShare
//
//  Created by QIjikj on 2017/5/4.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFBaseViewController.h"

@interface SpaceDetailViewController : WSFBaseViewController

/** 空间id */
@property (nonatomic, copy) NSString *SpaceId;

/** 是否使用的筛选目的地 */
@property (nonatomic, assign) BOOL inScreen;
/** 筛选的目的地坐标 */
@property (nonatomic, assign) CLLocationCoordinate2D screenCoor;
/** 筛选的目的地名称 */
@property (nonatomic, copy) NSString *screenAddressStr;
@end
