//
//  UIView+WSF_Frame.m
//  WinShare
//
//  Created by QIjikj on 2018/2/4.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "UIView+WSF_Frame.h"

@implementation UIView (WSF_Frame)

#pragma mark - wsf_x
- (void)setWsf_x:(CGFloat)wsf_x {
    CGRect frame = self.frame;
    frame.origin.x = wsf_x;
    self.frame = frame;
}
- (CGFloat)wsf_x {
    return self.frame.origin.x;
}

#pragma mark - wsf_y
- (void)setWsf_y:(CGFloat)wsf_y {
    CGRect frame = self.frame;
    frame.origin.y = wsf_y;
    self.frame = frame;
}
- (CGFloat)wsf_y {
    return self.frame.origin.y;
}

#pragma mark - wsf_width
- (void)setWsf_width:(CGFloat)wsf_width {
    CGRect frame = self.frame;
    frame.size.width = wsf_width;
    self.frame = frame;
}
- (CGFloat)wsf_width {
    return self.frame.size.width;
}

#pragma mark - wsf_height
- (void)setWsf_height:(CGFloat)wsf_height
{
    CGRect frame = self.frame;
    frame.size.height = wsf_height;
    self.frame = frame;
}
- (CGFloat)wsf_height
{
    return self.frame.size.height;
}

#pragma mark - wsf_centerX
- (void)setWsf_centerX:(CGFloat)wsf_centerX {
    CGPoint center = self.center;
    center.x = wsf_centerX;
    self.center = center;
}
- (CGFloat)wsf_centerX {
    return self.center.x;
}

#pragma mark - wsf_centerY
- (void)setWsf_centerY:(CGFloat)wsf_centerY {
    CGPoint center = self.center;
    center.y = wsf_centerY;
    self.center = center;
}
- (CGFloat)wsf_centerY {
    return self.center.y;
}

#pragma mark - wsf_size
- (void)setWsf_size:(CGSize)wsf_size {
    CGRect frame = self.frame;
    frame.size = wsf_size;
    self.frame = frame;
}
- (CGSize)wsf_size {
    return self.frame.size;
}

#pragma mark - wsf_origin
- (void)setWsf_origin:(CGPoint)wsf_origin {
    CGRect frame = self.frame;
    frame.origin = wsf_origin;
    self.frame = frame;
}
- (CGPoint)wsf_origin {
    return self.frame.origin;
}

@end
