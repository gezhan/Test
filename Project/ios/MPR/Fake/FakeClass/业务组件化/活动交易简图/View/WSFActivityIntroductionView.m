//
//  WSFActivityIntroductionView.m
//  WinShare
//
//  Created by ZWL on 2018/3/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityIntroductionView.h"
#import "WSFActivityIntroductionTextView.h"

@interface WSFActivityIntroductionView ()

@property (nonatomic, strong) UIImageView *activityImageView;
@property (nonatomic, strong) WSFActivityIntroductionTextView *textView;
@property (nonatomic, assign) WSFActivityIntroductionViewType viewType;
@property (nonatomic, strong) WSFActivityDetailIntroductionVM *activityIntroductionVM;

@end

@implementation WSFActivityIntroductionView

- (instancetype)initWithPlaygroundIntroductionVM:(WSFActivityDetailIntroductionVM *)activityIntroductionVM playgroundIntroductionViewType:(WSFActivityIntroductionViewType)activityIntroductionViewType {
    if (self = [super init]) {
        self.backgroundColor = HEX_COLOR_0xF5F5F5;
        self.viewType = activityIntroductionViewType;
        self.activityIntroductionVM = activityIntroductionVM;
        [self.activityImageView sd_setImageWithURL:activityIntroductionVM.imageURL placeholderImage:[UIImage imageNamed:@"timg.jpeg"]];
        self.textView.hidden = NO;
    }
    return self;
}

- (UIImageView *)activityImageView {
    if (!_activityImageView) {
        _activityImageView = [[UIImageView alloc] init];
        _activityImageView.layer.masksToBounds = YES;
        _activityImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_activityImageView];
        [_activityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (_viewType == WSFActivityIntroductionViewType_Transverse) {
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
    return _activityImageView;
}

- (WSFActivityIntroductionTextView *)textView {
    if (!_textView) {
        _textView = [[WSFActivityIntroductionTextView alloc] initWithActivityIntroductionVM:self.activityIntroductionVM];
        [self addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (_viewType == WSFActivityIntroductionViewType_Transverse) {
                make.left.equalTo(_activityImageView.mas_right).mas_offset(10);
                make.right.equalTo(self.mas_right).mas_offset(-10);
                make.top.equalTo(self.mas_top).mas_offset(10);
            } else {
                make.left.equalTo(self.mas_left).mas_offset(10);
                make.right.equalTo(self.mas_right).mas_offset(-10);
                make.top.equalTo(_activityImageView.mas_bottom).mas_offset(10);
                make.bottom.equalTo(self.mas_bottom).mas_offset(-10);
            }
        }];
    }
    return _textView;
}

@end
