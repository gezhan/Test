//
//  WSFFieldTVCell.m
//  WinShare
//
//  Created by GZH on 2018/1/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldTVCell.h"
#import "NSMutableAttributedString+WSF_AdjustString.h"

@interface WSFFieldTVCell ()

@property (nonatomic, strong) UIImageView *spaceView;
@property (nonatomic, strong) UILabel *spaceNameLabel;
@property (nonatomic, strong) UILabel *spacePriceLabel;
@property (nonatomic, strong) UILabel *personNunLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *spaceAddressLabel;

@end
@implementation WSFFieldTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupContentView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setPlaygroundCellVM:(WSFFieldCellVM *)playgroundCellVM {
    _playgroundCellVM = playgroundCellVM;
    if(playgroundCellVM.path){
        NSURL *imageUrl = [NSURL URLWithString:[NSString replaceString:playgroundCellVM.path]];
        [self.spaceView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"logo_qian_bg"]];
    }
    self.spaceNameLabel.text = playgroundCellVM.roomName;
    NSString *string = [NSString stringWithFormat:@"¥%@/场 起", playgroundCellVM.price];
    self.spacePriceLabel.attributedText = [NSMutableAttributedString wsf_adjustOriginalString:string frontStringColor:HEX_COLOR_0x2B84C6 frontStringFont:17 behindString:@"起"];
    self.personNunLabel.text = playgroundCellVM.capacity;
    self.distanceLabel.text = playgroundCellVM.theMeter;
    self.spaceAddressLabel.text = playgroundCellVM.address;
}

- (void)setupContentView {
    __weak typeof(self) weakSelf = self;
    //空间背景图片
    self.spaceView = [[UIImageView alloc]init];
    self.spaceView.image = [UIImage imageNamed:@"logo_qian_bg"];
    [self.contentView addSubview:self.spaceView];
    [self.spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH/19.f*9.f)));
    }];
    //白的背景条
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.spaceView.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    //空间名称
    self.spaceNameLabel = [[UILabel alloc] init];
    self.spaceNameLabel.font = SYSTEMFONT_17;
    self.spaceNameLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.spaceNameLabel.text = @"迪凯银座";
    [whiteView addSubview:self.spaceNameLabel];
    [self.spaceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
    }];
    //空间价格
    self.spacePriceLabel = [[UILabel alloc] init];
    self.spacePriceLabel.font = SYSTEMFONT_13;
    self.spacePriceLabel.textColor = HEX_COLOR_0xCCCCCC;
    self.spacePriceLabel.attributedText = [NSMutableAttributedString wsf_adjustOriginalString:@"¥100.0/场 起" frontStringColor:HEX_COLOR_0x2B84C6 frontStringFont:17 behindString:@"起"];
    [whiteView addSubview:self.spacePriceLabel];
    [self.spacePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
    }];
    //空间容纳人数
    self.personNunLabel = [[UILabel alloc] init];
    self.personNunLabel.font = SYSTEMFONT_13;
    self.personNunLabel.textColor = HEX_COLOR_0x808080;
    self.personNunLabel.text = @"3人会议室  |";
    self.personNunLabel.textAlignment = NSTextAlignmentLeft;
    [whiteView addSubview:self.personNunLabel];
    [self.personNunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.spaceNameLabel.mas_bottom).offset(10);
    }];
    //空间距离
    self.distanceLabel = [[UILabel alloc] init];
    self.distanceLabel.font = SYSTEMFONT_13;
    self.distanceLabel.textColor = HEX_COLOR_0x808080;
    self.distanceLabel.text = @"500m  |";
    [whiteView addSubview:self.distanceLabel];
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.personNunLabel.mas_right).offset(5);
        make.top.mas_equalTo(self.personNunLabel.mas_top).offset(0);
    }];
    //空间位置
    self.spaceAddressLabel = [[UILabel alloc] init];
    self.spaceAddressLabel.font = SYSTEMFONT_13;
    self.spaceAddressLabel.textColor = HEX_COLOR_0x808080;
    self.spaceAddressLabel.text = @"江干区钱江新城银座1010室";
    [whiteView addSubview:self.spaceAddressLabel];
    [self.spaceAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.distanceLabel.mas_right).offset(5);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.personNunLabel.mas_top);
        make.bottom.mas_equalTo(whiteView.mas_bottom).offset(-20);
    }];
    
    [self.personNunLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.personNunLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.distanceLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.distanceLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.spaceAddressLabel setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
    [self.spaceAddressLabel setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
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
