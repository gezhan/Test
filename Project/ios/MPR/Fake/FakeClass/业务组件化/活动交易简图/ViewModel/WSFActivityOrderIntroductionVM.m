//
//  WSFActivityOrderIntroductionVM.m
//  WinShare
//
//  Created by ZWL on 2018/3/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityOrderIntroductionVM.h"
#import "WSFRPPhotoApiModel.h"

@implementation WSFActivityOrderIntroductionVM

- (instancetype)initWithOrderDetailDataModel:(WSFRPOrderEventApiModel *)orderEventApiModel {
    if (self = [super init]) {
        
        self.name = orderEventApiModel.roomName;
        self.realPayTitle = @"实付：";
        self.realPayString = [NSString stringWithFormat:@"¥%0.2lf", orderEventApiModel.payPrice];
        
        self.activityIntroductionVM = [[WSFActivityDetailIntroductionVM alloc] init];
        self.activityIntroductionVM.nameString = [NSString stringWithFormat:@"活动名称：%@", orderEventApiModel.eventName];
        self.activityIntroductionVM.timeString = [NSString stringWithFormat:@"活动时间：%@", orderEventApiModel.eventTime];
        self.activityIntroductionVM.addressString = [NSString stringWithFormat:@"活动地址：%@", orderEventApiModel.roomAddress];
        self.activityIntroductionVM.imageURL = [NSURL URLWithString:orderEventApiModel.picture.path];
        
    }
    return self;
}

@end
