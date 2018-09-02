//
//  WSFFieldSelectedApi.h
//  WinShare
//
//  Created by GZH on 2018/1/18.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "YTKNetwork.h"

@interface WSFFieldSelectedApi : YTKRequest
/**
 * roomId  空间id
 */
- (instancetype)initWithTheRoomId:(NSString *)roomId;
@end
