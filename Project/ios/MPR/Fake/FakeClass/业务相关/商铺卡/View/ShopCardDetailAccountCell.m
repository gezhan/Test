//
//  ShopCardDetailAccountCell.m
//  WinShare
//
//  Created by QIjikj on 2017/9/15.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ShopCardDetailAccountCell.h"

@implementation ShopCardDetailAccountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupViewContent];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setupViewContent
{
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    [self.contentView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(10);
    }];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView1.mas_bottom).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"使用时长";


    
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    [self.contentView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(10);
    }];
    
    
}

@end
