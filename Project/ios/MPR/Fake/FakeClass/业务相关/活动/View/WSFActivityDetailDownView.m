//
//  WSFActivityDetailDownView.m
//  WinShare
//
//  Created by GZH on 2018/3/5.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityDetailDownView.h"
#import "NSMutableAttributedString+WSF_AdjustString.h"
#import "WSFActivityDetailVM.h"

@interface WSFActivityDetailDownView ()
@property (nonatomic, strong) WSFActivityDetailVM *detailVM;
@end

@implementation WSFActivityDetailDownView

- (instancetype)initWithVM:(WSFActivityDetailVM *)detailVM {
    self = [super init];
    if (self) {
        
        _detailVM = detailVM;
        self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [self setupContentView];
        
    }
    return self;
}

- (void)setupContentView {
//    int count = _detailVM.introductionArray.count;
    for (int i = 0; i < _detailVM.introductionArray.count; i++) {
        UIView *detailView = [UIView Z_createViewWithFrame:CGRectZero colorStr:@"#ffffff"];
        detailView.tag = i + 666;
        [self addSubview:detailView];
        [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.top.mas_equalTo(self).offset(15);
            }else {
                UIView *tempView = [self viewWithTag:i + 665];
                make.top.mas_equalTo(tempView.mas_bottom).offset(20);
            }
            make.left.right.mas_equalTo(self);
            if (i == _detailVM.introductionArray.count - 1) {
                make.bottom.mas_equalTo(self.mas_bottom).offset(-15);
            }
        }];
        
        WSFActivityIntroductionVM *introductionVM = _detailVM.introductionArray[i];
        [self setupGearViewWith:detailView model:introductionVM];
     }
}

- (void)setupGearViewWith:(UIView *)tempView model:(WSFActivityIntroductionVM *)introductionVM{
    UILabel *titleLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:introductionVM.title textFont:13 colorStr:@"#1a1a1a" aligment:NSTextAlignmentLeft];
    [titleLabel sizeToFit];
    [tempView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tempView.mas_top);
        make.right.mas_equalTo(tempView.mas_right).offset(-10);
    }];
    
    UIImageView *pointImage = [UIImageView Z_createImageViewWithFrame:CGRectZero image:@"home_dian_black" layerMask:NO cornerRadius:0];
    [tempView addSubview:pointImage];
    [pointImage sizeToFit];
    [pointImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.centerY.mas_equalTo(titleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(3.5, 3.5));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(pointImage.mas_left).offset(10);
    }];
    
    //简介内容
    UILabel *detailLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:introductionVM.content textFont:13 colorStr:@"#808080" aligment:NSTextAlignmentLeft];
    detailLabel.numberOfLines = 0;
    detailLabel.attributedText = [NSMutableAttributedString wsf_setupLabelString:detailLabel.text lineSpace:5.0];
    [detailLabel sizeToFit];
    [tempView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(-10);
        make.bottom.mas_equalTo(tempView.mas_bottom);
    }];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
