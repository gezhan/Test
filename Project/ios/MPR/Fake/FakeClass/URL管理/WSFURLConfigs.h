//
//  WSFURLConfigs.h
//  WinShare
//
//  Created by Gzh on 2017/11/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#ifndef WSFURLConfigs_h
#define WSFURLConfigs_h

/*============================================================*/
#define WSFNetworkAddressType_OnLine 0              // 线上
#define WSFNetworkAddressType_Offline_Test 1        // 线下测试
#define WSFNetworkAddressType_Offline_Develop 2     // 线下开发

#define NetworkAddressType WSFNetworkAddressType_OnLine  // 可用此宏切换网络地址

#if NetworkAddressType == WSFNetworkAddressType_OnLine
#define BaseUrl  @"http://roomapi.work-oa.com"              // BaseUrl API地址
#define BaseImageUrl  @"http://img.work-oa.com"             // BaseImageUrl 图片服务器地址
#elif NetworkAddressType == WSFNetworkAddressType_Offline_Test
#define BaseUrl  @"http://192.168.10.47:9080"
#define BaseImageUrl  @"http://192.168.10.47:9081"
#else
#define BaseUrl  @"http://192.168.10.47:9090"
#define BaseImageUrl  @"http://192.168.10.47:9081"
#endif
/*============================================================*/

// 拼接图片（缩略图）NSString路径
#define WSThumImgUrlWith(path,w,h,t) [NSString replaceString:path Withstr1:w str2:h str3:t]
// 拼接图片（非缩略图）NSString路径
#define WSImgUrlWith(path) [BaseImageUrl stringByAppendingString:(path)]


//注册_获取验证码
#define GetRegisteredCodeURL [NSString stringWithFormat:@"%@/api/Login/sendcode",BaseUrl]

//验证验证码有效性
#define PostContrastRegisteredCodeURL [NSString stringWithFormat:@"%@/api/Login/Verificat",BaseUrl]

//改密码_获取验证码
#define PostSecretRegisteredCodeURL [NSString stringWithFormat:@"%@/api/Login/set_pwd_sendsms?Token=%@",BaseUrl, [WSFUserInfo getToken]]

//改密码_验证验证码有效性
#define PostSecretContrastRegisteredCodeURL [NSString stringWithFormat:@"%@/api/Login/set_pwd_check?Token=%@",BaseUrl, [WSFUserInfo getToken]]

//登录
#define PostLoginURL [NSString stringWithFormat:@"%@/api/Login/Login",BaseUrl]

//获取门锁密码
#define GetPasswordURL [NSString stringWithFormat:@"%@/api/room/password?Token=%@",BaseUrl, [WSFUserInfo getToken]]

//添加订单
#define PostAddOrderURL [NSString stringWithFormat:@"%@/api/order/add?Token=%@",BaseUrl，[WSFUserInfo getToken]]

//返回订单已被预订的时间
#define GetOrderURL [NSString stringWithFormat:@"%@/api/orderV2/used_times?Token=%@",BaseUrl,[WSFUserInfo getToken]]

/*===================Space空间信息====================*/

//返回空间列表
#define GetSpaceListDataURL [NSString stringWithFormat:@"%@/api/room/list", BaseUrl]

//获取空间详情
#define GetSpaceDetailDataURL [NSString stringWithFormat:@"%@/api/room/detail", BaseUrl]

//获取空间详情(第二版)
#define GetSpaceDetailDataURLV2 [NSString stringWithFormat:@"%@/api/roomV2/detail", BaseUrl]

/*===================Order订单信息====================*/

//返回订单列表数据
#define GetOrderListDataURL [NSString stringWithFormat:@"%@/api/order/mylist", BaseUrl]

//获取订单详情
#define GetOrderDetailDataURL [NSString stringWithFormat:@"%@/api/order/detail", BaseUrl]

//添加一个订单
#define AddOrderURL [NSString stringWithFormat:@"%@/api/order/add", BaseUrl]

//返回订单的取消信息
#define GetOrderCloseURL [NSString stringWithFormat:@"%@/api/order/get_cancel", BaseUrl]

//返回订单的结算信息
#define GetOrderClearURL [NSString stringWithFormat:@"%@/api/order/get_settlement", BaseUrl]

//取消订单
#define CloseOrderURL [NSString stringWithFormat:@"%@/api/order/to_cancel", BaseUrl]

//结算订单
#define ClearOrderURL [NSString stringWithFormat:@"%@/api/order/to_settlement", BaseUrl]

/*===================PlaygroundOrder大场地订单信息==================*/
//返回大场地订单详情
#define GetPlaygroundOrderDetailDataURL [NSString stringWithFormat:@"%@/api/orderbr/get_detail", BaseUrl]

/*===================Payment    Z_F信息==================*/

//返回加签后的orderString用于ZFB    Z_F
#define getPaymentOrderStringURL [NSString stringWithFormat:@"%@/api/alipay/pay", BaseUrl]

//赢贝    Z_F
#define PaymentOrderUseForByteURL [NSString stringWithFormat:@"%@/api/order/to_pay", BaseUrl]

//订单    Z_F的统一接口（1-ZFB 2-赢贝 3-商铺卡）
#define PaymentOrderUnitURL [NSString stringWithFormat:@"%@/api/alipayV2/pay", BaseUrl]

/*===================Mine我的信息==================*/

//返回我的剩余赢贝数量
#define getMineBalanceMoneyURL [NSString stringWithFormat:@"%@/api/wallet/amount_now", BaseUrl]

//返回我的赢贝使用流水信息
#define getMineMoneyUsedRecordURL [NSString stringWithFormat:@"%@/api/wallet/amount_log", BaseUrl]

//返回用户身份标识（1-用户 2-商户 3-产业园商户）
#define getMineIdentifyURL [NSString stringWithFormat:@"%@/api/profile/identify", BaseUrl]

/*===================Ticket优惠券==================*/

#define getTicketListURL [NSString stringWithFormat:@"%@/api/coupon/listV2", BaseUrl]

#define getTicketDetailURL [NSString stringWithFormat:@"%@/api/coupon/detail", BaseUrl]

#define useTicketForOrderURL [NSString stringWithFormat:@"%@/api/order/binding_coupon", BaseUrl]

/*===================DrinkTicket饮品券==================*/

#define getDrinkTicketBackListURL [NSString stringWithFormat:@"%@/api/coupon/back_list", BaseUrl]
#define getDrinkTicketQRDetailURL [NSString stringWithFormat:@"%@/api/coupon/qr_detail", BaseUrl]
#define getDrinkTicketQRBackURL [NSString stringWithFormat:@"%@/api/coupon/qr_back", BaseUrl]



/*===================Shop商铺==================*/

//获取商铺空间
#define GetShopListURL [NSString stringWithFormat:@"%@/api/room/businessrooms", BaseUrl]

//获取指定商铺的经营情况和订单列表数据
#define GetShopListDetailURL [NSString stringWithFormat:@"%@/api/room/brdetail", BaseUrl]

//获取商铺的邀请二维码
#define GetShopQRCodeURL [NSString stringWithFormat:@"%@/api/business/invitecode", BaseUrl]

//获取商铺卡列表
#define GetShopCardListURL [NSString stringWithFormat:@"%@/api/roomV2/cards_list", BaseUrl]

// 获取商铺卡有数据的月份
#define GetShopCardDetailAccountURL [NSString stringWithFormat:@"%@/api/roomV2/cards_months", BaseUrl]

// 获取商家商铺卡使用详情
#define GetShopCardDetailDataURL [NSString stringWithFormat:@"%@/api/roomV2/cards_detail", BaseUrl]

/*===================App软件信息==================*/

//获取App的最新版本信息
#define GetAppVersionURL [NSString stringWithFormat:@"%@/api/version/new_version", BaseUrl]

//获取App的平台客服电话
#define GetAppPhoneURL [NSString stringWithFormat:@"%@/api/aboutus/get_phone", BaseUrl]

/*===================App软件信息==================*/

//获取活动信息-推荐有礼
#define GetRecommendURL [NSString stringWithFormat:@"%@/api/aboutus/get_activity", BaseUrl]






#endif /* WSFURLConfigs_h */
