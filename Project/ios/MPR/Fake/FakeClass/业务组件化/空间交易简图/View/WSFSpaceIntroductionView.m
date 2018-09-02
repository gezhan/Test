//
//  WSFSpaceIntroductionView.m
//  WinShare
//
//  Created by devRen on 2017/12/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFSpaceIntroductionView.h"
#import "SpacePhotoModel.h"
#import "WSFSpaceIntroductionViewModel.h"
#import "WSFSpaceIntroductionTextView.h"

@interface WSFSpaceIntroductionView ()

@property (nonatomic, strong) UIImageView *spaceImageView;
@property (nonatomic, assign) WSFSpaceIntroductionViewType viewType;
@property (nonatomic ,strong) WSFSpaceIntroductionViewModel *introductionViewModel;
@property (nonatomic ,strong) WSFSpaceIntroductionTextView *textView;

@end

@implementation WSFSpaceIntroductionView

- (instancetype)initWithIntroductionViewModel:(WSFSpaceIntroductionViewModel *)introductionViewModel spaceIntroductionViewType:(WSFSpaceIntroductionViewType)spaceIntroductionViewType {
    self = [super init];
    if (self) {
        self.backgroundColor = HEX_COLOR_0xF5F5F5;
        self.viewType = spaceIntroductionViewType;
        self.introductionViewModel = introductionViewModel;
        [self.spaceImageView sd_setImageWithURL:introductionViewModel.imageURL placeholderImage:[UIImage imageNamed:@"timg.jpeg"]];
        self.textView.hidden = NO;
        switch (self.viewType) {
            case WSFSpaceIntroductionViewType_Transverse:
                if (introductionViewModel.isHaveSetMeal) {
                    self.bottomView = self.textView;
                } else {
                    self.bottomView = self.spaceImageView;
                }
                break;
            case WSFSpaceIntroductionViewType_Longitudinal:
                self.bottomView = self.textView;
                break;
        }
    }
    return self;
}

- (UIImageView *)spaceImageView {
    if (!_spaceImageView) {
        _spaceImageView = [[UIImageView alloc] init];
        _spaceImageView.layer.masksToBounds = YES;
        _spaceImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_spaceImageView];
        [_spaceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (_viewType == WSFSpaceIntroductionViewType_Transverse) {
                make.height.width.equalTo(@75);
                make.left.equalTo(self.mas_left).mas_offset(10);
                make.top.equalTo(self.mas_top).mas_offset(10);
            } else {
                make.top.equalTo(self.mas_top).mas_offset(10);
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-10);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 130));
            }
        }];
    }
    return _spaceImageView;
}

- (WSFSpaceIntroductionTextView *)textView {
    if (!_textView) {
        _textView = [[WSFSpaceIntroductionTextView alloc] initWithIntroductionViewModel:self.introductionViewModel];
        [self addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (_viewType == WSFSpaceIntroductionViewType_Transverse) {
                make.left.equalTo(_spaceImageView.mas_right).mas_offset(10);
                make.right.equalTo(self.mas_right).mas_offset(-10);
                make.top.equalTo(self.mas_top).mas_offset(10);
                make.bottom.equalTo(_textView.bottomLabel.mas_bottom);
            } else {
                make.left.equalTo(self.mas_left).mas_offset(10);
                make.right.equalTo(self.mas_right).mas_offset(-10);
                make.top.equalTo(_spaceImageView.mas_bottom).mas_offset(10);
                make.bottom.equalTo(_textView.bottomLabel.mas_bottom).mas_offset(-10);
            }
        }];
    }
    return _textView;
}

@end
