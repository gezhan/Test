//
//  WSFActivityCarouselVM.h
//  WinShare
//
//  Created by GZH on 2018/3/9.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WSFRPCarouselSetApiModel;

@interface WSFActivityCarouselM : NSObject
/**  图片 */
@property (nonatomic, strong) NSString *picture;
/**  轮播位ID */
@property (nonatomic, strong) NSString *Id;
/**  跳转类型Id（1->小包厢/2->大场地/3->链接/4->活动;）  */
@property (nonatomic, assign) NSInteger jumpTypeKey;
/**  跳转类型（小包厢/大场地/链接/活动）  */
@property (nonatomic, strong) NSString *jumpTypeValue;
/**  跳转空间/活动ID */
@property (nonatomic, strong) NSString *jumpRoomId;
/**  跳转空间/活动名称 */
@property (nonatomic, strong) NSString *jumpRoomName;
/**  跳转链接地址*/
@property (nonatomic, strong) NSString *jumpUrl;
/**  排序索引（越大越前） */
@property (nonatomic, assign) NSInteger sort;

@end

/**
 用户 - 活动列表的轮播图的VM
 */
@interface WSFActivityCarouselVM : NSObject
/**  存储图片相关信息的数组 */
@property (nonatomic, strong) NSMutableArray<WSFActivityCarouselM*> *dataSource;
/**  存储图片的数组 */
@property (nonatomic, strong) NSMutableArray *photosUrlArray;
- (instancetype)initWithCarouselModelArray:(NSArray<WSFRPCarouselSetApiModel*> *)carouselModelArray;

@end
