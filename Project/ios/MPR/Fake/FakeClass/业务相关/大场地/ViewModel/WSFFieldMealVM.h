//
//  WSFFieldMealVM.h
//  WinShare
//
//  Created by GZH on 2018/1/19.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WSFFieldFieldM;

@interface WSFFieldMealVM : NSObject

/**  场次 */
@property (nonatomic, strong) NSMutableArray *frontArray;
/**  时间 */
@property (nonatomic, strong) NSMutableArray *behindArray;

-(instancetype)initWithsetMealModelArray:(NSArray<WSFFieldFieldM *>*) setMealModelArray;

@end
