//
//  SplashScreen.h
//  MPR
//
//  Created by HWC on 2018/5/11.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SplashScreen : NSObject<RCTBridgeModule>
///根据jsBundle渲染完毕才通知启动页消失
+ (void)show;
@end
