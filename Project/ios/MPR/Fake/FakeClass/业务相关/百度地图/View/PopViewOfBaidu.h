//
//  PopViewOfBaidu.h
//  WinShare
//
//  Created by GZH on 2017/5/14.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpaceMessageModel;

@interface PopViewOfBaidu : UIView

@property (nonatomic, strong) UIImageView *spaceImage;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UILabel *peopleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) SpaceMessageModel *model;

@end
