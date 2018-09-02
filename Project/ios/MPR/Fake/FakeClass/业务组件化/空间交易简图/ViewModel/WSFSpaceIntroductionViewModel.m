//
//  WSFSpaceIntroductionViewModel.m
//  WinShare
//
//  Created by devRen on 2017/12/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFSpaceIntroductionViewModel.h"
#import "WSFRPOrderApiModel.h"
#import "NSString+StringAndDate.h"
#import "WSFRPPhotoApiModel.h"

@implementation WSFSpaceIntroductionViewModel

- (instancetype)initWithOrderIntroductionModel:(WSFRPOrderApiModel *)orderIntroductionModel {
    self = [super init];
    if (self) {
        // 预定时间
        NSDateFormatter *beginFormatter = [[NSDateFormatter alloc] init];
        beginFormatter.dateFormat = @"yyyy/MM/dd HH:mm";
        NSString *beginStr = [beginFormatter stringFromDate:orderIntroductionModel.beginTime];
        
        NSDateFormatter *endFormatter = [[NSDateFormatter alloc] init];
        endFormatter.dateFormat = @"HH:mm";
        NSString *endStr = [endFormatter stringFromDate:orderIntroductionModel.endTime];
        
        self.timeString = [NSString stringWithFormat:@"预定时间：%@~%@", beginStr, endStr];
        
        // 单价
        self.priceString = [NSString stringWithFormat:@"单价：¥%0.0lf/小时", orderIntroductionModel.roomPrice];
        
        // 时长
        self.durationString = [NSString stringWithFormat:@"时长：%@", orderIntroductionModel.duration];
        
        // 图片URL
        WSFRPPhotoApiModel *photoModel = orderIntroductionModel.picture;
        self.imageURL = [NSURL URLWithString:[NSString replaceString:photoModel.path]];
        
        // 套餐
        self.setMealString = [NSString stringWithFormat:@"%@：%@",orderIntroductionModel.mealNo,orderIntroductionModel.mealContent];
//        self.setMealString = @"套餐一 ： 2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡、2杯咖啡";
        // 是否有套餐
        self.haveSetMeal = ![orderIntroductionModel.mealNo isEqualToString:@""];
//        self.haveSetMeal = YES;
    }
    return self;
}

@end
