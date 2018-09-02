//
//  WSFActivityListVM.h
//  WinShare
//
//  Created by GZH on 2018/3/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WSFRPAppEventSearchQueryResModel;

@interface WSFActivityListCellVM : NSObject

/** 活动ID */
@property (nonatomic, strong) NSString *Id;
/**  活动图片 */
@property (nonatomic, strong) NSString *picture;
/** 活动名称 */
@property (nonatomic, strong) NSString *name;
/** 地理位置 */
@property (nonatomic, strong) NSMutableAttributedString *timeAndAddress;
/** 活动状态 */
@property (nonatomic, strong) NSString *eventStatus;
/** 报名费用 */
@property (nonatomic, strong) NSString *enrolmentFee;
/** 活动人数 */
@property (nonatomic, strong) NSString *man;

@end

/**
 用户 - 活动列表的VM
 */
@interface WSFActivityListVM : NSObject

/**  cell上边数据的数据源 */
@property (nonatomic, strong) NSMutableArray<WSFActivityListCellVM*> *dataSource;

/**
 *  下拉刷新
 */
- (void)refershActivityTModel:(WSFRPAppEventSearchQueryResModel *)resModel;
/**
 *  上拉加载
 */
- (void)addActivityTModel:(WSFRPAppEventSearchQueryResModel *)resModel;

@end
