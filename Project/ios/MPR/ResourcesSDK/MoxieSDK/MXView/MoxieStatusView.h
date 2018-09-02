//
//  MXStatusView.h
//  MoxieSDK
//
//  Created by shenzw on 6/27/16.
//  Copyright © 2016 shenzw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoxieSDK.h"
@interface MoxieStatusView : UIView <MoxieSDKProgressDelegate>
- (MoxieStatusView*)initWithFrame:(CGRect)frame themeColor:(UIColor*)themeColor;
@end
