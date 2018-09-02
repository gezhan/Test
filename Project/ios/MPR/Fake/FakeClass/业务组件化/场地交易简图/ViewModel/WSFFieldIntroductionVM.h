//
//  WSFFieldIntroductionVM.h
//  WinShare
//
//  Created by QIjikj on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//  订单详情-大场地-大场地简介VM

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface WSFFieldIntroductionVM : NSObject

/** 使用时间*/
@property (nonatomic, copy) NSString *timeString;
/** 场次*/
@property (nonatomic, copy) NSString *durationString;
/** 套餐*/
@property (nonatomic, copy) NSString *setMealString;
/** 图片URL */
@property (nonatomic, copy) NSURL *imageURL;

@end
NS_ASSUME_NONNULL_END
