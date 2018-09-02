//
//  ByteRecordModel.m
//  WinShare
//
//  Created by QIjikj on 2017/5/14.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ByteRecordModel.h"

@implementation ByteRecordModel

- (instancetype)initWithDict:(NSDictionary*)dict
{
    if (self = [super init]) {
        
        self.operationAmount = [dict[@"Amount"] doubleValue];
        self.operationType = dict[@"Operation"];
        self.operationTime = dict[@"TheTime"];
        
    }
    return self;
}

+ (ByteRecordModel*)modelFromDict:(NSDictionary*)dict
{
    ByteRecordModel *model = [[ByteRecordModel alloc] initWithDict:dict];
    return model;
}

+ (NSMutableArray*)getModelArrayFromModelArray:(NSArray*)array
{
    NSMutableArray *mutableArray = [array mutableCopy];
    for (NSInteger i = 0; i<mutableArray.count; i++) {
        NSDictionary *dic = mutableArray[i];
        ByteRecordModel *model = [ByteRecordModel modelFromDict:dic];
        [mutableArray replaceObjectAtIndex:i withObject:model];
    }
    return mutableArray;
}

@end
