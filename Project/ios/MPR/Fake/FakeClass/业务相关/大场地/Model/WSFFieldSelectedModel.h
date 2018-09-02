//
//  WSFFieldSelectedModel.h
//  WinShare
//
//  Created by GZH on 2018/1/18.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSFFieldFieldM.h"

@interface WSFFieldSelectedModel : MTLModel <MTLJSONSerializing>
/**  提示语句 */
@property (nonatomic, strong) NSString *tip;
/**  消费模式是否提示 */
@property (nonatomic, assign) BOOL isTip;
/**  套餐 */
@property (nonatomic, strong) NSArray<WSFFieldFieldM*> *records;
@end
