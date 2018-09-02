//
//  WSFActivityApplyApi.m
//  WinShare
//
//  Created by QIjikj on 2018/3/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityApplyApi.h"

@interface WSFActivityApplyApi ()
@property (nonatomic, copy) NSString *activityId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tel;
@end

@implementation WSFActivityApplyApi

/**
 用户用此Api提交活动的报名信息
 
 @param activityId 活动id
 @param nameString 联系姓名
 @param telString 联系电话
 @return 结果
 */
- (instancetype)initWithActivityId:(NSString *)activityId name:(NSString *)nameString tel:(NSString *)telString {
    if (self = [super init]) {
        _activityId = activityId;
        _name = nameString;
        _tel = telString;
    }
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"/api/event_app/eve_apply?Token=%@",[WSFUserInfo getToken]];
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"EventId" : self.activityId,
             @"Name" : self.name,
             @"Tel": self.tel
             };
}

- (NSTimeInterval)requestTimeoutInterval {
    return WSFConstants_NetworkRequestTimeOutDutation;
}

@end
