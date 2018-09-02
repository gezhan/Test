//
//  WSFFieldOrderIntroductionView.h
//  WinShare
//
//  Created by QIjikj on 2018/1/17.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSFFieldOrderIntroductionVM;

@protocol WSFFieldOrderIntroductionViewDelegate <NSObject>

/** 跳转到空间详情界面*/
- (void)delegate_skipToSpaceDetailViewController;

@end

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WSFFieldOrderIntroductionViewType) {
    WSFFieldOrderIntroductionViewType_Transverse,       // 小图
    WSFFieldOrderIntroductionViewType_Longitudinal      // 大图
};

@interface WSFFieldOrderIntroductionView : UIView

@property (nonatomic, weak) id<WSFFieldOrderIntroductionViewDelegate> delegate;

- (instancetype)initWithPlaygroundOrderIntroductionVM:(WSFFieldOrderIntroductionVM *)playgroundOrderIntroductionVM playgroundOrderIntroductionViewType:(WSFFieldOrderIntroductionViewType)playgroundOrderIntroductionViewType;

@end
NS_ASSUME_NONNULL_END
