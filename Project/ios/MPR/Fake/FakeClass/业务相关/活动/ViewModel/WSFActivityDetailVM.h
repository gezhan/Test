//
//  WSFActivityDetailVM.h
//  WinShare
//
//  Created by GZH on 2018/3/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WSFRPAppEventApiResModel;

@interface WSFActivityIntroductionVM : NSObject
/**  简介-标题 */
@property (nonatomic, strong) NSString *title;
/**  简介-内容 */
@property (nonatomic, strong) NSString *content;
/**  简介-Id */
@property (nonatomic, strong) NSString *Id;

@end

/**
 用户 - 活动详情的VM
 */
@interface WSFActivityDetailVM : NSObject

/**  活动名称 */
@property (nonatomic, strong) NSString *name;
/**  活动费用 */
@property (nonatomic, assign) CGFloat price;
/**  活动详情 */
@property (nonatomic, strong) NSMutableAttributedString *detailString;
/**  电话 */
@property (nonatomic, strong) NSString *tel;
/**  人数下限(0-无限制) */
@property (nonatomic, assign) NSInteger manDown;
/**  活动地址（空间地址） */
@property (nonatomic, strong) NSString *address;
/**  经度 */
@property (nonatomic, assign) double lng;
/**  纬度 */
@property (nonatomic, assign) double lat;
/**  活动的分享地址 */
@property (nonatomic, strong) NSString *roomShareUrl;
/**  活动报名状态 */
@property (nonatomic, strong) NSString *btnTitle;
/**  活动报名状态（1：活动还未开始， 2：我要报名， 3：报名已截止） */
@property (nonatomic, assign) NSInteger stateSign;
/**  活动简介 */
@property (nonatomic, strong) NSMutableArray<WSFActivityIntroductionVM*> *introductionArray;
/**  轮播图的地址 */
@property (nonatomic, strong) NSMutableArray<NSString*> *photoArray;


- (instancetype)initWithAppEventResMode:(WSFRPAppEventApiResModel *)resModel;

@end
