//
//  GoodsItem.m
//  WinShare
//
//  Created by QIjikj on 2017/5/4.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "GoodsItem.h"
#import "SpaceGoodsModel.h"

@interface GoodsItem ()
@property (nonatomic, strong) UIImageView *goodsImage;
@property (nonatomic, strong) UILabel *goodsName;
@property (nonatomic, strong) NSArray *diviceImageArray;

@property (nonatomic, strong) UIImage *currentImage;
@end

@implementation GoodsItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.goodsImage];
        [self.contentView addSubview:self.goodsName];
    }
    return self;
}

- (void)setSpaceGoodsMessage:(SpaceGoodsModel *)spaceGoodsMessage
{
    _spaceGoodsMessage = spaceGoodsMessage;
    
    self.goodsName.text = [NSString stringWithFormat:@"%@",spaceGoodsMessage.diviceType];
    
    if (self.diviceImageArray.count >= spaceGoodsMessage.diviceTypeId) {
        self.currentImage = [UIImage imageNamed:[self.diviceImageArray objectAtIndex: (spaceGoodsMessage.diviceTypeId - 1)]];
        self.goodsImage.image = self.currentImage;
    }
    
    [self updateConstraintsIfNeeded];
    
}

- (NSArray *)diviceImageArray
{
    if (!_diviceImageArray) {
        _diviceImageArray = @[@"zhuozi", @"yizi", @"touyingyi", @"bijibendiannao", @"zhuji", @"diannao", @"tv", @"baiban", @"yinxiang", @"wifi", @"kongtiao", @"maikefeng"];
    }
    return _diviceImageArray;
}

- (void)updateConstraints
{
    [self.goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(self.currentImage.size.width, self.currentImage.size.height));
    }];
    
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsImage.mas_right).offset(5);
        make.centerY.mas_equalTo(self.contentView.mas_centerY).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
    [super updateConstraints];
}

- (UILabel *)goodsName
{
    if (!_goodsName) {
        _goodsName = [[UILabel alloc] init];
        _goodsName.font = SYSTEMFONT_14;
        _goodsName.textColor = [UIColor colorWithHexString:@"1a1a1a"];
    }
    return _goodsName;
}

- (UIImageView *)goodsImage
{
    if (!_goodsImage) {
        _goodsImage = [[UIImageView alloc] init];
    }
    return _goodsImage;
}

@end








