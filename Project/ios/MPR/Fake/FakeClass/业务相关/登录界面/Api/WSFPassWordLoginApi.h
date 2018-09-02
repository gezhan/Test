//
//  WSFPassWordLoginApi.h
//  WinShare
//
//  Created by GZH on 2018/1/22.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "YTKNetwork.h"

@interface WSFPassWordLoginApi : YTKRequest

- (instancetype)initWithTheaccountName:(NSString *)accountName pwd:(NSString *)password;

@end
