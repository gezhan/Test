/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

//有个空间伪装
#import "WSFHomePageVC.h"
#import "YTKNetworkConfig.h"
#import "FakeJudgeHandle.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  NSURL *jsCodeLocation;
#ifdef DEBUG
  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
#else
  jsCodeLocation = [CodePush bundleURLForResource:@"index.ios"];
#endif
  
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"MPR"
                                               initialProperties:nil
                                                   launchOptions:launchOptions];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  _rootVC = rootViewController;
  //  self.window.rootViewController = rootViewController;
  //  [self.window makeKeyAndVisible];
  
  
  [self fakeAction];
  [self reachabilityChanged];
 
  
  //闪屏出现
  [SplashScreen show];
  //极光推送
  [self initJpushService:launchOptions];
  //友盟统计
  [self initUMengStatistics:launchOptions];
  //Bugly
  [self initBugly:launchOptions];
  //高德地图
  [self initGaode:launchOptions];
  
  return YES;
}
//初始化极光推送.
- (void)initJpushService:(NSDictionary *)launchOptions{
  if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
  } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                      UIUserNotificationTypeSound |
                                                      UIUserNotificationTypeAlert)
                                          categories:nil];
  }
  //填写isProdurion  平时测试时为NO ，生产时填写YES
  static BOOL isProduction = YES;
  [JPUSHService setupWithOption:launchOptions appKey:MPRConstants_JPUSHAppAppkey
                        channel:@"ygkj" apsForProduction:isProduction];
  [JPUSHService setBadge:0];
  [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}
//友盟统计初始化
- (void)initUMengStatistics:(NSDictionary *)launchOptions{
  
  [UMConfigure initWithAppkey:MPRConstants_UmSocialAppkey channel:@"AppStore"];
  [MobClick setScenarioType:E_UM_NORMAL];
}
//腾讯Bugly初始化
- (void)initBugly:(NSDictionary *)launchOptions{
  [Bugly startWithAppId:MPRConstants_TencentAppId];
}
//高德地图初始化
- (void)initGaode:(NSDictionary *)launchOptions{
  [AMapServices sharedServices].apiKey = MPRConstants_GaodeMapAppkey;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
  [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
  [[NSNotificationCenter defaultCenter] postNotificationName:kJPFDidReceiveRemoteNotification object:userInfo];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
  [[NSNotificationCenter defaultCenter] postNotificationName:kJPFDidReceiveRemoteNotification object: notification.userInfo];
}
//iOS 7 Remote Notification
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)   (UIBackgroundFetchResult))completionHandler
{
  [[NSNotificationCenter defaultCenter] postNotificationName:kJPFDidReceiveRemoteNotification object:userInfo];
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler
{
  NSDictionary * userInfo = notification.request.content.userInfo;
  if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [JPUSHService handleRemoteNotification:userInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:kJPFDidReceiveRemoteNotification object:userInfo];
  }
  
  completionHandler(UNNotificationPresentationOptionAlert);
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler
{
  NSDictionary * userInfo = response.notification.request.content.userInfo;
  if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [JPUSHService handleRemoteNotification:userInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:kJPFOpenNotification object:userInfo];
  }
  completionHandler();
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  //实现一个可以后台运行几分钟的权限, 当用户在后台强制退出程序时就会走applicationWillTerminate 了.在ios7以前，后台可以用下面的的方式，去在后台存活5-10分钟，在ios8中，只能存活3分钟。
  [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
  
}
// iOS 9 or older
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
  return [RCTLinkingManager application:application openURL:url
                      sourceApplication:sourceApplication annotation:annotation];
}
// iOS 10
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
  return [RCTLinkingManager application:application openURL:url
                      sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                             annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}


#pragma mark --伪装判断---
- (void) reachabilityChanged {
  [FakeJudgeHandle fakeWhetherOrNot:^(BOOL isFake) {
    if (isFake == 1) {
      //真实界面rn
      self.window.rootViewController = _rootVC;
    }else {
      //伪装界面
      //      [self fakeAction];
      NSLog(@"伪装界面");
    }
  }];
  [self.window makeKeyAndVisible];
}

#pragma mark --伪装--
- (void)fakeAction {
  [YTKNetworkConfig sharedConfig].baseUrl = BaseUrl;
  self.window.rootViewController = self.fakeNavVC;
  [self setupBaiduMapManager];
  // 在整个过程中监听网络的变化
  [[WSFNetworkClient client] networkStatusChangedAFN];
  @weakify(self);
  [WSFNetworkClient client].netWorkChange = ^{
    @strongify(self);
    if (![[PathUserDefaults objectForKey:@"isShowCheckView"]isEqualToString:@"0"]) {
      [self reachabilityChanged];
    }
  };
}

#pragma mark - 百度地图的鉴权
- (void)setupBaiduMapManager{
  _mapManager = [[BMKMapManager alloc]init];
  BOOL ret = [_mapManager start:WSFConstants_BaiduMapAppkey generalDelegate:nil];
  if (!ret) {
    NSLog(@"manager start failed!");
  }
}

- (UINavigationController *)fakeNavVC {
  if (!_fakeNavVC) {
    WSFHomePageVC *homePageVC = [[WSFHomePageVC alloc] init];
    _fakeNavVC = [[UINavigationController alloc] initWithRootViewController:homePageVC];
  }
  return _fakeNavVC;
}

@end

