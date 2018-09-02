//
//  ByteRecordModel.h
//  WinShare
//
//  Created by QIjikj on 2017/5/14.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ByteRecordModel : NSObject

@property (nonatomic, assign) double operationAmount;
@property (nonatomic, copy) NSString *operationType;
@property (nonatomic, copy) NSString *operationTime;

- (instancetype)initWithDict:(NSDictionary*)dict;

+ (ByteRecordModel*)modelFromDict:(NSDictionary*)dict;
+ (NSMutableArray*)getModelArrayFromModelArray:(NSArray*)array;

@end
