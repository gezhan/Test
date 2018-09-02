//
//  CountDownServer.m
//  WinShare
//
//  Created by GZH on 2017/5/3.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "CountDownServer.h"

@implementation CountDownServer


+ (void) startCountDown:(int)total
         andStateOneing:(CountDowningBlock)countDowningBlock
      stateTwocompleted:(CountDownedBlock)countDownedBlock {
    
    
    __block int timeout = total; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0 ){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //倒计时完成时的设置
                
                
                if (countDownedBlock) {
                    countDownedBlock();
                }
                
                
                
            });
        }else{
            //倒计时进行时的设置
            NSString *strTime = [NSString stringWithFormat:@"%ds",timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                if (countDowningBlock) {
                    countDowningBlock(strTime);
                }

                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);

}


@end
