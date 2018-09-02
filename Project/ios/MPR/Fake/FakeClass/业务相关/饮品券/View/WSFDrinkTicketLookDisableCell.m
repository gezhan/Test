//
//  WSFDrinkTicketLookDisableCell.m
//  WinShare
//
//  Created by devRen on 2017/10/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFDrinkTicketLookDisableCell.h"
#import "WSFDrinkTicketInvalidVC.h"

static NSString * const kDisabledTicketBtnTitle = @"查看失效券>>";

@interface WSFDrinkTicketLookDisableCell ()

@property (nonatomic, strong) UIButton *disabledTicketBtn;

@end

@implementation WSFDrinkTicketLookDisableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViewContent];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setIsHaveDisableTicket:(BOOL)isHaveDisableTicket {
    _isHaveDisableTicket = isHaveDisableTicket;
    [self.disabledTicketBtn setEnabled:isHaveDisableTicket];
}

- (void)setupViewContent {
    self.disabledTicketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.disabledTicketBtn setTitle:kDisabledTicketBtnTitle forState:UIControlStateNormal];
    [self.disabledTicketBtn setTitleColor:HEX_COLOR_0x2B84C6 forState:UIControlStateNormal];
    [self.disabledTicketBtn setTitleColor:HEX_COLOR_0xCCCCCC forState:UIControlStateDisabled];
    [self.disabledTicketBtn.titleLabel setFont:SYSTEMFONT_12];
    [self.disabledTicketBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.disabledTicketBtn addTarget:self action:@selector(disabledBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.disabledTicketBtn];
    [self.disabledTicketBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX).offset(0);
        make.top.mas_equalTo(self.contentView.mas_top).offset(22);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-22);
    }];
}

- (void)disabledBtnAction {
    WSFDrinkTicketInvalidVC *ticketInvalidVC = [[WSFDrinkTicketInvalidVC alloc] init];
    [self.viewController.navigationController pushViewController:ticketInvalidVC animated:NO];
}

@end
