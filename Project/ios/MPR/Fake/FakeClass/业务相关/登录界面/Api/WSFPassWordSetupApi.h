//
//  WSFPassWordSetupApi.h
//  WinShare
//
//  Created by GZH on 2018/1/22.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "YTKNetwork.h"

@interface WSFPassWordSetupApi : YTKRequest

/**  设置新密码 */
- (instancetype)initWithTheNewPwd:(NSString *)newPwd;

@end
