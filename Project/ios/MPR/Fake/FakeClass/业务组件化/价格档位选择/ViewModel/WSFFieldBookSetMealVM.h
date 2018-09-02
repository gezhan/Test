//
//  WSFFieldBookSetMealVM.h
//  WinShare
//
//  Created by QIjikj on 2018/1/18.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WSFFieldPriceStallAPIModel;

@interface WSFFieldBookSetMealCellVM : NSObject

/** 价格 */
@property (nonatomic, copy) NSString *priceString;
/** 价格 */
@property (nonatomic, copy) NSString *priceNumber;
/** 价格档次id*/
@property (nonatomic, copy) NSString *priceStallId;
/** 价格档次*/
@property (nonatomic, copy) NSString *priceStallString;
/** 描述*/
@property (nonatomic, copy) NSString *priceStallContentString;
/** 选择按钮是否选中*/
@property (nonatomic, getter=isChoosed, assign) BOOL choosed;

@end

@interface WSFFieldBookSetMealVM : NSObject

@property (nonatomic, strong) NSMutableArray<WSFFieldBookSetMealCellVM *> *playgroundBookSetMealCellVMArray;


/**
 初始化

 @param playgroundPriceStallAPIModelArray APIModel
 @param didChoosedSetMealNo 之前选择的价格档位名称（若没有则传空字符串）
 @return self
 */
- (instancetype)initWithPlaygroundPriceStallAPIModelArray:(NSArray<WSFFieldPriceStallAPIModel *> *)playgroundPriceStallAPIModelArray didChoosedSetMealNo:(NSString *)didChoosedSetMealNo;

@end
