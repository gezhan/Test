//
//  WSFHomePageTVVM.h
//  WinShare
//
//  Created by GZH on 2018/1/22.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
@class WSFHomePageTVModel;

@interface WSFHomePageCellVM : NSObject
/**  空间ID */
@property (nonatomic, strong) NSString *roomId;
/**  空间名称 */
@property (nonatomic, strong) NSString *roomName;
/**  地址 */
@property (nonatomic, strong) NSString *address;
/**  价格 */
@property (nonatomic, strong) NSNumber *price;
/**  距离(单位/米) */
@property (nonatomic, strong) NSString *theMeter;
/**  空间类别 */
@property (nonatomic, strong) NSString *roomType;
/**  可容纳人数 */
@property (nonatomic, strong) NSString *capacity;
/**  实际路径 */
@property (nonatomic, strong) NSString *path;
/**  缩略图地址 */
@property (nonatomic, strong) NSString *uRL;
/**  跳转类型Id（1->小包厢/2->大场地;）*/
@property (nonatomic, assign) NSInteger jumpTypeKey;
/**  跳转类型（小包厢/大场地/链接）  */
@property (nonatomic, strong) NSString *jumpTypeValue;
/**  当前经纬度  */
@property (nonatomic, assign) CLLocationCoordinate2D coor;

@end

@interface WSFHomePageTVVM : MTLModel

/**  cell上边数据的数据源 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  下拉刷新
 *  homeModel  当前数据
 *  coor       当前经纬度
 */
- (void)refershHomePageTModel:(WSFHomePageTVModel *)homeModel coordinate:(CLLocationCoordinate2D )coor;
/**
 *  上拉加载
 */
- (void)addHomePageTModel:(WSFHomePageTVModel *)homeModel coordinate:(CLLocationCoordinate2D )coor;


@end
