//
//  WSAppVersionModel.m
//  WinShare
//
//  Created by GZH on 2017/7/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSAppVersionModel.h"

@implementation WSAppVersionModel

- (instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        
        self.versionId = dict[@"Id"];
        self.versionCode = dict[@"VersionCode"];
        self.versionUrl = dict[@"Url"];
        self.appSystem = [dict[@"AppSystem"] integerValue];
        
        //数组转字符串
        self.iteration = [dict[@"Iteration"] componentsJoinedByString:@"\n"];
        
        self.isMust = [dict[@"IsMust"] boolValue];
        self.enabled = [dict[@"Enabled"] boolValue];
        self.createTime = dict[@"CreateTime"];
        self.modifyTime = dict[@"ModifyTime"];
        
    }
    return self;
}

+ (WSAppVersionModel *)modelFromDict:(NSDictionary *)dict
{
    WSAppVersionModel *model = [[WSAppVersionModel alloc] initWithDict:dict];
    return model;
}

+ (NSMutableArray *)getModelArrayFromModelArray:(NSArray *)array
{
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i<mutableArray.count; i++) {
        NSDictionary *dic = mutableArray[i];
        WSAppVersionModel *model = [WSAppVersionModel modelFromDict:dic];
        [mutableArray replaceObjectAtIndex:i withObject:model];
    }
    return mutableArray;
}

@end
