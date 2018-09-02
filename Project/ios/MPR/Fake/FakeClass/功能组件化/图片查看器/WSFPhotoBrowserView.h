//
//  WSFPhotoBrowserView.h
//  WinShare
//
//  Created by QIjikj on 2018/2/4.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSFPhotoBrowserView;
typedef void(^EnlargeBlock)(WSFPhotoBrowserView *view);

@interface WSFPhotoBrowserView : UIScrollView

@property (nonatomic, copy) EnlargeBlock enlargeBlock;

- (void)setupPhotoUrl:(NSURL *)url;
- (void)setupPhoto:(UIImage *)photo;
- (void)recoveryNormalMode;

@end
