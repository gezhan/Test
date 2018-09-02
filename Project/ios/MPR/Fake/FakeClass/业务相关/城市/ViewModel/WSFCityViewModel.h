//
//  WSFCityViewModel.h
//  WinShare
//
//  Created by GZH on 2017/12/20.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSFCityModel.h"

@interface WSFCityViewModel : NSObject
/**  城市的首字母集合 */
@property (nonatomic, strong) NSMutableArray *firstSpellArray;
/**  各个城市名称集合 */
@property (nonatomic, strong) NSMutableArray *cityArray;

/*
 * cityModelArray 城市的model数组
 */
- (instancetype)initWithCityModelArray:(NSArray<WSFCityArrayModel *> *)cityModelArray;

@end
