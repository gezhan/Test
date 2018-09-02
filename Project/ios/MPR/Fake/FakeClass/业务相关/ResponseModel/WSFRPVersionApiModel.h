//
//  WSFRPVersionApiModel.h
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"

/**
 获取版本信息
 */
@interface WSFRPVersionApiModel : MTLModel <MTLJSONSerializing>

/** 版本ID */
@property (nonatomic, copy) NSString *Id;
/** 版本号 */
@property (nonatomic, copy) NSString *versionCode;
/** IOS链接（APK下载）地址 */
@property (nonatomic, copy) NSString *url;
/** 系统（10-Android/20-IOS） */
@property (nonatomic, assign) NSInteger appSystem;
/** 迭代内容 */
@property (nonatomic, strong) NSArray<NSString *> *iteration;
/** 是否必更 */
@property (nonatomic, assign) BOOL isMust;
/** 是否启用 */
@property (nonatomic, assign) BOOL enabled;
/** 创建时间 */
@property (nonatomic, strong) NSDate *createTime;
/** 更新时间 */
@property (nonatomic, strong) NSDate *modifyTime;

@end
