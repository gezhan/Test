//
//  WSFFieldBookSetMealVM.m
//  WinShare
//
//  Created by QIjikj on 2018/1/18.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldBookSetMealVM.h"
#import "WSFFieldPriceStallAPIModel.h"

@implementation WSFFieldBookSetMealCellVM

@end

@implementation WSFFieldBookSetMealVM

- (instancetype)initWithPlaygroundPriceStallAPIModelArray:(NSArray<WSFFieldPriceStallAPIModel *> *)playgroundPriceStallAPIModelArray didChoosedSetMealNo:(NSString *)didChoosedSetMealNo{
    if (self = [super init]) {
        
        for (WSFFieldPriceStallAPIModel *priceStallModel in playgroundPriceStallAPIModelArray) {
            
            WSFFieldBookSetMealCellVM *cellVM = [[WSFFieldBookSetMealCellVM alloc] init];
            cellVM.priceStallId = priceStallModel.setMealId;
            cellVM.priceStallString = priceStallModel.mealNo;
            cellVM.priceString = [NSString stringWithFormat:@"￥%ld/场",(long)priceStallModel.minimum];
            cellVM.priceNumber = [NSString stringWithFormat:@"%ld",(long)priceStallModel.minimum];
            cellVM.priceStallContentString = priceStallModel.mealContent;
            cellVM.choosed = [didChoosedSetMealNo isEqualToString:priceStallModel.mealNo];
            
            [self.playgroundBookSetMealCellVMArray addObject:cellVM];
        }
        
    }
    return self;
}

- (NSMutableArray<WSFFieldBookSetMealCellVM *> *)playgroundBookSetMealCellVMArray {
    if (!_playgroundBookSetMealCellVMArray) {
        _playgroundBookSetMealCellVMArray = [NSMutableArray array];
    }
    return _playgroundBookSetMealCellVMArray;
}

@end
