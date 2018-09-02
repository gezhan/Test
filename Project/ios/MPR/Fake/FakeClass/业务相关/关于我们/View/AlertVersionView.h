//
//  AlertVersionView.h
//  WinShare
//
//  Created by GZH on 2017/8/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSAppVersionModel;

@interface AlertVersionView : UIView

- (instancetype)initWithFrame:(CGRect)frame versionInfo:(WSAppVersionModel *)versionInfo block1:(void(^)())block1 block2:(void(^)())block2;

- (instancetype)initWithFrame:(CGRect)frame versionInfo:(WSAppVersionModel *)versionInfo block1:(void(^)())block1;

@end
