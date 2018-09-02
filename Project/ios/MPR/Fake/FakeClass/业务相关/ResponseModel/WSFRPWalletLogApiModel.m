//
//  WSFRPWalletLogApiModel.m
//  WinShare
//
//  Created by GZH on 2018/2/1.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFRPWalletLogApiModel.h"

@implementation WSFRPWalletLogApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"amount" : @"Amount",
             @"operation" : @"Operation",
             @"theTime" : @"TheTime"

             };
}

@end
