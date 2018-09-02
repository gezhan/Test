//
//  UDIDEngine.h
//  UubeeSuperReal
//
//  Created by Jin Jian on 2017/5/25.
//  Copyright © 2017年 Hydra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UDIDSafeDataDefine.h"
#import "UDIDFaceCompareItem.h"

@protocol UDIDEngineDelegate <NSObject>

/* 返回结果，cancel是用户取消操作，Done 是完成检测 ，userInfo是完成检测之后的返回信息 */
- (void)idSafeEngineFinishedResult:(UDIDEngineResult)result UserInfo:(id)userInfo;

@end

@interface UDIDEngine : NSObject

@property (nonatomic, weak) id <UDIDEngineDelegate> delegate;



/*----------通用参数----------*/
/* 商户公钥，必传 */
@property (nonatomic, strong) NSString * pubKey;

/* 异步通知地址 */
@property (nonatomic, strong) NSString * notifyUrl;

/* 签名，必传 */
@property (nonatomic, strong) NSString * sign;

/* 签名时间，必传，格式：yyyyMMddHHmmss */
@property (nonatomic, strong) NSString * signTime;

/* 商户订单号，必传 */
@property (nonatomic, strong) NSString * partnerOrderId;

/* 关联 id */
@property (nonatomic, strong) NSString * sessionId;

/* 作为备用的业务字段（预留字段，json格式，非必传） */
@property (nonatomic, strong) NSString * extInfo;



/* 分布动作数组，必传,（枚举动作） */
@property (nonatomic, copy) NSArray *actions;



/*----------OCR 相关属性----------*/
/* 姓名掩码 */
@property (nonatomic, assign) BOOL mosaicIdName;

/* 身份证号掩码 */
@property (nonatomic, assign) BOOL mosaicIdNumber;

/* 身份证号在确认页面明文展示 */
@property (nonatomic, assign) BOOL showConfirmIdNumber;

/* 是否显示身份证ocr信息,确认信息页面 */
@property (nonatomic, assign) BOOL showInfo;

/* 手动拍照 OCR（默认为 YES） */
@property (nonatomic, assign) BOOL isManualOCR;


/*----------活体相关属性----------*/
/* 随机数量（传入5个活体动作，randomCount = 3；即为随机五选三） */
@property (nonatomic, assign) NSInteger randomCount;

/* 活体动作数组（传入想要的活体动作） */
@property (nonatomic, copy)   NSArray *livingModeSettings;

/* 活体检测模式，UDIDLivingMode 枚举（单个动作、五选三、自定义） */
@property (nonatomic, assign) UDIDLivingMode livingMode;

/* 活体声音开关，默认为 NO（即开启声音） */
@property (nonatomic, assign) BOOL     closeRemindVoice;

/* 安全模式，共3个等级，即活体检测的动作要求难度, 默认最高等级 */
@property (nonatomic, assign) UDIDSafeMode safeMode;



/*----------身份认证相关属性----------*/
/* 姓名 */
@property (nonatomic, copy)   NSString *idName;
/* 身份证号码 */
@property (nonatomic, copy)   NSString *idNumber;

/* 身份验证方式（UDIDVerifySimpleType - 简项验证、UDIDVerifyHumanType - 人像验证（默认） */
@property (nonatomic, assign) UDIDVerifyType verifyType;



/*----------比对相关属性----------*/
/* 比对项 A */
@property (nonatomic, strong) UDIDFaceCompareItem *compareItemA;
/* 比对项 B */
@property (nonatomic, strong) UDIDFaceCompareItem *compareItemB;
/* 是否网格照 */
@property (nonatomic, assign) BOOL isGridPhoto;


/*----------视频存证相关属性----------*/
/* 视频内需要朗读的文字内容,数字限制在100字以内，多余部分不显示 */
@property (nonatomic, copy) NSString * readingInfo;


/*----------开始方法---------*/
/* 传入当前 VC */
- (void)startIdSafeAuthInViewController:(UIViewController *)viewController;

@end
