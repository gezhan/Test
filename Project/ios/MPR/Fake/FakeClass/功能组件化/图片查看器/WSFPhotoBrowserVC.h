//
//  WSFPhotoBrowserVC.h
//  WinShare
//
//  Created by QIjikj on 2018/2/4.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFBaseViewController.h"

@interface WSFPhotoBrowserVC : WSFBaseViewController

/** 传入图片URL/URLString数组*/
- (void)setupPhotoURLList:(NSArray *)photoArray selectedIndex:(NSInteger)index;

/** 传入图片Image数组*/
- (void)setupPhotoImageList:(NSArray<UIImage *> *)photoArray selectedIndex:(NSInteger)index;

@end
