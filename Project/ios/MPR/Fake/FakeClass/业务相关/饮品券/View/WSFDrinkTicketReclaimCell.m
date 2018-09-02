//
//  WSFDrinkTicketReclaimCell.m
//  WinShare
//
//  Created by devRen on 2017/10/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDrinkTicketReclaimCell.h"

// yyyy-MM-dd HH:mm:ss -> yyyy-MM-dd
static NSString *conversionTimeWithDateString(NSString *dateString) {
    return [dateString substringToIndex:10];
}

@interface WSFDrinkTicketReclaimCell()

@property (nonatomic, strong) UILabel *ticketName;
@property (nonatomic, strong) UILabel *reclaimTime;
@property (nonatomic, strong) UILabel *ticketDescribe;
@property (nonatomic, strong) UIView *endLine;

@end

@implementation WSFDrinkTicketReclaimCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.ticketName.hidden = NO;
    }
    return self;
}

#pragma mark - set
- (void)setBackAPIModel:(WSFDrinkTicketBackAPIModel *)backAPIModel {
    _backAPIModel = backAPIModel;
    _ticketName.text = _backAPIModel.name;
    [self addTicketDescribesWithLimits:_backAPIModel.limits];
    self.reclaimTime.hidden = NO;
    self.endLine.hidden = NO;
}

#pragma mark - 添加描述
- (void)addTicketDescribesWithLimits:(NSArray *)limits {
    for (NSInteger i = 0; i < limits.count; i ++) {
        UILabel *describeLabel = [[UILabel alloc] init];
        describeLabel.textColor = HEX_COLOR_0x808080;
        describeLabel.font = SYSTEMFONT_12;
        describeLabel.text = limits[i];
        [self addSubview:describeLabel];
        [describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_ticketName.mas_bottom).mas_offset(10 + 22 * i);
            make.left.equalTo(self.mas_left).mas_offset(10);
        }];
        self.ticketDescribe = describeLabel;
    }
}

#pragma mark - 懒加载
- (UILabel *)ticketName {
    if (!_ticketName) {
        _ticketName = [[UILabel alloc] init];
        _ticketName.font = SYSTEMFONT_14;
        _ticketName.textColor = HEX_COLOR_0x1A1A1A;
        [self addSubview:_ticketName];
        [_ticketName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).mas_offset(10);
            make.top.equalTo(self.mas_top).mas_offset(10);
        }];
    }
    return _ticketName;
}

- (UILabel *)reclaimTime {
    if (!_reclaimTime) {
        _reclaimTime = [[UILabel alloc] init];
        _reclaimTime.text = [NSString stringWithFormat:@"回收时间 ：%@",conversionTimeWithDateString(_backAPIModel.backTime)];
        _reclaimTime.font = SYSTEMFONT_12;
        _reclaimTime.textColor = HEX_COLOR_0x808080;
        [self addSubview:_reclaimTime];
        [_reclaimTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).mas_offset(10);
            make.top.equalTo(self.ticketDescribe.mas_bottom).mas_offset(10);
        }];
    }
    return _reclaimTime;
}

- (UIView *)endLine {
    if (!_endLine) {
        _endLine = [[UIView alloc] init];
        _endLine.backgroundColor = HEX_COLOR_0xE6E6E6;
        [self addSubview:_endLine];
        [_endLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(_reclaimTime.mas_bottom).mas_offset(10);
            make.bottom.equalTo(self.mas_bottom);
            make.height.equalTo(@5);
        }];
    }
    return _endLine;
}

@end
