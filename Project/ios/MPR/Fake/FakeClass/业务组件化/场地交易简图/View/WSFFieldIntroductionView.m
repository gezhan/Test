//
//  WSFFieldIntroductionView.m
//  WinShare
//
//  Created by QIjikj on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldIntroductionView.h"
#import "WSFFieldIntroductionVM.h"
#import "WSFFieldIntroductionTextView.h"

@interface WSFFieldIntroductionView ()
@property (nonatomic, strong) UIImageView *playgroundImageView;
@property (nonatomic, strong) WSFFieldIntroductionTextView *textView;
@property (nonatomic, assign) WSFFieldIntroductionViewType viewType;
@property (nonatomic, strong) WSFFieldIntroductionVM *playgroundIntroductionVM;
@end

@implementation WSFFieldIntroductionView

- (instancetype)initWithPlaygroundIntroductionVM:(WSFFieldIntroductionVM *)playgroundIntroductionVM playgroundIntroductionViewType:(WSFFieldIntroductionViewType)playgroundIntroductionViewType {
    if (self = [super init]) {
        self.backgroundColor = HEX_COLOR_0xF5F5F5;
        self.viewType = playgroundIntroductionViewType;
        self.playgroundIntroductionVM = playgroundIntroductionVM;
        [self.playgroundImageView sd_setImageWithURL:playgroundIntroductionVM.imageURL placeholderImage:[UIImage imageNamed:@"timg.jpeg"]];
        self.textView.hidden = NO;
    }
    return self;
}

- (UIImageView *)playgroundImageView {
    if (!_playgroundImageView) {
        _playgroundImageView = [[UIImageView alloc] init];
        _playgroundImageView.layer.masksToBounds = YES;
        _playgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_playgroundImageView];
        [_playgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (_viewType == WSFFieldIntroductionViewType_Transverse) {
                make.height.width.equalTo(@75);
                make.left.equalTo(self.mas_left).mas_offset(10);
                make.top.equalTo(self.mas_top).mas_offset(10);
                make.bottom.equalTo(self.mas_bottom).offset(-10);
            } else {
                make.top.equalTo(self.mas_top).mas_offset(10);
                make.left.mas_equalTo(10);
                make.right.mas_equalTo(-10);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 130));
            }
        }];
    }
    return _playgroundImageView;
}

- (WSFFieldIntroductionTextView *)textView {
    if (!_textView) {
        _textView = [[WSFFieldIntroductionTextView alloc] initWithPlaygroundIntroductionVM:self.playgroundIntroductionVM];
        [self addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (_viewType == WSFFieldIntroductionViewType_Transverse) {
                make.left.equalTo(_playgroundImageView.mas_right).mas_offset(10);
                make.right.equalTo(self.mas_right).mas_offset(-10);
                make.top.equalTo(self.mas_top).mas_offset(10);
            } else {
                make.left.equalTo(self.mas_left).mas_offset(10);
                make.right.equalTo(self.mas_right).mas_offset(-10);
                make.top.equalTo(_playgroundImageView.mas_bottom).mas_offset(10);
                make.bottom.equalTo(self.mas_bottom).mas_offset(-10);
            }
        }];
    }
    return _textView;
}

@end
