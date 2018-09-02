//
//  WSFDrinkTicketReclaimDetailView.m
//  WinShare
//
//  Created by devRen on 2017/10/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDrinkTicketReclaimDetailView.h"
#import "TicketModel.h"

static NSString * const kHeadViewImageNamed = @"huishou_one";
static NSString * const kMiddleViewImageNamed = @"huishou_two_bulasheng";
static NSString * const kFootViewImageNamed = @"huishou_three";
static NSString * const kConfirmButtonTitle = @"回收";

// yyyy-MM-dd HH:mm:ss -> 有效时间 ：yyyy-MM-dd
static NSString *conversionTimeWithDateString(NSString *dateString) {
    return [NSString stringWithFormat:@"有效时间 ：%@",[dateString substringToIndex:10]];
}

@interface WSFDrinkTicketReclaimDetailView()

@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UIView *middleView;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) UIView *footLine;
@property (nonatomic, strong) UILabel *headViewTitle;
@property (nonatomic, strong) UILabel *endMeaasge;

@property (nonatomic, strong) TicketModel *ticketModel;

@end

@implementation WSFDrinkTicketReclaimDetailView

- (instancetype)initWithDrinkTicketModel:(TicketModel *)drinkTicketModel {
    if (self = [super init]) {
        _ticketModel = drinkTicketModel;
        self.headView.hidden = NO;
        self.middleImageView.hidden = NO;
        [self addTicketMessageWithTicketModel:_ticketModel];
        self.middleView.hidden = NO;
        self.confirmButton.hidden = NO;
        self.footLine.hidden = NO;
        self.headViewTitle.hidden = NO;
        [self insertSubview:_middleView atIndex:0];
        self.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark - 添加描述
- (void)addTicketMessageWithTicketModel:(TicketModel *)drinkTicketModel {
    for (int i = 0; i < drinkTicketModel.limits.count + 1; i ++) {
        UILabel *messageLabel = [[UILabel alloc] init];
        if (i < drinkTicketModel.limits.count) {
            messageLabel.text = [NSString stringWithFormat:@"使用条件 ：%@",drinkTicketModel.limits[i]];
        } else {
            messageLabel.text = conversionTimeWithDateString(drinkTicketModel.endTime);
        }
        messageLabel.font = SYSTEMFONT_11;
        messageLabel.textColor = HEX_COLOR_0x808080;
        [self.middleImageView addSubview:messageLabel];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headView.mas_bottom).mas_offset(10 + i * 22);
            make.left.equalTo(_middleImageView.mas_left).mas_offset(10);
        }];
        self.endMeaasge = messageLabel;
    }
}

#pragma mark - 懒加载
- (UIImageView *)headView {
    if (!_headView) {
        _headView = [[UIImageView alloc] init];
        _headView.image = [UIImage imageNamed:kHeadViewImageNamed];
        [self addSubview:_headView];
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(@44);
        }];
    }
    return _headView;
}

- (UIImageView *)middleImageView {
    if (!_middleImageView) {
        _middleImageView = [[UIImageView alloc] init];
        _middleImageView.image = [UIImage imageNamed:kMiddleViewImageNamed];
        [self addSubview:_middleImageView];
        [_middleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.headView.mas_bottom);
        }];
    }
    return _middleImageView;
}

- (UIView *)middleView {
    if (!_middleView) {
        _middleView = [[UIView alloc] init];
        _middleView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_middleView];
        [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(_middleImageView.mas_bottom);
            make.bottom.equalTo(_endMeaasge.mas_bottom).mas_offset(10);
        }];
    }
    return _middleView;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setBackgroundImage:[UIImage imageNamed:kFootViewImageNamed] forState:UIControlStateNormal];
        [_confirmButton setTitle:kConfirmButtonTitle forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = SYSTEMFONT_16;
        _confirmButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//        _confirmButton.enabled = _ticketModel.isCanUse;
        if (_ticketModel.isCanUse) {
            [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        } else {
            _confirmButton.userInteractionEnabled = NO;
            [_confirmButton setTitleColor:HEX_COLOR_0xCCCCCC forState:UIControlStateNormal];
        }
        
        [self addSubview:_confirmButton];
        [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(_middleView.mas_bottom);
            make.height.equalTo(@44);
        }];
    }
    return _confirmButton;
}

- (UIView *)footLine {
    if (!_footLine) {
        _footLine = [[UIView alloc] init];
        _footLine.backgroundColor = HEX_COLOR_0xE6E6E6;
        [_confirmButton addSubview:_footLine];
        [_footLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(_confirmButton);
            make.height.equalTo(@0.5);
        }];
    }
    return _footLine;
}

- (UILabel *)headViewTitle {
    if (!_headViewTitle) {
        _headViewTitle = [[UILabel alloc] init];
        _headViewTitle.font = SYSTEMFONT_16;
        _headViewTitle.textColor = HEX_COLOR_0xFF3142;
        _headViewTitle.text = _ticketModel.couponName;
        [self.headView addSubview:_headViewTitle];
        [_headViewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_headView);
        }];
    }
    return _headViewTitle;
}

@end
