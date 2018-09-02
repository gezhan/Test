//
//  WSFDrinkTicketCell.m
//  WinShare
//
//  Created by devRen on 2017/10/27.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDrinkTicketCell.h"
#import "WSFDrinkTicketImmediateUseVC.h"
#import "TicketModel.h"

static NSString * const kbgLeftImageViewImage = @"youhuiquan_white_left";
static NSString * const kbgRightImageViewImage = @"youhuiquan_white_right";
static NSString * const kImmediateUseButtonTitle = @"立即使用";

@interface WSFDrinkTicketCell()

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIImageView *bgLeftImageView;
@property (nonatomic, strong) UIImageView *bgRightImageView;

@property (nonatomic, strong) UILabel *ticketTypeLabel;
@property (nonatomic, strong) UIButton *immediateUseButton;
@property (nonatomic, strong) UIView *baseCenterView;

@property (nonatomic, strong) UILabel *ticketNameLabel;
@property (nonatomic, strong) UILabel *ticketMessageOtherLabel;
@property (nonatomic, strong) UIView *dotOtherView;

@property (nonatomic, strong) UILabel *invalidLabel;

@property (nonatomic, assign) WSFDrinkTicketCellType cellType;
@property (nonatomic, assign) TicketModel *ticketModel;

@end

@implementation WSFDrinkTicketCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellType:(WSFDrinkTicketCellType)cellType {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _cellType = cellType;
        self.baseView.hidden = NO;
        self.bgLeftImageView.hidden = NO;
        self.bgRightImageView.hidden = NO;
        self.baseCenterView.hidden = NO;
        self.ticketTypeLabel.hidden = NO;
        if (_cellType == WSFDrinkTicketCellType_valid) {
            self.immediateUseButton.hidden = NO;
        } else {
            self.invalidLabel.hidden = NO;
        }
        self.ticketNameLabel.hidden = NO;
    }
    return self;
}

- (void)layoutSubviews {
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.ticketMessageOtherLabel.mas_bottom).offset(15);
    }];
    [super layoutSubviews];
}

#pragma mark - 赋值
- (void)theAssignmentWithTicketModel:(TicketModel *)ticketModel {
    _ticketModel = ticketModel;
    _ticketTypeLabel.text = [NSString stringWithFormat:@"%0.1f%@", ticketModel.amount, ticketModel.amountType];
    _ticketNameLabel.text = ticketModel.couponName;
    [self addTicketMessageWithLimitsArray:ticketModel.limits];
}

#pragma mark - 点击事件
- (void)immediateUseButtonClick:(UIButton *)sender {
    WSFDrinkTicketImmediateUseVC *vc = [[WSFDrinkTicketImmediateUseVC alloc] init];
    vc.couponCode = _ticketModel.couponCode;
    vc.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.viewController presentViewController:vc animated:NO completion:nil];
}

#pragma mark - 添加饮品券描述
- (void)addTicketMessageWithLimitsArray:(NSArray<NSString *> *)limitsArray {
    for (int i = 0; i < limitsArray.count; i ++) {
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.text = limitsArray[i];
        if (_cellType == WSFDrinkTicketCellType_valid) {
            messageLabel.textColor = HEX_COLOR_0x808080;
        } else {
            messageLabel.textColor = HEX_COLOR_0xCCCCCC;
        }
        
        messageLabel.font = SYSTEMFONT_12;
        messageLabel.numberOfLines = 0;
        [self.bgRightImageView addSubview:messageLabel];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_ticketNameLabel.mas_bottom).offset(10 + i * 24);
            make.left.mas_equalTo(self.bgRightImageView.mas_left).offset(17);
            make.right.mas_equalTo(self.bgRightImageView.mas_right).offset(-10);
        }];
        
        UIView *dotView = [[UIView alloc] init];
        if (_cellType == WSFDrinkTicketCellType_valid) {
            dotView.backgroundColor = HEX_COLOR_0x808080;
        } else {
            dotView.backgroundColor = HEX_COLOR_0xCCCCCC;
        }
        [self.bgRightImageView addSubview:dotView];
        [dotView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgRightImageView.mas_left).offset(10);
            make.centerY.mas_equalTo(messageLabel.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(2, 2));
        }];
        
        _ticketMessageOtherLabel = messageLabel;
        _dotOtherView = dotView;
    }
    [self layoutIfNeeded];
}

#pragma mark - 懒加载
- (UIView *)baseView {
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        [self.contentView addSubview:_baseView];
        [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(10);
            make.left.mas_equalTo(self.contentView.mas_left).offset(25);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-25);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
        }];
    }
    return _baseView;
}

- (UIImageView *)bgLeftImageView {
    if (!_bgLeftImageView) {
        _bgLeftImageView = [[UIImageView alloc] init];
        _bgLeftImageView.image = [[UIImage imageNamed:kbgLeftImageViewImage] resizingImageState];
        _bgLeftImageView.userInteractionEnabled = YES;
        [self.baseView addSubview:_bgLeftImageView];
        [self.bgLeftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.baseView.mas_top).offset(0);
            make.left.mas_equalTo(self.baseView.mas_left).offset(0);
            make.width.mas_equalTo(83);
            make.bottom.mas_equalTo(self.baseView.mas_bottom).offset(0);
        }];
    }
    return _bgLeftImageView;
}

- (UIImageView *)bgRightImageView {
    if (!_bgRightImageView) {
        _bgRightImageView = [[UIImageView alloc] init];
        _bgRightImageView.image = [[UIImage imageNamed:kbgRightImageViewImage] resizingImageState];
        [self.baseView addSubview:_bgRightImageView];
        [self.bgRightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.baseView.mas_top).offset(0);
            make.right.mas_equalTo(self.baseView.mas_right).offset(0);
            make.left.mas_equalTo(self.bgLeftImageView.mas_right).offset(0);
            make.bottom.mas_equalTo(self.baseView.mas_bottom).offset(0);
        }];
    }
    return _bgRightImageView;
}

- (UIView *)baseCenterView {
    if (!_baseCenterView) {
        _baseCenterView = [[UIView alloc] init];
        [self.bgLeftImageView addSubview:_baseCenterView];
        [_baseCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgLeftImageView.mas_left);
            make.right.mas_equalTo(self.bgLeftImageView.mas_right);
            make.center.mas_equalTo(self.bgLeftImageView);
            make.height.equalTo(@50);
        }];
    }
    return _baseCenterView;
}

- (UILabel *)ticketTypeLabel {
    if (!_ticketTypeLabel) {
        _ticketTypeLabel = [[UILabel alloc] init];
        if (_cellType == WSFDrinkTicketCellType_valid) {
            _ticketTypeLabel.textColor = HEX_COLOR_0xFF3142;
        } else {
            _ticketTypeLabel.textColor = HEX_COLOR_0xCCCCCC;
        }
        _ticketTypeLabel.font = SYSTEMFONT_16;
        _ticketNameLabel.textAlignment = NSTextAlignmentCenter;
        [_baseCenterView addSubview:self.ticketTypeLabel];
        [_ticketTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if (_cellType == WSFDrinkTicketCellType_valid) {
                make.top.mas_equalTo(_baseCenterView.mas_top);
                make.centerX.mas_equalTo(_baseCenterView.mas_centerX);
            } else {
                make.centerY.mas_equalTo(_baseCenterView.mas_centerY);
                make.centerX.mas_equalTo(_baseCenterView.mas_centerX);
            }
            
        }];
    }
    return _ticketTypeLabel;
}

- (UIButton *)immediateUseButton {
    if (!_immediateUseButton) {
        _immediateUseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_immediateUseButton setTitle:kImmediateUseButtonTitle forState:UIControlStateNormal];
        [_immediateUseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_immediateUseButton addTarget:self action:@selector(immediateUseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _immediateUseButton.layer.masksToBounds = YES;
        _immediateUseButton.layer.cornerRadius = 12;
        _immediateUseButton.layer.borderWidth = 0.5;
        _immediateUseButton.layer.borderColor = [UIColor blackColor].CGColor;
        _immediateUseButton.titleLabel.font = SYSTEMFONT_12;
        _immediateUseButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_bgLeftImageView addSubview:_immediateUseButton];
        [_immediateUseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_ticketTypeLabel.mas_bottom).mas_offset(10);
            make.centerX.mas_equalTo(_baseCenterView.mas_centerX);
            make.width.mas_equalTo(@65);
            make.height.mas_equalTo(@24);
        }];
    }
    return _immediateUseButton;
}

- (UILabel *)ticketNameLabel {
    if (!_ticketNameLabel) {
        _ticketNameLabel = [[UILabel alloc] init];
        if (_cellType == WSFDrinkTicketCellType_valid) {
            _ticketNameLabel.textColor = HEX_COLOR_0x1A1A1A;
        } else {
            _ticketNameLabel.textColor = HEX_COLOR_0xCCCCCC;
        }
        _ticketNameLabel.font = SYSTEMFONT_16;
        [_bgRightImageView addSubview:self.ticketNameLabel];
        [_ticketNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgRightImageView.mas_top).offset(15);
            make.left.mas_equalTo(self.bgRightImageView.mas_left).offset(10);
        }];
    }
    return _ticketNameLabel;
}

- (UILabel *)invalidLabel {
    if (!_invalidLabel) {
        _invalidLabel = [[UILabel alloc] init];
        [_invalidLabel setText:@"(已失效)"];
        [_invalidLabel setFont:[UIFont systemFontOfSize:12]];
        [_invalidLabel setTextColor:[UIColor colorWithHexString:@"#cccccc"]];
        [_bgRightImageView addSubview:_invalidLabel];
        [_invalidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.ticketNameLabel.mas_centerY).offset(0);
            make.left.mas_equalTo(self.ticketNameLabel.mas_right).offset(2);
        }];
    }
    return _invalidLabel;
}

@end
