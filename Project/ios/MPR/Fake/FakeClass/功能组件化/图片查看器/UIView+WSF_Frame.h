//
//  UIView+WSF_Frame.h
//  WinShare
//
//  Created by QIjikj on 2018/2/4.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WSF_Frame)

/** 起点的X*/
@property (nonatomic, assign) CGFloat wsf_x;
/** 起点的Y*/
@property (nonatomic, assign) CGFloat wsf_y;
/** 整个宽度*/
@property (nonatomic, assign) CGFloat wsf_width;
/** 整个高度*/
@property (nonatomic, assign) CGFloat wsf_height;
/** 中心的X*/
@property (nonatomic, assign) CGFloat wsf_centerX;
/** 中心的Y*/
@property (nonatomic, assign) CGFloat wsf_centerY;
/** 整个宽度和高度*/
@property (nonatomic, assign) CGSize wsf_size;
/** 起点*/
@property (nonatomic, assign) CGPoint wsf_origin;

@end
