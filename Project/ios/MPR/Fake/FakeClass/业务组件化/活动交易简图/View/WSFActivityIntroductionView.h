//
//  WSFActivityIntroductionView.h
//  WinShare
//
//  Created by ZWL on 2018/3/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSFActivityDetailIntroductionVM.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WSFActivityIntroductionViewType) {
    WSFActivityIntroductionViewType_Transverse,       // 小图
    WSFActivityIntroductionViewType_Longitudinal      // 大图
};

@interface WSFActivityIntroductionView : UIView

- (instancetype)initWithPlaygroundIntroductionVM:(WSFActivityDetailIntroductionVM *)activityIntroductionVM playgroundIntroductionViewType:(WSFActivityIntroductionViewType)activityIntroductionViewType;

@end
NS_ASSUME_NONNULL_END
