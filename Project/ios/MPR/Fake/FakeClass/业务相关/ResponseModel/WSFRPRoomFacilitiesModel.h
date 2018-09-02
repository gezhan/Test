//
//  WSFRPRoomFacilitiesModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"


/**
 设备
 */
@interface WSFRPRoomFacilitiesModel : MTLModel <MTLJSONSerializing>

/** 设备类别编号 */
@property (nonatomic, assign) NSInteger diviceTypeId;
/** 设备类别名称 */
@property (nonatomic, copy) NSString *diviceType;
/** 设备数量 */
@property (nonatomic, assign) NSInteger qty;

@end
