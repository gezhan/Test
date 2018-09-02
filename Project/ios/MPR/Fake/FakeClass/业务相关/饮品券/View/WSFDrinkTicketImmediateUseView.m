//
//  WSFDrinkTicketImmediateUseView.m
//  WinShare
//
//  Created by devRen on 2017/10/28.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDrinkTicketImmediateUseView.h"

static NSString * const kHeadViewImageNamed = @"huishou_one";
static NSString * const kMiddleViewImageNamed = @"huishou_two";
static NSString * const kFootViewImageNamed = @"huishou_three";
static NSString * const kHeadViewTitleText = @"饮品券二维码";
static NSString * const kConfirmButtonTitle = @"确定";
static NSString * const kMiddleViewHintText = @"请将饮品券二维码出示给商家";

@interface WSFDrinkTicketImmediateUseView()

@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UIImageView *middleView;
@property (nonatomic, strong) UIImageView *footView;
@property (nonatomic, strong) UIView *footLine;
@property (nonatomic, strong) UILabel *headViewTitle;
@property (nonatomic, strong) UILabel *middleViewHint;
@property (nonatomic, strong) UIImageView *QRCodeView;

@property (nonatomic, copy) NSString *QRCodeMessage;

@end

@implementation WSFDrinkTicketImmediateUseView

- (instancetype)initWithQRCodeMessage:(NSString *)meaasge {
    if (self = [super init]) {
        self.QRCodeMessage = meaasge;
        self.headView.hidden = NO;
        self.footView.hidden = NO;
        self.middleView.hidden = NO;
        self.footLine.hidden = NO;
        self.headViewTitle.hidden = NO;
        self.confirmButton.hidden = NO;
        self.middleViewHint.hidden = NO;
        self.QRCodeView.hidden = NO;
    }
    return self;
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

- (UIImageView *)footView {
    if (!_footView) {
        _footView = [[UIImageView alloc] init];
        _footView.userInteractionEnabled = YES;
        _footView.image = [UIImage imageNamed:kFootViewImageNamed];
        [self addSubview:_footView];
        [_footView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.height.equalTo(@44);
        }];
    }
    return _footView;
}

- (UIImageView *)middleView {
    if (!_middleView) {
        _middleView = [[UIImageView alloc] init];
        _middleView.image = [UIImage imageNamed:kMiddleViewImageNamed];
        [self addSubview:_middleView];
        [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.headView.mas_bottom);
            make.bottom.equalTo(self.footView.mas_top);
        }];
    }
    return _middleView;
}

- (UIView *)footLine {
    if (!_footLine) {
        _footLine = [[UIView alloc] init];
        _footLine.backgroundColor = [UIColor blackColor];
        [self.footView addSubview:_footLine];
        [_footLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(_footView);
            make.height.equalTo(@0.5);
        }];
    }
    return _footLine;
}

- (UILabel *)headViewTitle {
    if (!_headViewTitle) {
        _headViewTitle = [[UILabel alloc] init];
        _headViewTitle.font = SYSTEMFONT_16;
        _headViewTitle.textColor = HEX_COLOR_0x1A1A1A;
        _headViewTitle.text = kHeadViewTitleText;
        [self.headView addSubview:_headViewTitle];
        [_headViewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_headView);
        }];
    }
    return _headViewTitle;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:kConfirmButtonTitle forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = SYSTEMFONT_16;
        _confirmButton.titleLabel.textColor = HEX_COLOR_0x1A1A1A;
        _confirmButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_footView addSubview:_confirmButton];
        [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(_footView);
        }];
    }
    return _confirmButton;
}

- (UILabel *)middleViewHint {
    if (!_middleViewHint) {
        _middleViewHint = [[UILabel alloc] init];
        _middleViewHint.text = kMiddleViewHintText;
        _middleViewHint.textColor = HEX_COLOR_0x808080;
        _middleViewHint.font = SYSTEMFONT_11;
        [_middleView addSubview:_middleViewHint];
        [_middleViewHint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_middleView.mas_centerX);
            make.bottom.equalTo(_middleView.mas_bottom).mas_offset(-10);
        }];
    }
    return _middleViewHint;
}

- (UIImageView *)QRCodeView {
    if (!_QRCodeView) {
        _QRCodeView = [[UIImageView alloc] init];
        _QRCodeView.image = [UIImage createQRCodeImageWithMessage:[NSString stringWithFormat:@"QJDrinkTicket%@",_QRCodeMessage] size:86];
        
        NSLog(@"QJDrinkTicket = %@",[NSString stringWithFormat:@"QJDrinkTicket%@",_QRCodeMessage]);
                                     
        [_middleView addSubview:_QRCodeView];
        [_QRCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_middleView.mas_centerX);
            make.top.equalTo(_middleView.mas_top).mas_offset(10);
            make.width.height.equalTo(@86);
        }];
    }
    return _QRCodeView;
}

@end
