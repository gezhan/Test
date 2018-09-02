//
//  WSFRPPlatformActivityApiModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"

/**
 获取活动信息-推荐有礼
 */
@interface WSFRPPlatformActivityApiModel : MTLModel <MTLJSONSerializing>

/** 活动ID */
@property (nonatomic, copy) NSString *iD;
/** 活动标题 */
@property (nonatomic, copy) NSString *title;
/** 背景图片地址 */
@property (nonatomic, copy) NSString *picture;
/** 二维码 */
@property (nonatomic, copy) NSString *code;
/** 活动规则 */
@property (nonatomic, strong) NSArray<NSString *> *regulation;
/** 分享标题 */
@property (nonatomic, copy) NSString *shareTitle;
/** 分享内容 */
@property (nonatomic, strong) NSArray<NSString *> *shareContent;
/** 分享图片 */
@property (nonatomic, copy) NSString *sharePicture;

@end
