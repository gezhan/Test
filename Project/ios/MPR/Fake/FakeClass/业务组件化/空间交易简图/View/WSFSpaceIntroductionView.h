//
//  WSFSpaceIntroductionView.h
//  WinShare
//
//  Created by devRen on 2017/12/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSFSpaceIntroductionViewModel;

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, WSFSpaceIntroductionViewType) {
    WSFSpaceIntroductionViewType_Transverse,        // 小图
    WSFSpaceIntroductionViewType_Longitudinal       // 大图
};

@interface WSFSpaceIntroductionView : UIView

/** 底部的View */
@property (nonatomic ,strong) UIView *bottomView;

/**
 初始化方法

 @param introductionViewModel 空间简介ViewModel
 @param spaceIntroductionViewType 空间简介类型
 @return self
 */
- (instancetype)initWithIntroductionViewModel:(WSFSpaceIntroductionViewModel *)introductionViewModel spaceIntroductionViewType:(WSFSpaceIntroductionViewType)spaceIntroductionViewType;

@end
NS_ASSUME_NONNULL_END
