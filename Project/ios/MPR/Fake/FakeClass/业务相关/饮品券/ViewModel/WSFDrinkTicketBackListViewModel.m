//
//  WSFDrinkTicketBackListViewModel.m
//  WinShare
//
//  Created by devRen on 2017/10/31.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDrinkTicketBackListViewModel.h"

// 根据时间字符串获取月份
RYJKIT_STATIC_INLINE NSInteger getMonthWithDateString(NSString *dateString) {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:dateString];
    NSDateFormatter* monthFormat = [[NSDateFormatter alloc] init];
    [monthFormat setDateFormat:@"MM"];
    return [[monthFormat stringFromDate:date] integerValue];
}

@interface WSFDrinkTicketBackListViewModel()

@property (nonatomic, strong) NSMutableArray<WSFDrinkTicketBackAPIModel *> *firstMonthRecords;
@property (nonatomic, strong) NSMutableArray<WSFDrinkTicketBackAPIModel *> *secondMonthRecords;
@property (nonatomic, assign) NSInteger firstMonthNumber;
@property (nonatomic, assign) NSInteger secondMonthNumber;

@end

@implementation WSFDrinkTicketBackListViewModel

- (void)addNewDataFromNetwork:(WSFDrinkTicketBackListModel *)backListModel {
    
    // 记录月份
    for (NSInteger i = 0; i < backListModel.totalAmount.count; i++) {
        WSFDrinkTicketTotalAmountAPIModel *model = backListModel.totalAmount[i];
        switch (i) {
            case 0:
                _firstMonthNumber = model.month;
                _firstMonth = [NSString stringWithFormat:@"%ld月兑换记录",(long)model.month];
                _firstMonthTotalAmount = [NSString stringWithFormat:@"合计：%@元",model.total];
                break;
            case 1:
                _secondMonthNumber = model.month;
                _secondMonth = [NSString stringWithFormat:@"%ld月兑换记录",(long)model.month];
                _secondMonthTotalAmount = [NSString stringWithFormat:@"合计：%@元",model.total];
                break;
            default:
                break;
        }
    }
    
    for (WSFDrinkTicketBackAPIModel *model in backListModel.records) {
        if (getMonthWithDateString(model.backTime) == _firstMonthNumber) {
            [self.firstMonthRecords addObject:model];
        } else {
            [self.secondMonthRecords addObject:model];
        }
    }
}

- (void)removeAllData {
    [self.firstMonthRecords removeAllObjects];
    [self.secondMonthRecords removeAllObjects];
}

#pragma mark - 懒加载
- (NSMutableArray *)firstMonthRecords {
    if (!_firstMonthRecords) {
        _firstMonthRecords = [[NSMutableArray alloc] init];
    }
    return _firstMonthRecords;
}

- (NSMutableArray *)secondMonthRecords {
    if (!_secondMonthRecords) {
        _secondMonthRecords = [[NSMutableArray alloc] init];
    }
    return _secondMonthRecords;
}

@end
