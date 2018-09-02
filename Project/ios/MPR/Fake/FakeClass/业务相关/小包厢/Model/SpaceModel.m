//
//  SpaceModel.m
//  WinShare
//
//  Created by GZH on 2017/5/10.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "SpaceModel.h"
#import "WSFTimeManager.h"
@implementation SpaceModel

- (instancetype)initWithData {
    
    if (self = [super init]) {
  
        self.tureDataArray = [NSMutableArray arrayWithObjects:@"不限", nil];
        self.timeArray = [NSMutableArray array];
        self.dataArray = [NSMutableArray arrayWithObjects:@"不限", @"今天", @"明天", nil];
        self.pointTimeArray = [NSMutableArray array];
        for (int i = 1; i < 13; i++) {
            [self.timeArray addObject:[NSString stringWithFormat:@"%d小时",i]];
        }
        for (int i = 0; i < 7; i++) {
            NSString *dataStr = [NSString getNextDateAction:i andYear:NO];
            dataStr = [WSFTimeManager getNavDateTodayWithdateStr:dataStr];
            dataStr = [dataStr stringByReplacingOccurrencesOfString:@"/" withString:@"月"];
            dataStr = [NSString stringWithFormat:@"%@日", dataStr];
            
            [self.tureDataArray addObject:dataStr];
            if (i >= 2) {
                [self.dataArray addObject:dataStr];
            }
        }

        //将时间点按照ui显示的截取好
        for (NSString *str in [WSFTimeManager getPointTimesAllDay]) {
            NSString *tempStr = [str substringWithRange:NSMakeRange(0, 1)];
            if ([tempStr isEqualToString:@"0"]) {
                tempStr = [str substringFromIndex:1];
                [self.pointTimeArray addObject:tempStr];
            }else {
                [self.pointTimeArray addObject:str];
            }
        }


    }
    return self;
}



@end
