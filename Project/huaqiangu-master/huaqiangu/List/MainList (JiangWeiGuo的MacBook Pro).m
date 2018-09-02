tr//
//  MainList.m
//  huaqiangu
//
//  Created by JiangWeiGuo on 16/2/25.
//  Copyright © 2016年 Jiangwei. All rights reserved.
//

#import "MainList.h"

@implementation MainList

+ (MainList *)sharedManager
{
    static DownList *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}


@end
