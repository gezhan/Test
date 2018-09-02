//
//  DTTimingManager.h
//  duotin2.0
//
//  Created by Vienta on 14-10-17.
//  Copyright (c) 2014年 Duotin Network Technology Co.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TimingState) {
    TimingStateNone = 0,            //不开启
    TimingStateTenMins = 10 * 60,
    TimingStateTwentyMins = 20 * 60,
    TimingStateThirtyMins = 30 * 60,
    TimingStateOneHour = 60 * 60,
    TimingStateNinetyMins = 90 * 60,
    TimingStateAfterCurrentFinish = -1,//本曲播放结束
};
typedef void(^TimingBlock)(NSNumber *timing);

extern NSString *const kTimingClock;

#import <Foundation/Foundation.h>

@interface DTTimingManager : NSObject

@property (nonatomic, strong) NSNumber *countdownNum;
@property (nonatomic, strong) NSTimer *countdownTimer;
@property (nonatomic, assign) TimingState timingState;
@property (nonatomic, copy) TimingBlock timingBlk;
@property (nonatomic, assign) BOOL isClock;

+ (instancetype)sharedDTTimingManager;

- (void)startTiming:(TimingState)currentTimingState;

- (void)pause;

- (void)resume;

@end
