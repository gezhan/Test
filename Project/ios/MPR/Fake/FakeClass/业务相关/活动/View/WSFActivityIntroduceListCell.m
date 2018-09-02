//
//  WSFActivityIntroduceListCell.m
//  WinShare
//
//  Created by QIjikj on 2018/2/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityIntroduceListCell.h"
#import "WSFActivityIntroduceListTVM.h"

@interface WSFActivityIntroduceListCell ()


@end

@implementation WSFActivityIntroduceListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setActivityIntroduceListTCellVM:(WSFActivityIntroduceListTCellVM *)activityIntroduceListTCellVM {
    _activityIntroduceListTCellVM = activityIntroduceListTCellVM;
    
    [self setupContentView];
}

#pragma mark - 基本界面搭建
- (void)setupContentView {
    
    //1.1
    UILabel *titleTipLabel = [[UILabel alloc] init];
    titleTipLabel.text = @"标题";
    titleTipLabel.font = SYSTEMFONT_14;
    titleTipLabel.textColor = HEX_COLOR_0x1A1A1A;
    [self.contentView addSubview:titleTipLabel];
    [titleTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
    }];
    
    //1.2
    UITextField *titleTextField = [[UITextField alloc] init];
    titleTextField.text = self.activityIntroduceListTCellVM.introduceTitle;
    titleTextField.font = SYSTEMFONT_14;
    titleTextField.textColor = HEX_COLOR_0x1A1A1A;
    [self.contentView addSubview:titleTextField];
    [titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleTipLabel.mas_left).offset(10);
        make.top.mas_equalTo(titleTipLabel.mas_top).offset(0);
    }];
    
    //2
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = HEX_COLOR_0xF5F5F5;
    [self.contentView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleTipLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
    }];
    
    //3.1
    UILabel *contentTipLabel = [[UILabel alloc] init];
    contentTipLabel.text = @"内容";
    contentTipLabel.font = SYSTEMFONT_14;
    contentTipLabel.textColor = HEX_COLOR_0x1A1A1A;
    [self.contentView addSubview:contentTipLabel];
    [contentTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(lineView1.mas_bottom).offset(10);
    }];
    
    //3.2
    UITextField *contentTextField = [[UITextField alloc] init];
    contentTextField.text = self.activityIntroduceListTCellVM.introduceContent;;
    contentTextField.font = SYSTEMFONT_14;
    contentTextField.textColor = HEX_COLOR_0x1A1A1A;
    [self.contentView addSubview:contentTextField];
    [contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentTipLabel.mas_left).offset(10);
        make.top.mas_equalTo(contentTipLabel.mas_top).offset(0);
    }];
    
    //4
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = HEX_COLOR_0xF5F5F5;
    [self.contentView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentTextField.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 1));
    }];
    
    //5.2
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"tuoyuan_black"] forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView2.mas_bottom).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    //5.1
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setImage:[UIImage imageNamed:@"tuoyuan_black"] forState:UIControlStateNormal];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView2.mas_bottom).offset(10);
        make.right.mas_equalTo(deleteBtn.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

- (void)deleteBtnAction {
    
}

- (void)editBtnAction {
    
}

@end
