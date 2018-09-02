//
//  AppDelegate.h
//  huaqiangu
//
//  Created by Jiangwei on 15/7/18.
//  Copyright (c) 2015年 Jiangwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,AVAudioSessionDelegate>
@property (strong, nonatomic) NSMutableDictionary* PlayingInfoCenter;


@property (strong, nonatomic) UIImageView *customSplashView;
@property (strong, nonatomic) UIWindow *window;

//测试

@end

