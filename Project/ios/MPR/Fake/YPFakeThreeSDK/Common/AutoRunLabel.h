//
//  AutoRunLabel.h
//  RUNLabel
//
//  Created by renwei on 13-3-19.
//  Copyright (c) 2013年 renwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoRunLabel : UILabel
{
    float _offsetX;
    CGSize _textSize;
    NSTimer *_updateTimer;
    float _moveSpeech;
    float _moveStep;
    float _textGap;
}
// 移动速度
@property(nonatomic,assign)float moveSpeech;
// 前后两次文字的间隔
@property(nonatomic,assign)float textGap;




@end
