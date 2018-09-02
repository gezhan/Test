//
//  WSFActivityOrderIntroductionView.h
//  WinShare
//
//  Created by ZWL on 2018/3/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSFActivityOrderIntroductionVM.h"

@protocol WSFActivityOrderIntroductionViewDelegate <NSObject>

/** 跳转到空间详情界面*/
- (void)delegate_skipToSpaceDetailViewController;

@end

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WSFActivityOrderIntroductionViewType) {
    WSFActivityOrderIntroductionViewType_Transverse,       // 小图
    WSFActivityOrderIntroductionViewType_Longitudinal      // 大图
};

@interface WSFActivityOrderIntroductionView : UIView

@property (nonatomic, weak) id<WSFActivityOrderIntroductionViewDelegate> delegate;

- (instancetype)initWithActivityOrderIntroductionVM:(WSFActivityOrderIntroductionVM *)activityOrderIntroductionVM activityOrderIntroductionViewType:(WSFActivityOrderIntroductionViewType)activityOrderIntroductionViewType;

@end
NS_ASSUME_NONNULL_END
