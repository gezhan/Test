//
//  RecommendVM.h
//  WinShare
//
//  Created by Gzh on 2017/9/7.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendVM : NSObject

/** 获取活动信息-推荐有礼 */
+ (void)getRecommendDataSuccess:(void(^)(NSDictionary *recommendData))success failed:(void(^)(NSError *error))failed;

@end
