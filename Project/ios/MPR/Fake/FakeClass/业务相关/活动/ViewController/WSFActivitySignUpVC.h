//
//  WSFActivitySignUpVC.h
//  WinShare
//
//  Created by QIjikj on 2018/2/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFBaseViewController.h"

/**
 用户--填写报名信息VC
 */
@interface WSFActivitySignUpVC : WSFBaseViewController

/** 参加活动的价格，免费传0*/
@property (nonatomic, assign) CGFloat activityPrice;

/** 活动ID*/
@property (nonatomic, copy) NSString *activityId;

/* 举办该活动的空间ID*/
@property (nonatomic, copy) NSString *roomId;

@end
