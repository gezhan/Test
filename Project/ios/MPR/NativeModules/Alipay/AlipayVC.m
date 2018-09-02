//
//  AlipayVC.m
//  zcmjr
//
//  Created by nil on 2017/9/11.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "AlipayVC.h"

@implementation AlipayVC
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE(AlipayVC);
RCT_EXPORT_METHOD(AlipayModules:(RCTResponseSenderBlock)callback){
  dispatch_sync(dispatch_get_main_queue(), ^{
    if (![[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"alipay:"]]) {
      callback(@[@NO]);
    }else{
      callback(@[@YES]);
    }
  });
}

@end
