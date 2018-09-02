//
//  WSFActivityIntroduceListTVM.m
//  WinShare
//
//  Created by QIjikj on 2018/2/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityIntroduceListTVM.h"

@implementation WSFActivityIntroduceListTCellVM

@end


@implementation WSFActivityIntroduceListTVM

- (instancetype)initWithNULL {
    if (self = [super init]) {
        for (int i = 0; i < 10; i++) {
            WSFActivityIntroduceListTCellVM *cellVM = [[WSFActivityIntroduceListTCellVM alloc] init];
            cellVM.introduceTitle = @"饭局狼人杀";
            cellVM.introduceContent = @"房价肯定会十分感慨时光可理解的方式来个跨境电商立法都符合高考加分很多更健康";
            
            [self.activityIntroduceListTCellVMArray addObject:cellVM];
        }
    }
    return self;
}

@end
