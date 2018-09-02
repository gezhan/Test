//
//  TicketLookDisableCell.m
//  WinShare
//
//  Created by GZH on 2017/8/30.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "TicketLookDisableCell.h"
#import "TicketInvalidViewController.h"

@interface TicketLookDisableCell ()

@property (nonatomic, strong) UIButton *disabledTicketBtn;

@end

@implementation TicketLookDisableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupViewContent];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setIsHaveDisableTicket:(BOOL)isHaveDisableTicket
{
    _isHaveDisableTicket = isHaveDisableTicket;
    
    [self.disabledTicketBtn setEnabled:isHaveDisableTicket];
}

- (void)setupViewContent
{
    self.disabledTicketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.disabledTicketBtn setTitle:@"查看失效券>>" forState:UIControlStateNormal];
    [self.disabledTicketBtn setTitleColor:[UIColor colorWithHexString:@"#2b84c6"] forState:UIControlStateNormal];
    [self.disabledTicketBtn setTitleColor:[UIColor colorWithHexString:@"#cccccc"] forState:UIControlStateDisabled];
    [self.disabledTicketBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.disabledTicketBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.disabledTicketBtn addTarget:self action:@selector(disabledBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.disabledTicketBtn];
    [self.disabledTicketBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX).offset(0);
        make.top.mas_equalTo(self.contentView.mas_top).offset(22);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-22);
    }];
}

- (void)disabledBtnAction
{
    TicketInvalidViewController *ticketInvalidVC = [[TicketInvalidViewController alloc] init];
    [self.viewController.navigationController pushViewController:ticketInvalidVC animated:NO];
}

@end
