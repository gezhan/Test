//
//  PermissionsDetect.m
//  MPR
//
//  Created by HWC on 2018/5/16.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "PermissionsDetect.h"
#import "AppDelegate.h"
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>


//#import "Reachability.h"

//权限检测
@implementation PermissionsDetect
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(AskPermission:(NSString *)single callback:(RCTResponseSenderBlock)callback){
	if ([single isEqualToString:@"location"]){
		//检测定位权限
		if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
			callback(@[@"true"]);
		}
		else{
			callback(@[@"false"]);
		}
	}
	else if ([single isEqualToString:@"contact"]){
		//检测通讯录权限
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
			//ios9.0及以上
			CNContactStore *contactStore = [[CNContactStore alloc] init];
			[contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
				if (granted) {
					NSLog(@"Authorized");
					callback(@[@"true"]);
				}else{
					NSLog(@"Denied or Restricted");
					callback(@[@"false"]);
				}
			}];
			
		} else {
			//ios9.0以下
			ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
			ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
				if (granted) {
					NSLog(@"Authorized");
					CFRelease(addressBook);
					callback(@[@"true"]);
				}else{
					NSLog(@"Denied or Restricted");
					callback(@[@"false"]);
				}
			});
		}
	}
}

RCT_EXPORT_METHOD(Detection:(NSString *)single callback:(RCTResponseSenderBlock)callback){
	
	if ([single isEqualToString:@"location"]){
		//检测定位权限
		if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
			callback(@[@"true"]);
		}
		else{
			callback(@[@"false"]);
		}
	}
	else if ([single isEqualToString:@"contact"]){
		//检测通讯录权限
		if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
			//ios9.0及以上
			CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
			switch (status) {
				case CNAuthorizationStatusAuthorized:
				{
					NSLog(@"Authorized:");
					callback(@[@"true"]);
				}
					break;
				case CNAuthorizationStatusDenied:{
					NSLog(@"Denied");
					callback(@[@"false"]);
				}
					break;
				case CNAuthorizationStatusRestricted:{
					NSLog(@"Restricted");
					callback(@[@"false"]);
				}
					break;
				case CNAuthorizationStatusNotDetermined:{
					NSLog(@"NotDetermined");
					callback(@[@"false"]);
				}
					break;
			}
			
		} else {
			//ios9.0以下
			ABAuthorizationStatus ABstatus = ABAddressBookGetAuthorizationStatus();
			switch (ABstatus) {
				case kABAuthorizationStatusAuthorized:
					NSLog(@"Authorized");
					callback(@[@"true"]);
					break;
				case kABAuthorizationStatusDenied:
					NSLog(@"Denied'");
					callback(@[@"false"]);
					break;
				case kABAuthorizationStatusNotDetermined:
					NSLog(@"not Determined");
					callback(@[@"false"]);
					break;
				case kABAuthorizationStatusRestricted:
					NSLog(@"Restricted");
					callback(@[@"false"]);
					break;
				default:
					break;
			}
		}
		
	}
}
RCT_EXPORT_METHOD(JumpSetting){
	/**
	 *[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];//跳转该app的
	 */
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]){
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
	}
}
RCT_EXPORT_METHOD(ExitApp){
	/**
	 *[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];//跳转该app的
	 */
	exit(0);
//	AppDelegate *app = [[UIApplication sharedApplication] delegate];
//	UIWindow *window = app.window;
//	[UIView animateWithDuration:0.5f animations:^{
//		window.backgroundColor = [UIColor whiteColor];
//		window.alpha = 0;
//		window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
//	} completion:^(BOOL finished) {
//		exit(0);
//	}];
}



//获取联网方式 对外提供调用方法,演示Callback

//RCT_EXPORT_METHOD(getNetWorkType:(RCTResponseSenderBlock)callback){
//
// Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
// NetworkStatus internetStatus = [reachability currentReachabilityStatus];
// NSString *nets = @"";
// switch (internetStatus) {
//  case ReachableViaWiFi:
//   nets = @"WIFI";
//   break;
//
//  case ReachableViaWWAN:
//   nets = @"蜂窝数据";
////   nets = [self getNetType ];   //判断具体类型
//   break;
//
//  case NotReachable:
//   nets = @"当前无网络连接";
//
//  default:
//   break;
// }
// NSLog(@"网络类型：%@",nets);
//
// // callback(@[net]);
//  callback(@[nets]);
//
//}









@end
