//
//  WSFActivityOrderIntroductionVM.h
//  WinShare
//
//  Created by ZWL on 2018/3/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSFActivityDetailIntroductionVM.h"
#import "WSFRPOrderEventApiModel.h"

@interface WSFActivityOrderIntroductionVM : NSObject

@property (nonatomic, strong) WSFActivityDetailIntroductionVM *activityIntroductionVM;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *realPayTitle;
@property (nonatomic, copy) NSString *realPayString;

- (instancetype)initWithOrderDetailDataModel:(WSFRPOrderEventApiModel *)orderEventApiModel;

@end
