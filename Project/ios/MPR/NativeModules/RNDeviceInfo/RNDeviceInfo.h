//
//  RNDeviceInfo.h
//  MPR
//
//  Created by HWC on 2018/5/11.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sys/utsname.h>

#if __has_include(<React/RCTAssert.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif

@interface RNDeviceInfo : NSObject <RCTBridgeModule>

@end
