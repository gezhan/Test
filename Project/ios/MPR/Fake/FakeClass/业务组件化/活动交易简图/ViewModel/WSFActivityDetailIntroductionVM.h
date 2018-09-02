//
//  WSFActivityDetailIntroductionVM.h
//  WinShare
//
//  Created by ZWL on 2018/3/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface WSFActivityDetailIntroductionVM : NSObject

/** 活动名称*/
@property (nonatomic, copy) NSString *nameString;
/** 活动时间*/
@property (nonatomic, copy) NSString *timeString;
/** 活动地址*/
@property (nonatomic, copy) NSString *addressString;
/** 图片URL */
@property (nonatomic, copy) NSURL *imageURL;

@end
NS_ASSUME_NONNULL_END
