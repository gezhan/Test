//
//  WSFFieldOrderIntroductionVM.h
//  WinShare
//
//  Created by QIjikj on 2018/1/17.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WSFFieldIntroductionVM;
@class WSFRPOrderBigRoomApiModel;

@interface WSFFieldOrderIntroductionVM : NSObject

@property (nonatomic, strong) WSFFieldIntroductionVM *playgroundIntroductionVM;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *setMealString;
@property (nonatomic, copy) NSString *setMealNumString;
@property (nonatomic, copy) NSString *ticketString;
@property (nonatomic, copy) NSString *ticketNumString;
@property (nonatomic, copy) NSString *totelString;
@property (nonatomic, copy) NSString *totelNumString;
@property (nonatomic, copy) NSString *prontString;
@property (nonatomic, copy) NSString *prontNumString;

- (instancetype)initWithOrderDetailDataModel:(WSFRPOrderBigRoomApiModel *)orderBigRoomApiModel;

@end
