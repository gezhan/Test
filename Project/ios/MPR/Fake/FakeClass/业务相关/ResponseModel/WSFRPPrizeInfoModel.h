//
//  WSFRPPrizeInfoModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
#import "WSFRPKeyValueStrModel.h"

/**
 中奖奖品信息
 */
@interface WSFRPPrizeInfoModel : MTLModel <MTLJSONSerializing>

/** 奖品Id(我的奖品接口时，为券ID) */
@property (nonatomic, copy) NSString *prizeId;
/** 奖品码（我的奖品接口时，为券码） */
@property (nonatomic, copy) NSString *code;
/** 奖品名称 */
@property (nonatomic, copy) NSString *prizeName;
/** 奖品类型（折扣券,满减金额券,满减小时券,饮品券,实物） */
@property (nonatomic, copy) NSString *type;
/** 奖品类型键值对 */
@property (nonatomic, strong) WSFRPKeyValueStrModel *typeKeyValue;
/** 奖品面值 */
@property (nonatomic, assign) CGFloat amount;
/** 奖品面值类型（元/折扣） */
@property (nonatomic, copy) NSString *amountType;
/** 限制条件-金额限制（eg:满100元可用） */
@property (nonatomic, copy) NSString *limitAmount;
/** 奖品有效期 */
@property (nonatomic, copy) NSString *validTime;
/** 奖品使用条件 */
@property (nonatomic, strong) NSArray<NSString *> *useLimits;
/** 创建日期 */
@property (nonatomic, strong) NSDate *creaTime;
/** 状态(1-正常；2-已失效；3-已使用) */
@property (nonatomic, assign) NSInteger status;

@end
