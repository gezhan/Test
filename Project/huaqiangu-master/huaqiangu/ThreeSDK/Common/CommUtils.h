//
//  CommUtils.h
//  jianzhi
//
//  Created by Jiangwei on 15/5/27.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AutoRunLabel.h"

@interface CommUtils : NSObject

//定制navigation的title
+(AutoRunLabel *)navTittle:(NSString *)title;
+(NSString *)progressValue:(double)value;

//保存正在播放的节目
+(void)saveIndex:(NSInteger)index;
+(NSInteger)getPlayIndex;

//正在播放
+ (void)navigationPlayButtonItem:(UIButton *)btn;

//滚动label
+(UIView *)labelView:(NSString *)title andLabel:(UILabel *)newLabel;

//分割线
+ (UIImageView *)cuttingLineWithOriginx:(CGFloat)x andOriginY:(CGFloat)y;

//倒计时
+ (NSString *)formatIntoDateWithSecond:(NSNumber *)sec;

//检测网络
+(NSInteger)checkNetworkStatus;
@end
