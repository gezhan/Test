//
//  UDIDSafeDataDefine.h
//  UD_IDShield
//
//  Created by jwtong on 16/7/21.
//  Copyright © 2016年 com.udcredit. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, UDIDSafeAuthResult) {
    UDIDSafeAuthResult_Done,                //认证完成，商户可根据返回码进行自己的业务逻辑操作
    UDIDSafeAuthResult_Error,               //认证异常，如网络异常等
    UDIDSafeAuthResult_Cancel,              //用户取消认证操作
    UDIDSafeAuthResult_UserNameError,       //商户传入的姓名不合法
    UDIDSafeAuthResult_UserIdNumberError,   //商户传入的身份证号码不合法
    UDIDSafeAuthResult_BillNil              //订单为空
};

// delegate 回调 result 结果
typedef NS_ENUM(NSUInteger, UDIDEngineResult) {
    UDIDEngineResult_OCR,
    UDIDEngineResult_Liveness,
    UDIDEngineResult_IDAuth,
    UDIDEngineResult_FaceCompare,
    UDIDEngineResult_Video,
    UDIDEngineResult_Cancel
};

typedef NS_ENUM(NSUInteger, UDIDSafeMode) {
    UDIDSafeMode_High,
    UDIDSafeMode_Medium,
    UDIDSafeMode_Low
};

typedef NS_ENUM(NSUInteger, UDIDSafePhotoType) {
    UDIDSafePhotoTypeNormal,                // 证件照
    UDIDSafePhotoTypeLiving,                // 活体照
    UDIDSafePhotoTypeVideo                  // 视频存证截图
};

typedef NS_ENUM(NSUInteger, UDIDVerifyType) {
    UDIDVerifyHumanType,                   // 人像验证（默认）
    UDIDVerifySimpleType                   // 简项验证
};

// 产品功能列表枚举
typedef NS_ENUM(NSUInteger, UDIDAuthFlow) {
    UDIDAuthFlowOCR         = 0,            // 身份证 OCR 扫描
    UDIDAuthFlowLiving      = 1,            // 活体检测
    UDIDAuthFlowCompare     = 2,            // 比对
    UDIDAuthFlowRealName    = 3,            // 实名验证
    UDIDAuthFlowVideo       = 5             // 视频存证
};

// 活体检测模式枚举
typedef NS_ENUM(NSUInteger, UDIDLivingMode) {
    UDIDLivingBlinkMode,                    // 单个动作，眨眼
    UDIDLivingCommandMode,                  // 默认（推荐）五选三（眨眼，微笑,向左转头,向右转头，左右转头）
    UDIDLivingCustomMode                    // 自定义模式, 如果选择自定义模式，需要把「活体检测类型」写入 livingModeSettings(NSArray) 参数
};

// 活体检测类型枚举
typedef NS_ENUM(NSInteger, UDIDLivingType) {
    UDIDLivingBlink           = 0,   //眨眼
    UDIDLivingSmile           = 1,   //微笑
    UDIDLivingFaceToLeft      = 2,   //向左转头
    UDIDLivingFaceToRight     = 3,   //向右转头
    UDIDLivingSwingHead       = 6,   //左右转头
};

