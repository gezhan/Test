//
//  WSFRPKeyValueStrModel.h
//  WinShare
//
//  Created by GZH on 2018/1/30.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"

/**
 键值对
 */
@interface WSFRPKeyValueStrModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) NSInteger key;
@property (nonatomic, copy) NSString *value;

@end
