//
//  WSFHomePageVM.h
//  WinShare
//
//  Created by GZH on 2018/1/19.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WSFHomePageHotModel;

/**
 * 轮播图
 */
@interface WSFHomePageCarouselItemVM : NSObject
/**  轮播位ID */
@property (nonatomic, strong) NSString *Id;
/**  跳转空间ID */
@property (nonatomic, strong) NSString *jumpRoomId;
/**  跳转链接地址 */
@property (nonatomic, strong) NSString *jumpUrl;
/**  排序索引（越大越前） */
@property (nonatomic, assign) NSInteger sort;
/**  图片  */
@property (nonatomic, strong) NSString *picture;
/**  跳转类型Id（1->小包厢/2->大场地;）  */
@property (nonatomic, assign) NSInteger jumpTypeKey;
/**  跳转类型（小包厢/大场地/链接）  */
@property (nonatomic, strong) NSString *jumpTypeValue;
@end

/**
 * 热门空间
 */
@interface WSFHomePageHotRoomVM : NSObject
/**  热门ID */
@property (nonatomic, strong) NSString *Id;
/**  空间ID */
@property (nonatomic, strong) NSString *roomId;
/**  空间名称 */
@property (nonatomic, strong) NSString *roomName;
/**  排序索引（越大越前） */
@property (nonatomic, assign) NSInteger sort;
/**  图片  */
@property (nonatomic, strong) NSString *picture;
/**  价格  */
@property (nonatomic, strong) NSString *price;
/**  跳转类型Id（1->小包厢/2->大场地;）  */
@property (nonatomic, assign) NSInteger typeOfRoomKey;
/**  跳转类型（小包厢/大场地）  */
@property (nonatomic, strong) NSString *typeOfRoomValue;
@end

@interface WSFHomePageVM : NSObject
/**
 * 轮播图的数据源
 */
@property (nonatomic, strong) NSMutableArray<WSFHomePageCarouselItemVM*> *carouselArray;
/**
 * 热门空间的数据源
 */
@property (nonatomic, strong) NSMutableArray<WSFHomePageHotRoomVM*> *hotRoomArray;

- (instancetype)initWithHomePageModel:(WSFHomePageHotModel *)homeModel;

@end
