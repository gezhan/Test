//
//  WSFSpaceOrderIntroductionView.m
//  WinShare
//
//  Created by QIjikj on 2018/1/17.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFSpaceOrderIntroductionView.h"
#import "TicketViewController.h"
#import "SpaceDetailViewController.h"
#import "WSFRPPhotoApiModel.h"
#import "MineMessageVM.h"
#import "WSFSpaceIntroductionView.h"
#import "WSFSpaceIntroductionViewModel.h"
#import "WSFRPOrderApiModel.h"

@interface WSFSpaceOrderIntroductionView ()

@property (nonatomic, strong) UIButton *skipBtn;
@property (nonatomic, strong) UILabel *skipLabel;
@property (nonatomic, strong) UIImageView *spaceImageView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UILabel *memoryLabel;
@property (nonatomic, strong) UILabel *memoryNumLabel;
@property (nonatomic, strong) UILabel *pledgeLabel;

@property (nonatomic, strong) UILabel *sumLabel;
@property (nonatomic, strong) UIView *LineView1;
@property (nonatomic, strong) UIView *LineView2;

@property (nonatomic, strong) UILabel *ticketLabel;
@property (nonatomic, strong) UILabel *ticketTypeLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIControl *ticketControl;

@property (nonatomic, strong) UILabel *sumMoneyLabel;

@property (nonatomic, copy, readwrite) NSString *selectedTicketId;

/** view类型 */
@property (nonatomic, assign) WSFSpaceOrderIntroductionViewType orderIntroductionViewType;

@end


@implementation WSFSpaceOrderIntroductionView

- (instancetype)initWithOrderIntroductionViewType:(WSFSpaceOrderIntroductionViewType)orderIntroductionViewType
{
    if (self = [super init]) {
        _orderIntroductionViewType = orderIntroductionViewType;
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupViewContent];
    }
    return self;
}

- (instancetype)initWithOrderIntroductionModel:(WSFRPOrderApiModel* )orderIntroductionModel OrderIntroductionViewType:(WSFSpaceOrderIntroductionViewType)orderIntroductionViewType {
    if (self = [super init]) {
        _orderIntroductionViewType = orderIntroductionViewType;
        _orderIntroductionModel = orderIntroductionModel;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupViewContent];
    }
    return self;
}

- (void)unableSelecteTicketWithReason:(NSString *)resaon
{
    // 去掉优惠券的交互功能
    [self.arrowImageView setAlpha:0.0];
    [self.ticketControl setAlpha:0.0];
    
    [self.ticketTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
    }];
    
    // 优惠券类型
    self.ticketTypeLabel.text = resaon;
    
    // 没有优惠券的合计
    self.sumMoneyLabel.text = [NSString stringWithFormat:@"¥%0.2f", self.orderIntroductionModel.costPrice + self.orderIntroductionModel.depositPrice];
}

- (void)setOrderIntroductionModel:(WSFRPOrderApiModel *)orderIntroductionModel
{
    _orderIntroductionModel = orderIntroductionModel;
    
    //跳转到空间详情的按钮
    NSString *btnText = [NSString stringWithFormat:@"%@(%@)", orderIntroductionModel.roomName, orderIntroductionModel.roomAddress];
    [self.skipBtn setTitle:btnText forState:UIControlStateNormal];
    self.skipLabel.text = btnText;
    //空间的图片
    WSFRPPhotoApiModel *photoModel = orderIntroductionModel.picture;
    NSURL *imageUrl = [NSURL URLWithString:[NSString replaceString:photoModel.path]];
    [self.spaceImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"timg.jpeg"]];
    //预定时间
    NSDateFormatter *beginFormatter = [[NSDateFormatter alloc] init];
    beginFormatter.dateFormat = @"yyyy/MM/dd HH:mm";
    NSString *beginStr = [beginFormatter stringFromDate:orderIntroductionModel.beginTime];
    
    NSDateFormatter *endFormatter = [[NSDateFormatter alloc] init];
    endFormatter.dateFormat = @"HH:mm";
    NSString *endStr = [endFormatter stringFromDate:orderIntroductionModel.endTime];
    
    self.timeLabel.text = [NSString stringWithFormat:@"预定时间：%@~%@", beginStr, endStr];
    //单价
    self.priceLabel.text = [NSString stringWithFormat:@"单价：%0.0lf/小时", orderIntroductionModel.roomPrice];
    //时长
    self.durationLabel.text = [NSString stringWithFormat:@"时长：%@", orderIntroductionModel.duration];
    //费用
    self.memoryNumLabel.text = [NSString stringWithFormat:@"¥ %0.2f", orderIntroductionModel.costPrice];
    //押金
    //    self.pledgeLabel.text = [NSString stringWithFormat:@"押金：%ld元", orderIntroductionModel.depositPrice];
    
    if (!self.selectTicket) {// 不可跳转
        
        if (orderIntroductionModel.isUseCoupon) {
            // 优惠券类型
            self.ticketTypeLabel.text = orderIntroductionModel.couponAmountStr;
            
            // 优惠券id
            self.selectedTicketId = orderIntroductionModel.couponId;
            
            // 去掉优惠券的交互功能
            [self.arrowImageView setAlpha:0.0];
            [self.ticketControl setAlpha:0.0];
            
            //
            [self.ticketTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
            }];
        }else {
            // 优惠券类型
            self.ticketTypeLabel.text = @"";
            
            // 优惠券id
            self.selectedTicketId = orderIntroductionModel.couponId;
            
            // 去掉优惠券的交互功能
            [self.arrowImageView setAlpha:0.0];
            [self.ticketControl setAlpha:0.0];
            
            //
            [self.ticketTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
            }];
            
            // 重新布局 LineView2
            [self.LineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.LineView1.mas_top).offset(10);
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-10);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 1));
            }];
            
            // 优惠券名称
            self.ticketLabel.text = @"";
        }
        
    }else {// 可以跳转
        
        if (self.orderIntroductionModel.isHaveCoupon) {
            
            //优惠券类型
            self.ticketTypeLabel.text = orderIntroductionModel.couponAmountStr;
            
            //优惠券id
            self.selectedTicketId = orderIntroductionModel.couponId;
            
            // 恢复优惠券的交互功能
            [self.arrowImageView setAlpha:1.0];
            [self.ticketControl setAlpha:1.0];
            
            //
            [self.ticketTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-30);
            }];
            
        }else {
            
            //优惠券类型
            self.ticketTypeLabel.text = orderIntroductionModel.couponAmountStr;
            
            if ([orderIntroductionModel.couponAmountStr isEqualToString:@"无可用优惠券"]) {
                self.ticketTypeLabel.textColor = HEX_COLOR_0x1A1A1A;
            }
            
            //优惠券id
            self.selectedTicketId = orderIntroductionModel.couponId;
            
            // 去掉优惠券的交互功能
            [self.arrowImageView setAlpha:0.0];
            [self.ticketControl setAlpha:0.0];
            
            //
            [self.ticketTypeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
            }];
            
        }
    }
    
    //合计金额
    self.sumMoneyLabel.text = [NSString stringWithFormat:@"¥ %0.2f", orderIntroductionModel.payPrice];
    
}

- (void)setupViewContent
{
    if (_orderIntroductionViewType == WSFSpaceOrderIntroductionViewType_Other) {
        //跳转到空间详情的按钮
        self.skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.skipBtn setTitle:@"咖啡馆(低开银座)" forState:UIControlStateNormal];
        [self.skipBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.skipBtn setTitleColor:[UIColor colorWithHexString:@"1a1a1a"] forState:UIControlStateNormal];
        [self.skipBtn setImage:[UIImage imageNamed:@"xiangyou"] forState:UIControlStateNormal];
        self.skipBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.skipBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        self.skipBtn.imageEdgeInsets = UIEdgeInsetsMake(11, SCREEN_WIDTH-20, 0, 0);
        self.skipBtn.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 20);
        [self.skipBtn addTarget:self action:@selector(skipToSpaceDetailVC) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.skipBtn];
        [self.skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, HeightForFontSize(16)+20));
        }];
    } else {
        self.skipLabel = [[UILabel alloc] init];
        self.skipLabel.font = SYSTEMFONT_16;
        self.skipLabel.textColor = HEX_COLOR_0x1A1A1A;
        [self addSubview:self.skipLabel];
        [self.skipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 35));
        }];
    }
    
    WSFSpaceIntroductionViewModel *viewModel = [[WSFSpaceIntroductionViewModel alloc] initWithOrderIntroductionModel:_orderIntroductionModel];
    WSFSpaceIntroductionView *introductionView;
    if (_orderIntroductionViewType == WSFSpaceOrderIntroductionViewType_Other) {
        introductionView = [[WSFSpaceIntroductionView alloc] initWithIntroductionViewModel:viewModel spaceIntroductionViewType:WSFSpaceIntroductionViewType_Longitudinal];
        [self addSubview:introductionView];
        [introductionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.mas_equalTo(@35);
            if (viewModel.isHaveSetMeal) {
                make.bottom.equalTo(introductionView.bottomView.mas_bottom).mas_offset(20);
            } else {
                make.bottom.equalTo(introductionView.bottomView.mas_bottom).mas_offset(20);
            }
        }];
    }else {
        introductionView = [[WSFSpaceIntroductionView alloc] initWithIntroductionViewModel:viewModel spaceIntroductionViewType:WSFSpaceIntroductionViewType_Transverse];
        [self addSubview:introductionView];
        [introductionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.mas_equalTo(@35);
            make.bottom.equalTo(introductionView.bottomView.mas_bottom).mas_offset(10);
        }];
    }
    
    //费用
    self.memoryLabel = [[UILabel alloc] init];
    self.memoryLabel.font = [UIFont systemFontOfSize:16];
    self.memoryLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.memoryLabel.text = @"费用";
    [self addSubview:self.memoryLabel];
    [self.memoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        //        make.top.mas_equalTo(bgView.mas_bottom).offset(10);
        make.top.mas_equalTo(introductionView.mas_bottom).offset(10);
    }];
    
    // 费用number
    self.memoryNumLabel = [[UILabel alloc] init];
    self.memoryNumLabel.font = SYSTEMFONT_16;
    self.memoryNumLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.memoryNumLabel.text = @"¥500.00";
    [self addSubview:self.memoryNumLabel];
    [self.memoryNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.memoryLabel.mas_centerY);
    }];
    
    //押金
    //    self.pledgeLabel = [[UILabel alloc] init];
    //    self.pledgeLabel.font = [UIFont systemFontOfSize:16];
    //    self.pledgeLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    //    self.pledgeLabel.text = @"押金：5000元";
    //    [self addSubview:self.pledgeLabel];
    //    [self.pledgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(10);
    //        make.top.mas_equalTo(self.memoryLabel.mas_bottom).offset(10);
    //    }];
    //灰条
    self.LineView1 = [[UIView alloc] init];
    self.LineView1.backgroundColor = [UIColor clearColor];
    [self addSubview:self.LineView1];
    [self.LineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.memoryNumLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 1));
    }];
    //优惠券
    self.ticketLabel = [[UILabel alloc] init];
    self.ticketLabel.font = [UIFont systemFontOfSize:16];
    self.ticketLabel.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    self.ticketLabel.text = @"优惠券";
    [self addSubview:self.ticketLabel];
    [self.ticketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.LineView1.mas_bottom).offset(10);
    }];
    //优惠券类型
    self.ticketTypeLabel = [[UILabel alloc] init];
    self.ticketTypeLabel.font = [UIFont systemFontOfSize:16];
    self.ticketTypeLabel.textColor = HEX_COLOR_0xFF5959;
    self.ticketTypeLabel.text = @"选择优惠券";
    [self addSubview:self.ticketTypeLabel];
    [self.ticketTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.top.mas_equalTo(self.LineView1.mas_bottom).offset(10);
    }];
    //右箭头
    self.arrowImageView = [[UIImageView alloc] init];
    self.arrowImageView.image = [UIImage imageNamed:@"xiangyou"];
    [self addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.LineView1.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(9, 16));
    }];
    //灰条
    self.LineView2 = [[UIView alloc] init];
    self.LineView2.backgroundColor = [UIColor colorWithHexString:@"cccccc" alpha:0.5];
    [self addSubview:self.LineView2];
    [self.LineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ticketLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 1));
    }];
    
    //合计金额
    self.sumMoneyLabel = [[UILabel alloc] init];
    self.sumMoneyLabel.font = [UIFont systemFontOfSize:18];
    self.sumMoneyLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.sumMoneyLabel.text = @"¥8888";
    [self addSubview:self.sumMoneyLabel];
    [self.sumMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.LineView2.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
    }];
    
    //合计
    self.sumLabel = [[UILabel alloc] init];
    self.sumLabel.font = [UIFont systemFontOfSize:12];
    self.sumLabel.textColor = HEX_COLOR_0x808080;
    self.sumLabel.text = @"实付:";
    [self addSubview:self.sumLabel];
    [self.sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.sumMoneyLabel.mas_left);
        make.bottom.mas_equalTo(self.sumMoneyLabel.mas_bottom).mas_offset(-2);
    }];
    
    //在优惠券上加一个点击事件
    self.ticketControl = [[UIControl alloc] init];
    [self.ticketControl addTarget:self action:@selector(ticketAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.ticketControl];
    [self.ticketControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.LineView1.mas_bottom).offset(0);
        make.bottom.mas_equalTo(self.LineView2.mas_top).offset(0);
    }];
    
}

/** 跳转到优惠券选择界面 */
- (void)ticketAction
{
    __weak typeof(self) weakSelf = self;
    
    TicketViewController *ticketVC = [[TicketViewController alloc] init];
    ticketVC.skip = YES;
    ticketVC.orderId = self.orderId;
    ticketVC.payWayType = self.payWayType;
    ticketVC.previousTicketedId = self.selectedTicketId;
    ticketVC.selectTicketBlock = ^(NSString *ticketId, NSInteger ticketAmount) {
        
        // 可能会接着又点进去重新选择优惠券，所以需要在这里也打通一条渠道更改值
        weakSelf.selectedTicketId = ticketId;
        
        weakSelf.selectTicketBlock(ticketId, ticketAmount);
        
    };
    [self.viewController.navigationController pushViewController:ticketVC animated:NO];
}

/** 跳转到空间详情界面 */
- (void)skipToSpaceDetailVC
{
    SpaceDetailViewController *spaceDetailVC = [[SpaceDetailViewController alloc] init];
    spaceDetailVC.SpaceId = self.orderIntroductionModel.roomID;
    [self.viewController.navigationController pushViewController:spaceDetailVC animated:NO];
}

#pragma mark - lazyDown

- (NSString *)selectedTicketId
{
    if (!_selectedTicketId) {
        _selectedTicketId = @"";
    }
    return _selectedTicketId;
}

@end
