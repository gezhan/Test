//
//  WSFEnum.h
//  WinShare
//
//  Created by GZH on 2017/11/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

/*=====全民好信中全局枚举值=====*/
/** 书写规则 */
/**
 1.统一使用OC的枚举类型方式
 2.枚举类型名称以WSF开头，Type结尾，中间使用明确字面意义的首字母大写的驼峰名
 */

#ifndef WSFEnum_h
#define WSFEnum_h

/** 用户的身份 */
typedef NS_ENUM(NSInteger, WSFUserIdentifyType) {
    WSFUserIdentifyType_User = 1,   /** 用户 */
    WSFUserIdentifyType_Merchant,   /** 商户 */
    WSFUserIdentifyType_VIP         /** 产业园VIP商户 */
};

/**     Z_F、退款方式 */
typedef NS_ENUM(NSInteger, WSFPayWayType) {
    WSFPayWayType_Alipay = 1,   /** ZFB */
    WSFPayWayType_YBei,         /** 赢贝 */
    WSFPayWayType_ShopCard      /** 商铺卡 */
};

#endif /* WSFEnum_h */
