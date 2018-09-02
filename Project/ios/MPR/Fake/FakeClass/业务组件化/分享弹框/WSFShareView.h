//
//  WSFShareView.h
//  WinShare
//
//  Created by devRen on 2017/11/28.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, WSFShareViewType) {
    WSFShareViewType_Normal,    // 常规样式
    WSFShareViewType_Reminder   // 带提示信息样式
};

@interface WSFShareMessageModel : NSObject

/** 分享提示 */
@property (nonatomic, copy) NSString * _Nullable shareReminder;
/** 分享出去的标题 */
@property (nonatomic, copy) NSString *shareTitle;
/** 分享出去的描述 */
@property (nonatomic, copy) NSString *shareDescr;
/** 分享出去的图片 */
@property (nonatomic, strong) UIImage *shareThumImage;
/** 分享出去的链接 */
@property (nonatomic, copy) NSString *shareURL;
/** 分享 view 样式 */
@property (nonatomic, assign) WSFShareViewType shareViewType;

@end

@interface WSFShareView : UIView

/**
 弹出分享视图

 @param shareMessageModel 分享信息模型
 */
+ (void)showWithShareMessageModel:(nonnull WSFShareMessageModel *)shareMessageModel;

@end
NS_ASSUME_NONNULL_END

