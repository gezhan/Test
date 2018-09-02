//
//  CountDownServer.h
//  WinShare
//
//  Created by GZH on 2017/5/3.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

/**  正在倒计时的回调 */
typedef void(^CountDowningBlock)(NSString *);

/**  倒计时完毕的回调 */
typedef void(^CountDownedBlock)();



@interface CountDownServer : NSObject

@property (nonatomic, copy) CountDowningBlock countDowningBlock;
@property (nonatomic, copy) CountDownedBlock countDownedBlock;

//倒计时的方法
+ (void) startCountDown:(int)total
       andStateOneing:(CountDowningBlock)countDowningBlock
      stateTwocompleted:(CountDownedBlock)countDownedBlock;

@end
