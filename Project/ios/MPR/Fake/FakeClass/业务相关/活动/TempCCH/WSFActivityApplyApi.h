//
//  WSFActivityApplyApi.h
//  WinShare
//
//  Created by QIjikj on 2018/3/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "YTKNetwork.h"

/**
 用户-活动报名Api
 */
@interface WSFActivityApplyApi : YTKRequest


/**
 用户用此Api提交活动的报名信息

 @param activityId 活动id
 @param nameString 联系姓名
 @param telString 联系电话
 @return 结果
 */
- (instancetype)initWithActivityId:(NSString *)activityId name:(NSString *)nameString tel:(NSString *)telString;

@end

