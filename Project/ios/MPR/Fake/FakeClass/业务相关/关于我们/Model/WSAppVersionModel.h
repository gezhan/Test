//
//  WSAppVersionModel.h
//  WinShare
//
//  Created by GZH on 2017/7/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AppSystemType) {
    AppSystemTypeAndtod = 10,//安卓
    AppSystemTypeIOS = 20,//iOS
};

@interface WSAppVersionModel : NSObject

@property (nonatomic, copy) NSString *versionId;//版本id
@property (nonatomic, copy) NSString *versionCode;//版本号
@property (nonatomic, copy) NSString *versionUrl;//版本的连接地址
@property (nonatomic, assign) AppSystemType appSystem;//版本的系统
@property (nonatomic, copy) NSString *iteration;//迭代内容
@property (nonatomic, assign) BOOL isMust;//是否必须更新
@property (nonatomic, assign) BOOL enabled;//是否启用
@property (nonatomic, copy) NSString *createTime;//创建时间
@property (nonatomic, copy) NSString *modifyTime;//更新时间

- (instancetype)initWithDict:(NSDictionary*)dict;

+ (WSAppVersionModel *)modelFromDict:(NSDictionary *)dict;
+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array;

@end
