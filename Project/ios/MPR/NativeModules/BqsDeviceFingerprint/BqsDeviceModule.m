//
//  BqsDeviceModule.m
//  MPR
//
//  Created by HWC on 2018/5/11.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "BqsDeviceModule.h"
#import "AppDelegate.h"

@interface BqsDeviceModule() <BqsDeviceFingerPrintingDelegate,BqsDeviceFingerPrintingContactsDelegate>

@property (nonatomic, assign) BOOL isInitSuccess;

@end
//白骑士-反欺诈云
@implementation BqsDeviceModule
RCT_EXPORT_MODULE(BqsDeviceModule);

#pragma mark - 初始化方法
RCT_EXPORT_METHOD(init:(NSDictionary *)params){
	dispatch_async(dispatch_get_main_queue(), ^{
		self.isInitSuccess = NO;
		[[BqsDeviceFingerPrinting sharedBqsDeviceFingerPrinting] setBqsDeviceFingerPrintingDelegate:self];
		[[BqsDeviceFingerPrinting sharedBqsDeviceFingerPrinting] setBqsDeviceFingerPrintingContactsDelegate:self];
		[[BqsDeviceFingerPrinting sharedBqsDeviceFingerPrinting] initBqsDFSdkWithParams:params];
	});
}
#pragma mark - 获取Token方法
RCT_EXPORT_METHOD(getBqsFingerToken:(RCTResponseSenderBlock)callback){
	if (self.isInitSuccess){
		NSString *token = [[BqsDeviceFingerPrinting sharedBqsDeviceFingerPrinting] getTokenKey];
		callback(@[token]);
	}
	else{
		callback(@[@""]);
	}
}

#pragma mark - BqsDeviceFingerPrintingDelegate
@synthesize bridge = _bridge;
-(void)onBqsDFInitSuccess:(NSString *)tokenKey{
  NSLog(@"初始化成功 tokenKey=%@", tokenKey);
	self.isInitSuccess = YES;
  [self.bridge.eventDispatcher sendAppEventWithName:@"BqsInit"
                                               body:@{@"msg": tokenKey}];
}

-(void)onBqsDFInitFailure:(NSString *)resultCode withDesc:(NSString *)resultDesc{
  NSLog(@"SDK初始化失败 resultCode=%@, resultDesc=%@", resultCode, resultDesc);
  NSString *result = [NSString stringWithFormat:@"%@,%@",resultCode,resultDesc];
  [self.bridge.eventDispatcher sendAppEventWithName:@"BqsInit"
                                               body:@{@"msg": result}];
}
#pragma mark - BqsDeviceFingerPrintingContactsDelegate
-(void)onBqsDFContactsUploadSuccess:(NSString *)tokenKey{
	NSLog(@"联系人上传成功 tokenKey=%@", tokenKey);
	self.isInitSuccess = YES;
	[self.bridge.eventDispatcher sendAppEventWithName:@"BqsContact"
																							 body:@{@"msg": tokenKey}];
}
-(void)onBqsDFContactsUploadFailure:(NSString *)resultCode withDesc:(NSString *)resultDesc{
	NSLog(@"联系人上传失败 resultCode=%@, resultDesc=%@", resultCode, resultDesc);
	[self.bridge.eventDispatcher sendAppEventWithName:@"BqsContact"
																							 body:@{@"msg": resultCode}];
}
@end
