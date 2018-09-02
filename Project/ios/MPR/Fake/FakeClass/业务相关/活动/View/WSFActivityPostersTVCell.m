//
//  WSFActivityPostersTVCell.m
//  WinShare
//
//  Created by GZH on 2018/2/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityPostersTVCell.h"

@implementation WSFActivityPostersTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupContentView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupContentView {
    self.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(15);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.left.mas_equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-15);
    }];
    
    _photo = [UIImageView Z_createImageViewWithFrame:CGRectZero image:@"" layerMask:NO cornerRadius:0];
    [backView addSubview:_photo];
    [_photo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(backView);
        make.height.mas_equalTo(120);
    }];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.backgroundColor = [UIColor greenColor];
    [backView addSubview:_deleteBtn];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(backView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
