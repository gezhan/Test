//
//  WSFRPBusinessCardQueryModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
#import "WSFRPBusinessCardDetailModel.h"

/**
 商铺卡一个月使用明细
 */
@interface WSFRPBusinessCardQueryModel : MTLModel <MTLJSONSerializing>

/** 符合条件的记录总数量 */
@property (nonatomic, assign) NSInteger totalCount;
/** 当前第几页 */
@property (nonatomic, assign) NSInteger pageIndex;
/** 每页记录数量 */
@property (nonatomic, assign) NSInteger pageSize;
/** 空间Id */
@property (nonatomic, copy) NSString *roomId;
/** 使用总时长 */
@property (nonatomic, assign) NSInteger totalDuration;
/** 月份 */
@property (nonatomic, copy) NSString *theMonth;
/** 当前页的所有记录 */
@property (nonatomic, strong) NSArray<WSFRPBusinessCardDetailModel *> *records;

@end
