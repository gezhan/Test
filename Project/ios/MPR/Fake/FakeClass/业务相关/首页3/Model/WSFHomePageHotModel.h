//
//  WSFHomePageHotModel.h
//  WinShare
//
//  Created by GZH on 2018/1/11.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
@class WSFRPKeyValueStrModel;
@class WSFRPPhotoApiModel;

/**
 * 轮播图
 */
@interface WSFHomePageCarouselModel : MTLModel<MTLJSONSerializing>
/**  轮播位ID */
@property (nonatomic, strong) NSString *Id;
/**  跳转空间ID */
@property (nonatomic, strong) NSString *jumpRoomId;
/**  跳转链接地址 */
@property (nonatomic, strong) NSString *jumpUrl;
/**  排序索引（越大越前） */
@property (nonatomic, assign) NSInteger sort;
/**  图片  */
@property (nonatomic, strong) WSFRPPhotoApiModel *picture;
/**  跳转类型（小包厢/大场地/链接）  */
@property (nonatomic, strong) WSFRPKeyValueStrModel *jumpType;
@end


/**
 * 热门空间
 */
@interface WSFHomePageHotRoomModel : MTLModel<MTLJSONSerializing>
/**  热门ID */
@property (nonatomic, strong) NSString *Id;
/**  空间ID */
@property (nonatomic, strong) NSString *roomId;
/**  空间名称 */
@property (nonatomic, strong) NSString *roomName;
/**  排序索引（越大越前） */
@property (nonatomic, assign) NSInteger sort;
/**  价格  */
@property (nonatomic, strong) NSNumber *price;
/**  图片  */
@property (nonatomic, strong) WSFRPPhotoApiModel *picture;
/**  跳转类型（小包厢/大场地/链接）  */
@property (nonatomic, strong) WSFRPKeyValueStrModel *typeOfRoom;
@end




@interface WSFHomePageHotModel : MTLModel<MTLJSONSerializing>
/**  轮播数据 */
@property (nonatomic, strong) NSArray<WSFHomePageCarouselModel *> *carousel;
/**  热门空间数据 */
@property (nonatomic, strong) NSArray<WSFHomePageHotRoomModel *> *hotRoom;
@end
