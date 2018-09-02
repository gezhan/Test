//
//  FakeJudgeHandle.h
//  zcmjr
//
//  Created by huang on 2018/6/9.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ValueBlock) (BOOL isFake);

@interface FakeJudgeHandle : NSObject

/*
 *block回去 yes：正常界面； no：伪装界面
 *
 */
+ (void)fakeWhetherOrNot:(ValueBlock)valueBlock;


/*
 *获取联网方式
 *有网络 YES  ；无网络 NO
 *ReachableViaWiFi 无线 ； ReachableViaWWAN 蜂窝数据；  NotReachable  无网络
 */
+ (BOOL)networkType;

@end
