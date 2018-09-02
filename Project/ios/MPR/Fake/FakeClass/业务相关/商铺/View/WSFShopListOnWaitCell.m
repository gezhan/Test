//
//  WSFShopListOnWaitCell.m
//  WinShare
//
//  Created by QIjikj on 2017/10/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFShopListOnWaitCell.h"
#import "ShopListModel.h"
#import "SpacePhotoModel.h"

#define textGap ((75-((HeightForFontSize(13.f)+1.5)*2+HeightForFontSize(14.f)+1.5))/4.0)

@interface WSFShopListOnWaitCell ()
@property (nonatomic, strong) UIImageView *spaceImage;//空间图片
@property (nonatomic, strong) UIView *faceCoverView;//即将上线水印
@property (nonatomic, strong) UILabel *spaceNameLabel;//空间的名称
@property (nonatomic, strong) UILabel *spacePriceLabel;//空间的价格
@property (nonatomic, strong) UILabel *spaceTypeAndSizeLabel;//空间的类型和容纳人数
@property (nonatomic, strong) UILabel *spaceAddressLabel;//空间的地址
@property (nonatomic, strong) UILabel *spaceEarnedLabel;//空间已经收入
@property (nonatomic, strong) UILabel *spaceEarningLabel;//空间待收入（定金）
@end

@implementation WSFShopListOnWaitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupContentView];
        
    }
    return self;
}

- (void)setShopListModel:(ShopListModel *)shopListModel
{
    _shopListModel = shopListModel;
    
    //空间图片
    NSURL *imageUrl = [NSURL URLWithString:[NSString replaceString:shopListModel.spacePhotoModel.photoFilePath]];
    [self.spaceImage sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"logo_qian_bg"]];
    //水印
    if (shopListModel.waitOnline) {
        [self.contentView bringSubviewToFront:self.faceCoverView];
    }else {
        [self.contentView sendSubviewToBack:self.faceCoverView];
    }
    //空间名称
    self.spaceNameLabel.text = shopListModel.roomName;
    //空间类型与容纳人数
    self.spaceTypeAndSizeLabel.text = [NSString stringWithFormat:@"%@  |  %ld人", shopListModel.roomType, shopListModel.capacity];
    //空间价格
    if (shopListModel.shopListModelType == ShopListModelType_bigroom) {
        self.spacePriceLabel.text = [NSString stringWithFormat:@"¥%ld/场 起", shopListModel.price];
    }else {
        self.spacePriceLabel.text = [NSString stringWithFormat:@"¥%ld/h", shopListModel.price];
    }
    //空间位置
    self.spaceAddressLabel.text = shopListModel.address;
    //空间收入
    self.spaceEarnedLabel.text = [NSString stringWithFormat:@"已收入:%0.2f元", shopListModel.incomeAmount];
    //定金收入
    self.spaceEarningLabel.text = [NSString stringWithFormat:@"定金收入:%0.2f元", shopListModel.expectedAmount];
}

- (void)setupContentView
{
    //空间的图片
    self.spaceImage = [[UIImageView alloc] init];
    self.spaceImage.image = [UIImage imageNamed:@"timg.jpeg"];
    [self.contentView addSubview:self.spaceImage];
    [self.spaceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75, 75));
        make.top.mas_equalTo(self.contentView).offset(12);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
    }];
    
    //即将上线水印
    self.faceCoverView = [[UIView alloc] init];
    self.faceCoverView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.6];
    [self.contentView addSubview:self.faceCoverView];
    [self.faceCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.spaceImage);
    }];
    UILabel *faceLabel = [[UILabel alloc] init];
    faceLabel.text = @"即将上线";
    faceLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    faceLabel.font = [UIFont systemFontOfSize:14];
    [self.faceCoverView addSubview:faceLabel];
    [faceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.faceCoverView.mas_centerX);
        make.centerY.mas_equalTo(self.faceCoverView.mas_centerY);
    }];
    
    //空间的名称
    self.spaceNameLabel = [[UILabel alloc] init];
    self.spaceNameLabel.font = SYSTEMFONT_14;
    self.spaceNameLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.spaceNameLabel.text = @"1号楼101会议室";
    [self.contentView addSubview:self.spaceNameLabel];
    [self.spaceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.spaceImage.mas_right).offset(10);
        make.top.mas_equalTo(self.spaceImage).offset(textGap);
        make.width.mas_equalTo(SCREEN_WIDTH - 10 - 75 - 10 - 15 - 50 - 10);
    }];
    
    //空间的价格
    self.spacePriceLabel = [[UILabel alloc] init];
    self.spacePriceLabel.font = SYSTEMFONT_13;
    self.spacePriceLabel.textColor = HEX_COLOR_0x808080;
    self.spacePriceLabel.text = @"¥100/h";
    self.spacePriceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.spacePriceLabel];
    [self.spacePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.spaceImage).offset(textGap);
        make.width.mas_equalTo(50);
    }];
    
    //空间的类型和容纳人数
    self.spaceTypeAndSizeLabel = [[UILabel alloc] init];
    self.spaceTypeAndSizeLabel.font = SYSTEMFONT_13;
    self.spaceTypeAndSizeLabel.textColor = HEX_COLOR_0x808080;
    self.spaceTypeAndSizeLabel.text = @"10人会议室";
    [self.contentView addSubview:self.spaceTypeAndSizeLabel];
    [self.spaceTypeAndSizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.spaceImage.mas_right).offset(10);
        make.top.mas_equalTo(self.spaceNameLabel.mas_bottom).offset(textGap);
    }];
    
    //空间的地址
    self.spaceAddressLabel = [[UILabel alloc] init];
    self.spaceAddressLabel.font = SYSTEMFONT_13;
    self.spaceAddressLabel.textColor = HEX_COLOR_0x808080;
    self.spaceAddressLabel.text = @"江干区钱江新城迪凯银座13楼右拐";
    [self.contentView addSubview:self.spaceAddressLabel];
    [self.spaceAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.spaceImage.mas_right).offset(10);
        make.top.mas_equalTo(self.spaceTypeAndSizeLabel.mas_bottom).offset(textGap);
    }];
    
    //空间已经收入
    self.spaceEarnedLabel = [[UILabel alloc] init];
    self.spaceEarnedLabel.font = SYSTEMFONT_14;
    self.spaceEarnedLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.spaceEarnedLabel.text = @"已收入:10000元";
    [self.contentView addSubview:self.spaceEarnedLabel];
    [self.spaceEarnedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.spaceImage.mas_bottom).offset(12);
    }];
    
    //空间待收入（定金）
    self.spaceEarningLabel = [[UILabel alloc] init];
    self.spaceEarningLabel.font = SYSTEMFONT_14;
    self.spaceEarningLabel.textColor = HEX_COLOR_0x1A1A1A;
    self.spaceEarningLabel.text = @"定金收入:2000元";
    [self.contentView addSubview:self.spaceEarningLabel];
    [self.spaceEarningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.mas_equalTo(self.spaceImage.mas_bottom).offset(12);
    }];
    
    //灰条
    UIView *grayView = [[UIView alloc] init];
    grayView.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5" alpha:1.0];
    [self.contentView addSubview:grayView];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.spaceEarnedLabel.mas_bottom).offset(12);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 15));
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
}

@end
