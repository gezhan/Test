//
//  SearchSpaceCell.m
//  WinShare
//
//  Created by GZH on 2017/5/11.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "SearchSpaceCell.h"

@implementation SearchSpaceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.locationImage];
        [self.contentView addSubview:self.locationLabel];
        
        
        self.layer.borderWidth = 0.3;
        self.layer.borderColor = [UIColor colorWithHexString:@"#cccccc"].CGColor;
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


- (void)setPositionModel:(PositionModel *)positionModel {
    _positionModel = positionModel;
    self.locationLabel.text = [NSString stringWithFormat:@"%@(%@)", positionModel.name, positionModel.address];

}

- (UIImageView *)locationImage {
    if (_locationImage == nil) {
        self.locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 13, 15)];
        _locationImage.image = [UIImage imageNamed:@"dibiao_big"];
    }
    return _locationImage;
}

- (UILabel *)locationLabel {
    if (_locationLabel == nil) {
        self.locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(_locationImage.right + 10, 0, SCREEN_WIDTH - _locationImage.right - 10 - 30, 45)];
        _locationLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
        _locationLabel.font = [UIFont systemFontOfSize:14];
        _locationLabel.text = @"中国国家博物馆(杭州市江干区)";
    }
    return _locationLabel;
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
