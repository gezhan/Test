//
//  FakeJudgeHandle.m
//  zcmjr
//
//  Created by huang on 2018/6/9.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "FakeJudgeHandle.h"
#import "Reachability.h"
#import "EquipInformation.h"
#import "NetworkClient.h"

//0为正式服  1为测试服
#define signNum  0
#define formalURL @"https://rrapi.5ujr.cn/v1/appconfig"
#define testURL @"http://192.168.1.233:8688/v1/appconfig"


@implementation FakeJudgeHandle

+ (void) fakeWhetherOrNot:(ValueBlock)valueBlock {
  
  if (![self networkType]) {
    if ([[PathUserDefaults objectForKey:@"isShowCheckView"]isEqualToString:@"0"]) {
      //不伪装
      if(valueBlock)valueBlock(YES);
    }else {
      //伪装
      if(valueBlock)valueBlock(NO);
    }
    return;
  }
  
  NSMutableDictionary *getInfo = [[[EquipInformation alloc]init] setDeviceIformation];
  //  NSLog(@"__________获取到的信息%@",getInfo);
  NSString *appVersion =[getInfo objectForKey:@"appVersion"];
  NSString *deviceSingle =[getInfo objectForKey:@"idfa"];
  NSString *mobileVersion=[getInfo objectForKey:@"osVersion"];
  NSDictionary *dict = @{
                         @"App": @(1),
                         @"AppVersion": appVersion,
                         @"DeviceSingle": deviceSingle,
                         @"DeviceUniqueID": @"",
                         @"IsEmulator": @"",
                         @"MobileType": @"",
                         @"MobileVersion": mobileVersion,
                         @"PkgType": @(0),
                         @"Platform": @"AppStore",
                         };

  /*
   * 返回数据  0为伪装  1为非伪装
   */
  [NetworkClient POST_Path:signNum == 0?formalURL:testURL params:dict completed:^(NSData *stringData, id JSONDict) {
    
//        NSLog(@"---qweqw-------------------------------------%@", JSONDict);
    if([JSONDict[@"Skip"] intValue] == 100){
      //不伪装
      if(valueBlock)valueBlock(YES);
      [PathUserDefaults setObject:@"0" forKey:@"isShowCheckView"];
      [PathUserDefaults synchronize];
    }else  {
      //伪装
      if(valueBlock)valueBlock(NO);
      [self fakeAction];
    }
  } failed:^(NSError *error) {
    //伪装
    if(valueBlock)valueBlock(NO);
    [self fakeAction];
  }];
}

+ (void)fakeAction {
  [PathUserDefaults setObject:@"1" forKey:@"isShowCheckView"];
  [PathUserDefaults synchronize];
}



/*
 *获取联网方式
 *有网络 YES  ；无网络 NO
 *ReachableViaWiFi 无线 ； ReachableViaWWAN 蜂窝数据；  NotReachable  无网络
*/
+(BOOL)networkType{
  Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
  NetworkStatus internetStatus = [reachability currentReachabilityStatus];
  switch (internetStatus) {
    case ReachableViaWiFi:
      return YES;
      break;
    case ReachableViaWWAN:
      return YES;
      break;
    case NotReachable:
      return NO;
    default:
      break;
  }
}

@end
