//
//  WSFFieldIntroductionView.h
//  WinShare
//
//  Created by QIjikj on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//  订单详情-大场地-大场地简介View

#import <UIKit/UIKit.h>
@class WSFFieldIntroductionVM;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WSFFieldIntroductionViewType) {
    WSFFieldIntroductionViewType_Transverse,       // 小图
    WSFFieldIntroductionViewType_Longitudinal      // 大图
};

@interface WSFFieldIntroductionView : UIView

- (instancetype)initWithPlaygroundIntroductionVM:(WSFFieldIntroductionVM *)playgroundIntroductionVM playgroundIntroductionViewType:(WSFFieldIntroductionViewType)playgroundIntroductionViewType;

@end
NS_ASSUME_NONNULL_END
