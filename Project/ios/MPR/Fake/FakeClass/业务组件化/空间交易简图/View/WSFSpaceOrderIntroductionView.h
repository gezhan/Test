//
//  WSFSpaceOrderIntroductionView.h
//  WinShare
//
//  Created by QIjikj on 2018/1/17.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WSFRPOrderApiModel;

typedef NS_ENUM(NSInteger, WSFSpaceOrderIntroductionViewType) {
    WSFSpaceOrderIntroductionViewType_Other,         // 其他
    WSFSpaceOrderIntroductionViewType_ConfirmOrder,  // 确定订单
};

/** 返回选中的优惠券的ID和面值。“不使用优惠券”返回的是@“”和0 */
typedef void(^selectTicketBlock)(NSString *ticketId, NSInteger ticketAmount);

@interface WSFSpaceOrderIntroductionView : UIView

/** 是否需要跳转进优惠券的选择列表（该选项确定了UI的基本布局） */
@property (nonatomic, assign, getter=isSelectTicket) BOOL selectTicket;

@property (nonatomic, strong) WSFRPOrderApiModel *orderIntroductionModel;

/** 当前选择的优惠券ID。不使用优惠券-返回空字符串 */
@property (nonatomic, copy, readonly) NSString *selectedTicketId;

/** 如果进入的是优惠券的选择界面，选择任何一张优惠券后的回调block */
@property (nonatomic, copy) selectTicketBlock selectTicketBlock;

/** 为指定的订单绑定优惠券 */
@property (nonatomic, copy) NSString *orderId;

/** 为指定的    Z_F方式绑定优惠券 */
@property (nonatomic, assign) WSFPayWayType payWayType;

/**
 初始化view
 
 @param orderIntroductionViewType view类型
 @return self
 */
- (instancetype)initWithOrderIntroductionViewType:(WSFSpaceOrderIntroductionViewType)orderIntroductionViewType;

- (instancetype)initWithOrderIntroductionModel:(WSFRPOrderApiModel* )orderIntroductionModel OrderIntroductionViewType:(WSFSpaceOrderIntroductionViewType)orderIntroductionViewType;
/**
 使得优惠券选择一栏不可选择
 @param resaon 不可选的原因
 */
- (void)unableSelecteTicketWithReason:(NSString *)resaon;

@end
