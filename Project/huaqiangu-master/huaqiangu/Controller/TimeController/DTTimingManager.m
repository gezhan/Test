//
//  DTTimingManager.m
//  duotin2.0
//
//  Created by Vienta on 14-10-17.
//  Copyright (c) 2014年 Duotin Network Technology Co.,LTD. All rights reserved.
//

#import "DTTimingManager.h"
#import "PlayController.h"
//#import <AppMacro.h>
//#import <AudioService.h>

@implementation DTTimingManager

SINGLETON_CLASS(DTTimingManager);

NSString *const kTimingClock = @"kTimingClock";

- (id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)startTiming:(TimingState)currentTimingState
{
    switch (currentTimingState) {
        case TimingStateNone:{
//            [iConsole log:@"不开启"];
        }
            break;
        case TimingStateTenMins:{
//            [iConsole log:@"10min"];

        }
            break;
        case TimingStateTwentyMins:{
//            [iConsole log:@"20min"];
        }
            break;
        case TimingStateThirtyMins:{
//            [iConsole log:@"30min"];
        }
            break;
        case TimingStateOneHour:{
//            [iConsole log:@"60min"];
        }
            break;
        case TimingStateNinetyMins:{
//            [iConsole log:@"90min"];
        }
            break;

        case TimingStateAfterCurrentFinish:{
//            [iConsole log:@"本区播放完成之后"];
        }
            break;
        default:
            break;
    }
    if (currentTimingState == TimingStateAfterCurrentFinish) {
        self.countdownNum = @([[PlayController sharedPlayController].audioPlayer duration] - [[PlayController sharedPlayController].audioPlayer progress]);
    } else {
        self.countdownNum = @(currentTimingState);
    }
    
    self.timingState = currentTimingState;
    
    if (!self.countdownTimer || ![self.countdownTimer isValid]) {
        self.countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(counting) userInfo:nil repeats:YES];
        [self.countdownTimer fire];
    }
}

- (void)counting
{
    if ([self.countdownNum integerValue] <= 0) {
        [self.countdownTimer invalidate];
        self.countdownNum = @0;
        if (self.timingBlk) {
            self.timingBlk(@0);
        }
        self.isClock = NO;
        self.timingState = TimingStateNone;
    } else {
        self.isClock = YES;
        NSInteger count = [self.countdownNum integerValue] - 1;
        self.countdownNum = @(count);
        if (self.timingBlk) {
            self.timingBlk(self.countdownNum);
        }
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kTimingClock object:nil];
    });
}

- (void)pause
{
    [self.countdownTimer invalidate];
}

- (void)resume
{
    [self startTiming:self.timingState];
}

@end
