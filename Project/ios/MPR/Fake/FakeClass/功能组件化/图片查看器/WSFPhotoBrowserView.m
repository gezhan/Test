//
//  WSFPhotoBrowserView.m
//  WinShare
//
//  Created by QIjikj on 2018/2/4.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFPhotoBrowserView.h"
#import "UIImageView+WebCache.h"
#import "UIView+WSF_Frame.h"

@interface WSFPhotoBrowserView () <UIScrollViewDelegate>
@property (assign, nonatomic) CGPoint touchLocation;
@property (assign, nonatomic) BOOL isEnlarge;
@property (strong, nonatomic) UIImageView *imageView;
@property (assign, nonatomic) CGFloat maxZoomScale;
@property (assign, nonatomic) CGSize normalImageSize;

@end

@implementation WSFPhotoBrowserView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        
        // 重新添加双击手势
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        
        self.delegate = self;
        
    }
    return self;
}

- (void)setupPhotoUrl:(NSURL *)url
{
    [self.imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        self.imageView.height = image.size.height/image.size.width*self.width;
        self.imageView.wsf_centerY = self.wsf_centerY-10;
        self.normalImageSize = self.imageView.size;
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = self.maxZoomScale;
    }];
}

- (void)setupPhoto:(UIImage *)photo
{
    self.imageView.image = photo;
    self.imageView.height = photo.size.height/photo.size.width*self.width;
    self.imageView.wsf_centerY = self.wsf_centerY-10;
    self.normalImageSize = self.imageView.size;
    self.minimumZoomScale = 1.0;
    self.maximumZoomScale = self.maxZoomScale;
}

// 获取点击坐标
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    self.touchLocation = [touch locationInView:self.window];
}

// 双击事件
- (void)doubleTapAction
{
    if (self.isEnlarge) {
        [self recoveryNormalMode];
        if (self.enlargeBlock) {
            self.enlargeBlock(nil);
        }
    }
    else {
        [self becomeEnlargeMode];
        if (self.enlargeBlock) {
            self.enlargeBlock(self);
        }
    }
}


// 获取最大放大比例
- (CGFloat)maxZoomScale
{
    if (!_maxZoomScale) {
        CGFloat imageScaleMax = MAX(self.imageView.image.size.width/self.width, self.imageView.image.size.height/(self.height));
        _maxZoomScale = MAX(self.height/self.imageView.height, imageScaleMax);}
    return _maxZoomScale;
}
// 变为大图模式
- (void)becomeEnlargeMode
{
    [UIView animateWithDuration:0.5 animations:^{
        self.zoomScale = self.maxZoomScale;
        [self setEnlargeOffset];
        self.isEnlarge = YES;
    }];
}

// 恢复普通模式
- (void)recoveryNormalMode
{
    [UIView animateWithDuration:0.5 animations:^{
        self.zoomScale = 1.0;
        self.isEnlarge = NO;
    }];
}

// 设置大图状态下的坐标
- (void)setEnlargeOffset
{
    CGFloat offsetX = self.touchLocation.x*self.maxZoomScale - self.width/2;
    CGFloat offsetY = (self.touchLocation.y- (self.height- self.normalImageSize.height)/2 )*self.maxZoomScale - self.height/2;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    else if (offsetX > self.imageView.width-self.width) {
        offsetX = self.imageView.width-self.width;
    }
    
    if (offsetY < 0) {
        offsetY = 0;
    }
    else if (offsetY > self.imageView.height - self.height) {
        offsetY = self.imageView.height - self.height;
    }
    
    self.contentOffset = CGPointMake(offsetX, offsetY);
}


#pragma mark - ScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (self.bounds.size.width > self.contentSize.width)?(self.bounds.size.width - self.contentSize.width)/2 : 0.0;
    CGFloat offsetY = (self.bounds.size.height > self.contentSize.height)?(self.bounds.size.height - self.contentSize.height)/2 : 0.0;
    self.imageView.center = CGPointMake(self.contentSize.width/2 + offsetX, self.contentSize.height/2 + offsetY);
    
    self.isEnlarge = (self.zoomScale != 1.0) ;
    
}

@end
