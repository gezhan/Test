//
//  WSAlertAppVersionMethod.m
//  WinShare
//
//  Created by GZH on 2017/7/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSAlertAppVersionMethod.h"
#import "WSAboutVM.h"
#import "WSAppVersionModel.h"
#import "AlertVersionView.h"

static const int kVersionDigit = 7;

@interface WSAlertAppVersionMethod ()

@end

@implementation WSAlertAppVersionMethod

+ (void)alertAppVersion
{
    __weak typeof(self) weakSelf = self;
    
    [WSAboutVM getAppVersionMessageSuccess:^(NSDictionary *appVersion) {
        
        //获取最新版本的信息
        WSAppVersionModel *appVersionModel = [WSAppVersionModel modelFromDict:appVersion];
        
        //获取软件当前的版本号
        NSString *currentVersion = [[HSDeviceInfo alloc] init].appVersion;
        NSLog(@"%@", currentVersion);
        
        //最新的版本号
        NSInteger theLastVersion = [weakSelf versionNumber:appVersionModel.versionCode];
        //当前的版本号
        NSInteger theCurrentVersion = [weakSelf versionNumber:currentVersion];
        
        NSLog(@"%ld~~~~~%ld", theLastVersion, theCurrentVersion);
        
        
        //___________________________________________
        
        if (theLastVersion > theCurrentVersion) {
            
            if (appVersionModel.isMust) {
                
                //立即更新
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                UIView *overView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                overView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
                [window addSubview:overView];
                
                AlertVersionView *alertVersionV = [[AlertVersionView alloc] initWithFrame:CGRectMake(40, (SCREEN_HEIGHT - 298)/2, (SCREEN_WIDTH - 80), 298) versionInfo:appVersionModel block1:^{
                    
                    [overView removeFromSuperview];
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E8%B5%A2%E4%BA%AB%E7%A9%BA%E9%97%B4-%E4%B8%8A%E7%99%BE%E4%B8%AA%E6%99%BA%E8%83%BD%E5%8C%96%E7%A9%BA%E9%97%B4%E9%9A%8F%E6%97%B6%E4%B8%BA%E6%82%A8%E6%9C%8D%E5%8A%A1/id1244019092?mt=8"]];
                    
                }];
                
                [overView addSubview:alertVersionV];
                
            }else {
                
                //判断之前是否拒绝过
                if ([[WSFAppInfo getRefuseVersion] isEqualToString:appVersionModel.versionCode]) {//2.拒绝过
                    
                }else {//1.没有拒绝过-立即更新、下次再说
                
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    UIView *overView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                    overView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
                    [window addSubview:overView];
                    
                    AlertVersionView *alertVersionV = [[AlertVersionView alloc] initWithFrame:CGRectMake(40, (SCREEN_HEIGHT - 298)/2, (SCREEN_WIDTH - 80), 298) versionInfo:appVersionModel block1:^{
                        
                        [overView removeFromSuperview];
                        
                        [WSFAppInfo saveRefuseVersion:appVersionModel.versionCode];
                        
                    } block2:^{
                        
                        [overView removeFromSuperview];
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E8%B5%A2%E4%BA%AB%E7%A9%BA%E9%97%B4-%E4%B8%8A%E7%99%BE%E4%B8%AA%E6%99%BA%E8%83%BD%E5%8C%96%E7%A9%BA%E9%97%B4%E9%9A%8F%E6%97%B6%E4%B8%BA%E6%82%A8%E6%9C%8D%E5%8A%A1/id1244019092?mt=8"]];
                        
                    }];
                    
                    [overView addSubview:alertVersionV];
                    
                    
                }
            }
            
        }else {
            
        }
        

        
    } failed:^(NSError *error) {
        
        NSLog(@"获取app的版本信息失败：%@", error);
    }];
    
    
}

//更改版本号的格式,变成纯数字，便于比较
+ (NSInteger)versionNumber:(NSString *)versionString
{
    NSString *versionNum = versionString;
    versionNum = [versionNum stringByReplacingOccurrencesOfString:@"V" withString:@""];
    versionNum = [versionNum stringByReplacingOccurrencesOfString:@"v" withString:@""];
    versionNum = [versionNum stringByReplacingOccurrencesOfString:@"." withString:@""];
    versionNum = [versionNum stringByReplacingOccurrencesOfString:@"B" withString:@""];
    versionNum = [versionNum stringByReplacingOccurrencesOfString:@"b" withString:@""];
    
    NSInteger tempLengh = versionNum.length;
    if (tempLengh < kVersionDigit) {
        for (int i = 0; i < (kVersionDigit - tempLengh); i ++) {
            versionNum = [versionNum stringByAppendingString:@"0"];
        }
    }
    
    return [versionNum integerValue];
}

@end
