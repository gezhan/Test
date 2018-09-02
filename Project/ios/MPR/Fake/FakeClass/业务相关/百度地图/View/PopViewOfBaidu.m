//
//  PopViewOfBaidu.m
//  WinShare
//
//  Created by GZH on 2017/5/14.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "PopViewOfBaidu.h"
#import "SpaceMessageModel.h"
#import "SpacePhotoModel.h"

@interface PopViewOfBaidu ()
@property (nonatomic, strong) UIView *faceCoverView;
@property (nonatomic, strong) UILabel *faceLabel;
/**  空间名称 */
@property (nonatomic, strong) UILabel *roomNameLabel;
@end

@implementation PopViewOfBaidu

- (void)setModel:(SpaceMessageModel *)model {
    _model = model;
    
    if (model.photosArray.count > 0) {
        
        SpacePhotoModel *spaceModel = model.photosArray[0];
        [self.spaceImage sd_setImageWithURL:[NSURL URLWithString:[NSString replaceString:spaceModel.photoFileUrl Withstr1:@"200" str2:@"100" str3:@"c"]] placeholderImage:[UIImage imageNamed:@"logo_xiao"]];
    }
    self.roomNameLabel.text = model.roomName;
    self.positionLabel.text = model.roomType;
    self.peopleLabel.text = [NSString stringWithFormat:@"%ld人", (long)model.capacity];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%ld/h", (long)model.price];
    
    
    if (model.waitOnline) {
        
        //即将上线
        _faceCoverView.hidden = NO;
        _faceLabel.hidden = NO;
        
    }else {

        _faceCoverView.hidden = YES;
        _faceLabel.hidden = YES;
    }
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
   //     self.backgroundColor = [UIColor cyanColor];
        UIImageView *backImage = [[UIImageView alloc]initWithFrame:self.frame];
        backImage.image = [UIImage imageNamed:@"juxing_white"];
        [self addSubview:backImage];

        _spaceImage = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, self.frame.size.width - 6, 59)];
        _spaceImage.image = [UIImage imageNamed:@"logo_xiao"];
        _spaceImage.contentMode = UIViewContentModeScaleAspectFit;
        _spaceImage.layer.cornerRadius = 6;
        _spaceImage.layer.masksToBounds = YES;
        _spaceImage.backgroundColor = [UIColor clearColor];
        [self addSubview:_spaceImage];
        
        _faceCoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 6, 59)];
        _faceCoverView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.45];
        [_spaceImage addSubview:_faceCoverView];
        
        _faceLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 3, self.frame.size.width - 6, 59)];
        _faceLabel.text = @"即将上线";
        _faceLabel.textAlignment = NSTextAlignmentCenter;
        _faceLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        _faceLabel.font = [UIFont systemFontOfSize:16];
        [_spaceImage addSubview:_faceLabel];

        
        _roomNameLabel = [UILabel Z_createLabelWithFrame:CGRectMake(8 , _spaceImage.bottom + 5, self.width - 16, 14) title:@"赢萊小会议室" textFont:10 colorStr:@"#1a1a1a" aligment:NSTextAlignmentLeft];
//        _roomNameLabel.backgroundColor = [UIColor cyanColor];
        [self addSubview:_roomNameLabel];
        
        _positionLabel = [UILabel Z_createLabelWithFrame:CGRectMake(8 , _roomNameLabel.bottom + 5, 31, 14) title:@"咖啡馆" textFont:10 colorStr:@"#1a1a1a" aligment:NSTextAlignmentLeft];
//        _positionLabel.backgroundColor = [UIColor greenColor];
        [self addSubview:_positionLabel];
        
        
        UIView *lineView = [UIView Z_createViewWithFrame:CGRectMake(_positionLabel.right + 3, _positionLabel.top, 0.5, 14) colorStr:@"#cccccc"];
        [self addSubview:lineView];
        
        
        _peopleLabel = [UILabel Z_createLabelWithFrame:CGRectMake(lineView.right, _positionLabel.top, 31, 14) title:@"20人" textFont:10 colorStr:@"#1a1a1a" aligment:NSTextAlignmentCenter];
//        _peopleLabel.backgroundColor = [UIColor greenColor];
        [self addSubview:_peopleLabel];
        
        
        UIView *lineView2 = [UIView Z_createViewWithFrame:CGRectMake(_peopleLabel.right, _positionLabel.top, 0.5, 14) colorStr:@"#cccccc"];
        [self addSubview:lineView2];
        
        
        _priceLabel = [UILabel Z_createLabelWithFrame:CGRectMake(lineView2.right + 3, _peopleLabel.top, self.width - lineView2.right - 8, 14) title:@"￥100.0/h" textFont:10 colorStr:@"#1a1a1a" aligment:NSTextAlignmentCenter];
//        _priceLabel.backgroundColor = [UIColor cyanColor];
        [self addSubview:_priceLabel];
        

    }
    return self;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
