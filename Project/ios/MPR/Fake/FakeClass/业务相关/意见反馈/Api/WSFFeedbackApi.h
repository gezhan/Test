//
//  WSFFeedbackApi.h
//  WinShare
//
//  Created by devRen on 2017/12/6.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "YTKNetwork.h"

@interface WSFFeedbackApi : YTKRequest

/**
 初始化方法

 @param theContent 反馈内容
 @param picIds 图片id
 @return self
 */
- (instancetype)initWithTheContent:(NSString *)theContent picIds:(NSString *)picIds;

@end
