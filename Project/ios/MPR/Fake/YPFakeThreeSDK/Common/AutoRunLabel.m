//
//  AutoRunLabel.m
//  RUNLabel
//
//  Created by renwei on 13-3-19.
//  Copyright (c) 2013年 renwei. All rights reserved.
//

#import "AutoRunLabel.h"

#define  LOGCGSIZE(size)     NSLog(@"%s%d %f %f \n",__func__,__LINE__,(size).width,(size).height)

#import <QuartzCore/QuartzCore.h>


@implementation AutoRunLabel

-(void)setupView{
    // 10 px/s
    self.moveSpeech = 10.0f;
    self.textGap = 1.5 * [super font].lineHeight ;
    [self setup];
}

-(void)nextFrame{
    _offsetX += _moveStep;
    if (_moveStep > 0) {
        if (_offsetX > _textSize.width + _textGap ) {
            _offsetX -= _textGap+_textSize.width ;
        }
    }else{
        if (_offsetX < -_textSize.width - _textGap ) {
            _offsetX += _textGap+_textSize.width ;
        }
    }
    [self setNeedsDisplay];
}

- (void)setup{
    _offsetX = 0;
    _textSize = [self.text sizeWithFont:[super font] forWidth:NSIntegerMax lineBreakMode:NSLineBreakByClipping];
    if (_textSize.width>self.bounds.size.width) {
        if (_updateTimer) {
            //已经有定时器了....
//            [_updateTimer fire];
        }else{
            _updateTimer = [NSTimer scheduledTimerWithTimeInterval:1/30.0f target:self selector:@selector(nextFrame) userInfo:nil  repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_updateTimer forMode:NSRunLoopCommonModes];
        }
    }else{
        [_updateTimer invalidate];
        _updateTimer = nil;
    }
}

-(void)setText:(NSString *)text{
    [super setText:text];
    [self setup];
}

-(void)setMoveSpeech:(float)moveSpeech{
    _moveSpeech = moveSpeech;
    _moveStep = _moveSpeech/30.0f;
}


-(void)drawTextInRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetShouldAntialias(context, YES);
    //绘制第一层
    float offsetY = (rect.size.height - _textSize.height)/2 ;
    if((_offsetX <0 && _offsetX > -_textSize.width +rect.size.width ) || (_offsetX == 0 &&_textSize.width<rect.size.width) ){
        //         [window]
        //  this is window not
        //  只需要绘制 1 次
        //  预防    [window  ]
        //          window
        [super drawTextInRect:CGRectMake(_offsetX, offsetY, _textSize.width, _textSize.height)];
    }else {
        //         [window]
        //  this is w   this is w
        float o1,o2;
        o1 = _offsetX > 0 ? _offsetX - _textSize.width - _textGap : _offsetX ;
        o2 = o1 + _textSize.width + _textGap;
        [super drawTextInRect:CGRectMake(o1, offsetY, _textSize.width, _textSize.height)];
        [super drawTextInRect:CGRectMake(o2, offsetY, _textSize.width, _textSize.height)];
    }
    CGContextRestoreGState(context);
    CGContextFlush(context);
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupView];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setup];
}
-(void)setBounds:(CGRect)bounds{
    [super setBounds:bounds];
    [self setup];
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setup];
}
@end
