//
//  WSFRPBigRoomsApiModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

//#import "Mantle.h"
#import "WSFRPPhotoApiModel.h"


/**
 大场地首页
 */
@interface WSFRPBigRoomsApiModel : MTLModel <MTLJSONSerializing>

/** 空间ID */
@property (nonatomic, copy) NSString *roomId;
/** 空间名称 */
@property (nonatomic, copy) NSString *roomName;
/** 图片 */
@property (nonatomic, strong) WSFRPPhotoApiModel *picture;
/** 地址 */
@property (nonatomic, copy) NSString *address;
/** 价格 */
@property (nonatomic, assign) CGFloat price;
/** 距离(单位/米) */
@property (nonatomic, assign) CGFloat theMeter;
/** 空间类别 */
@property (nonatomic, copy) NSString *roomType;
/** 可容纳人数 */
@property (nonatomic, assign) NSInteger capacity;

@end
