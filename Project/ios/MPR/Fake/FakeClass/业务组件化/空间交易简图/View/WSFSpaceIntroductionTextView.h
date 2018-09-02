//
//  WSFSpaceIntroductionTextView.h
//  WinShare
//
//  Created by devRen on 2017/12/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSFSpaceIntroductionViewModel;

NS_ASSUME_NONNULL_BEGIN
@interface WSFSpaceIntroductionTextView : UIView

/** 底部的Label */
@property (nonatomic, strong) UILabel *bottomLabel;

/**
 初始化

 @param introductionViewModel 空间简介ViewModel
 @return self
 */
- (instancetype)initWithIntroductionViewModel:(WSFSpaceIntroductionViewModel *)introductionViewModel;

@end
NS_ASSUME_NONNULL_END
