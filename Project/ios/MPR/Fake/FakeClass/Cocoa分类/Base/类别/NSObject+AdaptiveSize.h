//
//  NSObject+AdaptiveSize.h
//  WinShare
//
//  Created by GZH on 2017/5/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (AdaptiveSize)

/****自适应宽度****/
-(CGRect)getFrameWithFreeWidth:(CGPoint)origin maxHight:(CGFloat)maxHight;

/****自适应高度****/
-(CGRect)getFrameWithFreeHight:(CGPoint)origin maxWidth:(CGFloat)maxWidth;

/****自适应宽度--->可调整字间距****/
-(CGRect)getFrameWithFreeWidth:(CGPoint)origin maxHight:(CGFloat)maxHight textSpace:(CGFloat)textSpace;

/****自适应高度--->可调整字间距和行间距****/
-(CGRect)getFrameWithFreeHight:(CGPoint)origin maxWidth:(CGFloat)maxWidth textSpace:(CGFloat)textSpace lineSpace:(CGFloat)lineSpace;


@end
