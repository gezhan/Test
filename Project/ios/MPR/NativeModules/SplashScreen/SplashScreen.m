//
//  SplashScreen.m
//  MPR
//
//  Created by HWC on 2018/5/11.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "SplashScreen.h"


//等待标识
static bool waiting = true;


@implementation SplashScreen
RCT_EXPORT_MODULE();
//解决ios 启动时白色的 问题
+ (void)show {
	while (waiting) {
		NSDate* later = [NSDate dateWithTimeIntervalSinceNow:0.2];
		[[NSRunLoop mainRunLoop] runUntilDate:later];
	}
}
RCT_EXPORT_METHOD(hide) {
	dispatch_async(dispatch_get_main_queue(),
								 ^{
									 waiting = false;
								 });
}
- (dispatch_queue_t)methodQueue{
	return dispatch_get_main_queue();
}
@end
