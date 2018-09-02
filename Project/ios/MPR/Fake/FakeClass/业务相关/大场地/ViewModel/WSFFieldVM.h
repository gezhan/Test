//
//  WSFFieldVM.h
//  WinShare
//
//  Created by GZH on 2018/1/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WSFFieldModel;

@interface WSFFieldCellVM : NSObject
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

@end

@interface WSFFieldVM : NSObject

/**  cell上边数据的数据源 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 *  下拉刷新
 */
- (void)refershHomePageTModel:(WSFFieldModel *)homeModel;
/**
 *  上拉加载
 */
- (void)addHomePageTModel:(WSFFieldModel *)homeModel;

@end
