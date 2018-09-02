//
//  WSFActivityListTVCell.m
//  WinShare
//
//  Created by GZH on 2018/2/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityListTVCell.h"
//#import "WSFRPAppEventSearchResModel.h"

@interface WSFActivityListTVCell ()
@property (nonatomic, strong) UIImageView *spaceView; //空间图片
@property (nonatomic, strong) UILabel *spaceName;   //空间名称
@property (nonatomic, strong) UILabel *timeAddressLabel;  //时间地点的View
@property (nonatomic, strong) UILabel *spacePriceLabel;   //价位
@property (nonatomic, strong) UILabel *remindLabel;  //备注
@end

@implementation WSFActivityListTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupContentView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setCellVM:(WSFActivityListCellVM *)cellVM {
    _cellVM = cellVM;
    if(cellVM.picture){
        NSURL *imageUrl = [NSURL URLWithString:cellVM.picture];
        [self.spaceView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"logo_qian_bg"]];
    }
    _spaceName.text = cellVM.name;
    _spacePriceLabel.text = cellVM.enrolmentFee;
    _remindLabel.text = cellVM.man;
    _timeAddressLabel.attributedText = cellVM.timeAndAddress;
}

- (void)setupContentView {
    self.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    //与cell相同大小的底层View
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(15);
        make.left.bottom.right.mas_equalTo(self.contentView);
    }];
    
    //空间图片
    self.spaceView = [[UIImageView alloc]init];
    self.spaceView.image = [UIImage imageNamed:@"logo_qian_bg"];
    [backView addSubview:self.spaceView];
    [self.spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView).offset(15);
        make.left.mas_equalTo(backView).offset(10);
        make.size.mas_equalTo(CGSizeMake(124, 107));
        make.bottom.mas_equalTo(backView).offset(-15);
    }];
    
    //空间名称
    _spaceName = [UILabel Z_createLabelWithFrame:CGRectZero title:@"1df651dgwegviosdfiiijehh" textFont:16 colorStr:@"#1a1a1a" aligment:NSTextAlignmentLeft];
    _spaceName.numberOfLines = 2;
    [backView addSubview:_spaceName];
    [_spaceName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_spaceView.mas_right).offset(10);
        make.right.equalTo(backView).offset(-10);
        make.top.equalTo(_spaceView.mas_top);
    }];
    
    //时间地点的label
    _timeAddressLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:@" 今天 16:00-19:00 \n 解放东路迪凯银座1301" textFont:12 colorStr:@"#808080" aligment:NSTextAlignmentLeft];
    _timeAddressLabel.numberOfLines = 2;
    [backView addSubview:_timeAddressLabel];
    [_timeAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_spaceName.mas_left);
        make.right.equalTo(_spaceName.mas_right);
        make.top.equalTo(_spaceName.mas_bottom).offset(12);
    }];
    
    //价位的label
    _spacePriceLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:@"免费" textFont:12 colorStr:@"#2b84c6" aligment:NSTextAlignmentLeft];
    [backView addSubview:_spacePriceLabel];
    [_spacePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_spaceName.mas_left);
        make.bottom.equalTo(_spaceView.mas_bottom);
    }];
    
    //备注的label
    _remindLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:@"报名已截止" textFont:12 colorStr:@"#808080" aligment:NSTextAlignmentRight];
    _remindLabel.textColor = [UIColor blackColor];
    [backView addSubview:_remindLabel];
    [_remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_right).offset(-10);
        make.bottom.equalTo(_spaceView.mas_bottom);
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
