//
//  WSFHomePagePromptView.h
//  WinShare
//
//  Created by GZH on 2018/1/11.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSFHomePagePromptView : UIView

/**
 **初始化方法
 * signString  提示的文字
 */
- (instancetype)initWithFrame:(CGRect)frame
                   signString:(NSString *)signString;
@end
