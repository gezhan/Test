//
//  WSFRPCarouselSetApiModel.h
//  WinShare
//
//  Created by GZH on 2018/3/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
#import "WSFRPPhotoApiModel.h"
#import "WSFRPKeyValueStrModel.h"
/**
 * 轮播图
 */
@interface WSFRPCarouselSetApiModel : MTLModel <MTLJSONSerializing>
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
/**  跳转空间/活动名称  */
@property (nonatomic, strong) NSString *jumpRoomName;
@end
