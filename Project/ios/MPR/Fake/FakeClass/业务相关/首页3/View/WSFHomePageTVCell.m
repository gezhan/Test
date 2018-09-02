//
//  WSFHomePageTVCell.m
//  WinShare
//
//  Created by GZH on 2018/1/11.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFHomePageTVCell.h"
#import "NSMutableAttributedString+WSF_AdjustString.h"
@interface WSFHomePageTVCell ()

@property (nonatomic, strong) UIImageView *spaceView;
@property (nonatomic, strong) UIView *faceCoverView;
@property (nonatomic, strong) UILabel *spaceNameLabel;
@property (nonatomic, strong) UILabel *spacePriceLabel;
@property (nonatomic, strong) UILabel *personNunLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *spaceAddressLabel;

@end
@implementation WSFHomePageTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupContentView];
    }
    return self;
}

- (void)setHomePageCellVM:(WSFHomePageCellVM *)homePageCellVM {
    _homePageCellVM = homePageCellVM;
    if(homePageCellVM.path){
        NSURL *imageUrl = [NSURL URLWithString:[NSString replaceString:homePageCellVM.path]];
        [self.spaceView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"logo_qian_bg"]];
    }
    self.spaceNameLabel.text = homePageCellVM.roomName;
    if (homePageCellVM.jumpTypeKey == 1) {
        self.spacePriceLabel.font = SYSTEMFONT_17;
        self.spacePriceLabel.textColor = HEX_COLOR_0x2B84C6;
        self.spacePriceLabel.text = [NSString stringWithFormat:@"¥%@/h", homePageCellVM.price];
    }else { 
        self.spacePriceLabel.font = SYSTEMFONT_13;
        self.spacePriceLabel.textColor = HEX_COLOR_0xCCCCCC;
        NSString *string = [NSString stringWithFormat:@"¥%@/场 起", homePageCellVM.price];
        self.spacePriceLabel.attributedText = [NSMutableAttributedString wsf_adjustOriginalString:string frontStringColor:HEX_COLOR_0x2B84C6 frontStringFont:17 behindString:@"起"];
    }
    self.personNunLabel.text = homePageCellVM.capacity;
    self.distanceLabel.text = homePageCellVM.theMeter;
    self.spaceAddressLabel.text = homePageCellVM.address;
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
//    //即将上线水印
//    self.faceCoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT - 64)/2.5 - 50)];
//    self.faceCoverView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.45];
//    [self.contentView addSubview:self.faceCoverView];
//    UILabel *faceLabel = [[UILabel alloc] init];
//    faceLabel.text = @"即将上线";
//    faceLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
//    faceLabel.font = [UIFont systemFontOfSize:18];
//    [self.faceCoverView addSubview:faceLabel];
//    [faceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.faceCoverView.mas_centerX);
//        make.centerY.mas_equalTo(self.faceCoverView.mas_centerY);
//    }];
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
    self.spacePriceLabel.text = @"¥100.0/h";
    [whiteView addSubview:self.spacePriceLabel];
    [self.spacePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
    }];
    //空间容纳人数
    self.personNunLabel = [[UILabel alloc] init];
    self.personNunLabel.font = SYSTEMFONT_13;
    self.personNunLabel.textColor = HEX_COLOR_0x808080;
    self.personNunLabel.text = @"10人会议室";
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
    self.distanceLabel.text = @"500m";
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

//// 获取距离大小
//- (NSString *)distanceSizeFormatWithOriginMeter:(NSInteger)originMeter
//{
//    NSString *sizeUnitString;
//    float size = originMeter;
//    if(size < 1000){
//        sizeUnitString = [NSString stringWithFormat:@"%.1fm", size];
//
//    }else{
//        size /= 1000;
//        sizeUnitString = [NSString stringWithFormat:@"%.1fkm", size];
//    }
//    return sizeUnitString;
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
