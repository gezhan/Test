//
//  WSFMapBottomCell.m
//  WinShare
//
//  Created by GZH on 2017/11/17.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFMapBottomCell.h"
#import "SpaceMessageModel.h"
#import "SpacePhotoModel.h"

@interface WSFMapBottomCell ()
@property (nonatomic, strong) UIImageView *spaceImage;
@property (nonatomic, strong) UILabel *spaceNameLabel;
@property (nonatomic, strong) UILabel *paramLabel;
@end

@implementation WSFMapBottomCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.spaceImage];
        [self.contentView addSubview:self.spaceNameLabel];
        [self.contentView addSubview:self.paramLabel];
        
    }
    return self;
}

- (void)setModel:(SpaceMessageModel *)model {
    _model = model;
    if (model.photosArray.count > 0) {
        SpacePhotoModel *spaceModel = model.photosArray[0];
        [self.spaceImage sd_setImageWithURL:[NSURL URLWithString:[NSString replaceString:spaceModel.photoFileUrl Withstr1:@"200" str2:@"100" str3:@"c"]] placeholderImage:[UIImage imageNamed:@"logo_xiao"]];
    }
    self.spaceNameLabel.text = model.roomName;
    self.paramLabel.text = [NSString stringWithFormat:@"%ld人 | ¥%ld/h", (long)model.capacity, (long)model.price];
}

- (UIImageView *)spaceImage {
    if (!_spaceImage) {
        _spaceImage = [[UIImageView alloc]init];
        _spaceImage.backgroundColor = [UIColor cyanColor];
        _spaceImage.frame = CGRectMake(0, 0, 160, 100);
        _spaceImage.layer.masksToBounds = YES;
        _spaceImage.layer.cornerRadius = 5.0;
    }
    return _spaceImage;
}
- (UILabel *)spaceNameLabel {
    if (!_spaceNameLabel) {
        _spaceNameLabel = [[UILabel alloc]init];
        _spaceNameLabel.frame = CGRectMake(0, _spaceImage.bottom + 7, 160, 14);
        _spaceNameLabel.text = @"赢萊小会议室";
        _spaceNameLabel.textAlignment = NSTextAlignmentLeft;
        _spaceNameLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
        _spaceNameLabel.font = [UIFont systemFontOfSize:12];
    }
    return _spaceNameLabel;
}
- (UILabel *)paramLabel {
    if (!_paramLabel) {
        _paramLabel = [[UILabel alloc]init];
        _paramLabel.frame = CGRectMake(0, _spaceNameLabel.bottom + 7, 160, 14);
        _paramLabel.text = @"10人 | ￥50.0/h";
        _paramLabel.textAlignment = NSTextAlignmentLeft;
        _paramLabel.textColor = [UIColor colorWithHexString:@"#808080"];
        _paramLabel.font = [UIFont systemFontOfSize:12];
    }
    return _paramLabel;
}


@end
