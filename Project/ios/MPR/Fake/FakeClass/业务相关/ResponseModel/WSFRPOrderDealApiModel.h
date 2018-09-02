//
//  WSFRPOrderDealApiModel.h
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"

@interface WSFRPOrderDealApiModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *orderCode;
@property (nonatomic, copy) NSString *roomName;
@property (nonatomic, copy) NSString *roomAddress;
@property (nonatomic, copy) NSString *isRoomBusiness;
@property (nonatomic, copy) NSString *orderDuration;
@property (nonatomic, copy) NSString *useDuration;
@property (nonatomic, copy) NSString *refundDuration;
@property (nonatomic, copy) NSString *patchDuration;
@property (nonatomic, copy) NSString *costPrice;
@property (nonatomic, copy) NSString *refundPrice;
@property (nonatomic, copy) NSString *refundYbei;
@property (nonatomic, copy) NSString *patchPrice;
@property (nonatomic, copy) NSString *patchYbei;
@property (nonatomic, copy) NSString *isCanPayPatchYbei;
@property (nonatomic, copy) NSString *returnWay;
@property (nonatomic, copy) NSString *settleType;

@end
