//
//  ShumeiDeviceModule.m
//  MPR
//
//  Created by HWC on 2018/5/14.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "ShumeiDeviceModule.h"
@interface ShumeiDeviceModule() <NSObject>

@property (nonatomic, assign) BOOL isSMInitSuccess;

@end
@implementation ShumeiDeviceModule
RCT_EXPORT_MODULE(SmAntiFraud);

#pragma mark - 初始化方法
RCT_EXPORT_METHOD(init:(NSDictionary *)params){
	dispatch_async(dispatch_get_main_queue(), ^{
		self.isSMInitSuccess = NO;
		SmOption *option = [[SmOption alloc] init];
		[option setOrganization:[NSString stringWithFormat:@"%@",params[@"organization"]]];
		[option setChannel:[NSString stringWithFormat:@"%@",params[@"channel"]]];// 传入渠道标识
		//如果初始化成功了的回调
		[option setCallback:^(NSString* serverId) {
			//传入 organization，不要传入
			NSLog(@"server id:%@", serverId);
			if (![serverId isEqualToString:@""]){
				self.isSMInitSuccess = YES;
			}
		}];
		[[SmAntiFraud shareInstance] create:option];
	});
}
#pragma mark - 获取Token方法
RCT_EXPORT_METHOD(getSMFingerToken:(RCTResponseSenderBlock)callback){
	if (self.isSMInitSuccess){
		NSString *token = [[SmAntiFraud shareInstance] getDeviceId];
		callback(@[token]);
	}
	else{
		callback(@[@""]);
	}
}
@end
