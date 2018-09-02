//
//  PositionLocationView.h
//  WinShare
//
//  Created by GZH on 2017/5/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaiduHeader.h"

typedef void(^BackBlock)(NSString *str, CLLocationCoordinate2D coor);

@interface PositionLocationView : UIView

@property (nonatomic, strong) UIImageView *signImage;
@property (nonatomic, strong) UIImageView *locationImage;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) NSString *locationStr;


@property (nonatomic, copy) BackBlock backBlock;

@end
