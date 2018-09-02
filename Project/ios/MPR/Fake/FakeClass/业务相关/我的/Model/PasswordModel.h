//
//  PasswordModel.h
//  WinShare
//
//  Created by GZH on 2017/5/25.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PasswordModel : NSObject

@property (nonatomic, strong) NSString *RoomName;
@property (nonatomic, strong) NSArray *Password;
@property (nonatomic, strong) NSString *OrderTime;


+ (NSMutableArray*)getModelArrayFromModelArray:(NSArray*)array;

@end
