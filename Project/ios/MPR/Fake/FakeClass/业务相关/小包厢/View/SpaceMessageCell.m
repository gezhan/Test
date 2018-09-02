//
//  SpaceMessageCell.m
//  WinShare
//
//  Created by QIjikj on 2017/5/3.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "SpaceMessageCell.h"
#import "SpaceMessageModel.h"
#import "SpacePhotoModel.h"

@interface SpaceMessageCell ()

@property (nonatomic, strong) UIImageView *spaceView;
@property (nonatomic, strong) UIView *faceCoverView;
@property (nonatomic, strong) UILabel *spaceNameLabel;
@property (nonatomic, strong) UILabel *spacePriceLabel;
@property (nonatomic, strong) UILabel *personNunLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *spaceAddressLabel;

@end

@implementation SpaceMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupContentView];
    }
    return self;
}

- (void)setSpaceModel:(SpaceMessageModel *)spaceModel
{
    _spaceModel = spaceModel;
    
    //空间背景图片
    SpacePhotoModel *photoModel = [spaceModel.photosArray firstObject];
    NSURL *imageUrl = [NSURL URLWithString:[NSString replaceString:photoModel.photoFilePath]];

    //水印
    if (spaceModel.waitOnline) {
        [self.spaceView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"logo_qian_bg"]];
        [self.contentView bringSubviewToFront:self.faceCoverView];

    }else {
        [self.spaceView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"logo_qian_bg"]];
        [self.contentView sendSubviewToBack:self.faceCoverView];
    }
    
    //空间名称
    self.spaceNameLabel.text = [NSString stringWithFormat:@"%@", spaceModel.roomName];
    //空间价格
    self.spacePriceLabel.text = [NSString stringWithFormat:@"¥%ld/h", (long)spaceModel.price];
    //空间容纳人数
    self.personNunLabel.text = [NSString stringWithFormat:@"%ld人%@  |", (long)spaceModel.capacity, spaceModel.roomType];
    //空间距离
    NSString *meterStr = [NSString distanceSizeFormatWithOriginMeter:spaceModel.theMeter];
    self.distanceLabel.text = [NSString stringWithFormat:@"%@  |", meterStr];
    //空间位置
    self.spaceAddressLabel.text = [NSString stringWithFormat:@"%@", spaceModel.address];
    
}

- (void)setupContentView
{
    __weak typeof(self) weakSelf = self;
    
    //空间背景图片
    self.spaceView = [[UIImageView alloc]init];
    self.spaceView.image = [UIImage imageNamed:@"logo_qian_bg"];
    [self.contentView addSubview:self.spaceView];
    [self.spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, (SCREEN_WIDTH/19.f*9.f)));
    }];
    //即将上线水印
    self.faceCoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH/19.f*9.f))];
    self.faceCoverView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.45];
    [self.contentView addSubview:self.faceCoverView];
    UILabel *faceLabel = [[UILabel alloc] init];
    faceLabel.text = @"即将上线";
    faceLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    faceLabel.font = [UIFont systemFontOfSize:18];
    [self.faceCoverView addSubview:faceLabel];
    [faceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.faceCoverView.mas_centerX);
        make.centerY.mas_equalTo(self.faceCoverView.mas_centerY);
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
    self.spaceNameLabel.text = @"迪卡硬座";
    [whiteView addSubview:self.spaceNameLabel];
    [self.spaceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
    }];
    //空间价格
    self.spacePriceLabel = [[UILabel alloc] init];
    self.spacePriceLabel.font = SYSTEMFONT_17;
    self.spacePriceLabel.textColor = HEX_COLOR_0x2B84C6;
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
    self.personNunLabel.text = @"10人会议室  |";
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
//
//    return sizeUnitString;
//}

@end
