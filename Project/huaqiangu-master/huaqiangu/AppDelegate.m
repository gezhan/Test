//
//  AppDelegate.m
//  huaqiangu
//
//  Created by Jiangwei on 15/7/18.
//  Copyright (c) 2015年 Jiangwei. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "PlayController.h"
#import <UMengAnalytics/UMMobClick/MobClick.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "DownController.h"
#import <STKAudioPlayer.h>
#import "BaiduMobAdSDK/BaiduMobAdSplash.h"
#import "AlbumListVC.h"

@interface AppDelegate ()<BaiduMobAdSplashDelegate>
{
    
    KKNavigationController *navCtrl;
    LBLaunchImageAdView * adView;
}

@property (nonatomic, strong) BaiduMobAdSplash *splash;

@end

@implementation AppDelegate


#pragma mark -
#pragma mark - 友盟统计

-(void)umengAtion
{
    //友盟统计
    UMConfigInstance.appKey = umAppKey;
    [MobClick startWithConfigure:UMConfigInstance];
}

- (void)dealloc
{
    self.customSplashView = nil;
    self.window = nil;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //admob广告
    [FIRApp configure];
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-5473057868747749/2846237312"];
    
    [[AVAudioSession sharedInstance] setDelegate:self];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    UInt32 size = sizeof(CFStringRef);
    CFStringRef route;
    AudioSessionGetProperty(kAudioSessionProperty_AudioRoute, &size, &route);
    
    _PlayingInfoCenter = [[NSMutableDictionary alloc] init];
    [self becomeFirstResponder];


    AlbumListVC *viewCtrl = [[AlbumListVC alloc]init];
    navCtrl = [[KKNavigationController alloc]initWithRootViewController:viewCtrl];
    
    [navCtrl.navigationBar setBarTintColor:kCommenColor];
    self.window.rootViewController = navCtrl;
    
    [self.window makeKeyAndVisible];
    
//    [self baiduSplashView];
    
    [self umengAtion];
    
//    [[MainList sharedManager] cleanContent];
    [Fabric with:@[CrashlyticsKit]];
    return YES;
}

//// 本地通知回调函数，当应用程序在前台时调用
//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//    NSLog(@"noti:%@",notification);
//    
//    // 这里真实需要处理交互的地方
//    // 获取通知所带的数据
//    NSString *notMess = [notification.userInfo objectForKey:@"key"];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本地通知(前台)"
//                                                    message:notMess
//                                                   delegate:nil
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
//    
//    // 更新显示的徽章个数
//    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
//    badge--;
//    badge = badge >= 0 ? badge : 0;
//    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
//}

#pragma mark -
#pragma mark - 百度全屏广告
-(void)baiduSplashView
{
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    adView = [[LBLaunchImageAdView alloc]initWithWindow:self.window adType:FullScreenAdType];
    
    //    self.customSplashView = [[UIImageView alloc]initWithFrame:self.window.frame];
    //    self.customSplashView.backgroundColor = [UIColor whiteColor];
    //    [self.window addSubview:self.customSplashView];
    
    // 全屏开屏
    self.splash = [[BaiduMobAdSplash alloc] init];
    self.splash.delegate = self;
    self.splash.AdUnitTag = ADUNITTAG;
    [self.splash loadAndDisplayUsingContainerView:adView];
    //        adView.localAdImgName = @"qidong.gif";
//        adView.imgUrl = @"http://www.uisheji.com/wp-content/uploads/2013/04/19/app-design-uisheji-ui-icon20121_55.jpg";
    //    adView.aDImgView = self.customSplashView;
}

#pragma mark -
#pragma mark - 百度广告设置

- (NSString *)publisherId {
    return PUBLISHERID;
}

- (void)splashDidClicked:(BaiduMobAdSplash *)splash {
    NSLog(@"splashDidClicked");
}

- (void)splashDidDismissLp:(BaiduMobAdSplash *)splash {
    NSLog(@"splashDidDismissLp");
}

- (void)splashDidDismissScreen:(BaiduMobAdSplash *)splash {
    NSLog(@"splashDidDismissScreen");
    [self removeSplash];
}

- (void)splashSuccessPresentScreen:(BaiduMobAdSplash *)splash {
    NSLog(@"splashSuccessPresentScreen");
}

- (void)splashlFailPresentScreen:(BaiduMobAdSplash *)splash withError:(BaiduMobFailReason)reason {
    NSLog(@"splashlFailPresentScreen withError %d", reason);
    [self removeSplash];
}

/**
 *  展示结束or展示失败后, 手动移除splash和delegate
 */
- (void) removeSplash {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    if (adView) {
        [adView removeFromSuperview];
    }
}

#pragma mark - 
#pragma mark - 锁屏播放设置

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
            case UIEventSubtypeRemoteControlPause:
            case UIEventSubtypeRemoteControlTogglePlayPause:{
                [[PlayController sharedPlayController] playAction];
            }
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack: {
                [[PlayController sharedPlayController] laseAction];
                break;
            }
            case UIEventSubtypeRemoteControlNextTrack: {
                [[PlayController sharedPlayController] nextAction];
                break;
            }
            default: {
                break;
            }
        }
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    
    NSLog(@"\n\n倔强的打出一行字告诉你我要挂起了。。\n\n");
    
    //MBAudioPlayer是我为播放器写的单例，这段就是当音乐还在播放状态的时候，给后台权限，不在播放状态的时候，收回后台权限
    if ([PlayController sharedPlayController].audioPlayer.state == STKAudioPlayerStatePlaying||[PlayController sharedPlayController].audioPlayer.state == STKAudioPlayerStateBuffering||[PlayController sharedPlayController].audioPlayer.state == STKAudioPlayerStatePaused ||[PlayController sharedPlayController].audioPlayer.state == STKAudioPlayerStateStopped) {
        //有音乐播放时，才给后台权限，不做流氓应用。
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        [self becomeFirstResponder];
        //开启定时器
//        [[PlayController sharedPlayController] setupTimer:YES];
//        [[PlayController sharedPlayController] setupTimer:YES];
//        [[STKAudioPlayer sharedManager] decideTimerWithType:STKAudioTimerStartBackground andBeginState:YES];
//        [[STKAudioPlayer sharedManager] configNowPlayingInfoCenter];
    }
    else
    {
        [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
        [self resignFirstResponder];
        //检测是都关闭定时器
//        [[PlayController sharedPlayController] setupTimer:NO];
//        [[PlayController sharedPlayController].timer invalidate];
//        [[STKAudioPlayer sharedManager] decideTimerWithType:STKAudioTimerStartBackground andBeginState:NO];
//        [[PlayController sharedPlayController] setupTimer:NO];
    }
}

-(BOOL) enableLocation {
    //启用location会有一次alert提示,请根据系统进行相关配置
    return NO;
}

@end
