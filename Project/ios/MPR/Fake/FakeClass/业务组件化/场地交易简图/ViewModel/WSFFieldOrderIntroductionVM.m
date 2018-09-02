//
//  WSFFieldOrderIntroductionVM.m
//  WinShare
//
//  Created by QIjikj on 2018/1/17.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldOrderIntroductionVM.h"
#import "WSFRPOrderBigRoomApiModel.h"
#import "WSFFieldIntroductionVM.h"
#import "WSFRPPhotoApiModel.h"

@implementation WSFFieldOrderIntroductionVM

- (instancetype)initWithOrderDetailDataModel:(WSFRPOrderBigRoomApiModel *)orderBigRoomApiModel {
    if (self = [super init]) {
        self.name = orderBigRoomApiModel.roomName;
        self.setMealString = @"套餐价格";
        self.setMealNumString = orderBigRoomApiModel.setMeal;
        self.ticketString = @"优惠";
        self.ticketNumString = [orderBigRoomApiModel.discountsType stringByAppendingString:[NSString stringWithFormat:@"-¥%0.2lf", orderBigRoomApiModel.discountsAmount]];
        self.totelString = @"总价:";
        self.totelNumString = [NSString stringWithFormat:@"%0.2lf", orderBigRoomApiModel.totalPrice];
        self.prontString = @"定金:";
        self.prontNumString = [NSString stringWithFormat:@"%0.2lf", orderBigRoomApiModel.payPrice];
        
        if ([orderBigRoomApiModel.status isEqualToString:@"待审核"]) {
            self.totelString = @"预计总价:";
            self.prontString = @"预计定金:";
        }
        
        self.playgroundIntroductionVM = [[WSFFieldIntroductionVM alloc] init];
        self.playgroundIntroductionVM.timeString = [@"使用日期:" stringByAppendingString:orderBigRoomApiModel.useTime];
        
        self.playgroundIntroductionVM.durationString = [@"场次:" stringByAppendingString:orderBigRoomApiModel.siteMeal];
        
        self.playgroundIntroductionVM.setMealString = [NSString stringWithFormat:@"套餐:%@", orderBigRoomApiModel.setMeal];
        
        self.playgroundIntroductionVM.imageURL = [NSURL URLWithString:orderBigRoomApiModel.picture.path];
    }
    return self;
}

@end
