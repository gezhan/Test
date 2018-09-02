//
//  ShopCardCell.m
//  WinShare
//
//  Created by QIjikj on 2017/8/23.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopCardCell.h"
#import "ShopCardRecordVC.h"
#import "ShopCardListModel.h"

@interface ShopCardCell ()

@end

@implementation ShopCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setShopCardListModel:(ShopCardListModel *)shopCardListModel
{
    _shopCardListModel = shopCardListModel;
    [self setupContentView];
}

- (void)setupContentView
{
    //背景图片
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.image = [UIImage imageNamed:@"shangpucha_white"];
    bgImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(15);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
    }];
    //会议室名称
    UILabel *spaceNameLabel = [[UILabel alloc] init];
    spaceNameLabel.text = self.shopCardListModel.roomName;
    spaceNameLabel.font = [UIFont systemFontOfSize:14];
    spaceNameLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
    [bgImageView addSubview:spaceNameLabel];
    [spaceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgImageView.mas_top).offset(10);
        make.left.mas_equalTo(bgImageView.left).offset(10);
    }];
    //使用说明
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.text = [@"每月可用" stringByAppendingString:self.shopCardListModel.roomCardDuration];
    messageLabel.font = [UIFont systemFontOfSize:11];
    [messageLabel setTextColor:[UIColor colorWithHexString:@"#2b84c6"]];
    [bgImageView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgImageView.mas_top).offset(10);
        make.right.mas_equalTo(bgImageView.mas_right).offset(-10);
    }];
    UIImageView *messageImage = [[UIImageView alloc] init];
    messageImage.image = [[UIImage imageNamed:@"anniu_blue_xian"] resizingImageState];
    [bgImageView addSubview:messageImage];
    [messageImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(messageLabel.mas_centerY);
        make.centerX.mas_equalTo(messageLabel.mas_centerX);
        make.width.mas_equalTo(messageLabel.mas_width).offset(12);
    }];
    //本月剩余
    UILabel *residueLabel = [[UILabel alloc] init];
    residueLabel.text = @"本月剩余";
    residueLabel.font = [UIFont systemFontOfSize:11];
    [residueLabel setTextColor:[UIColor colorWithHexString:@"#1a1a1a"]];
    [bgImageView addSubview:residueLabel];
    [residueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgImageView.mas_top).offset(49);
        make.centerX.mas_equalTo(bgImageView.mas_centerX);
    }];
    //剩余时长
    UILabel *residueNumLabel = [[UILabel alloc] init];
    residueNumLabel.text = self.shopCardListModel.roomCardLeaveMinutes;
    residueNumLabel.font = [UIFont systemFontOfSize:18];
    [residueNumLabel setTextColor:[UIColor colorWithHexString:@"#2b84c6"]];
    [bgImageView addSubview:residueNumLabel];
    [residueNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(residueLabel.mas_bottom).offset(10);
        make.centerX.mas_equalTo(bgImageView.mas_centerX);
    }];
    //截止日期
    UILabel *deadlineLabel = [[UILabel alloc] init];
    deadlineLabel.text = [@"截止" stringByAppendingString:[NSString dateStrWithNewFormatter:@"yyyy.MM.dd" oldStr:self.shopCardListModel.endContractTime oldFormatter:@"yyyy-MM-dd HH:mm:ss"]];
    deadlineLabel.font = [UIFont systemFontOfSize:11];
    [deadlineLabel setTextColor:[UIColor colorWithHexString:@"#1a1a1a"]];
    [bgImageView addSubview:deadlineLabel];
    [deadlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bgImageView.mas_bottom).offset(-10);
        make.left.mas_equalTo(bgImageView.mas_left).offset(10);
    }];
    //明细按钮
    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [detailBtn setTitle:@"查看使用明细>>" forState:UIControlStateNormal];
    [detailBtn setTitleColor:[UIColor colorWithHexString:@"#1a1a1a"] forState:UIControlStateNormal];
    [detailBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [detailBtn addTarget:self action:@selector(detailBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:detailBtn];
    [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(deadlineLabel.mas_centerY);
        make.right.mas_equalTo(bgImageView.mas_right).offset(-10);
    }];
}

- (void)detailBtnAction
{
    ShopCardRecordVC *shopCardRecordVC = [[ShopCardRecordVC alloc] init];
    shopCardRecordVC.roomId = self.shopCardListModel.roomId;
    [self.viewController.navigationController pushViewController:shopCardRecordVC animated:NO];
}

@end
