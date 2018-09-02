//
//  WSFActivityDetailUpView.m
//  WinShare
//
//  Created by GZH on 2018/3/5.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityDetailUpView.h"
#import "NSMutableAttributedString+WSF_AdjustString.h"
#import "WSFActivityDetailVM.h"
#import "WSFActivityPromptVC.h"
#import "WSFSpaceMapVC.h"

@interface WSFActivityDetailUpView ()<UITextViewDelegate>
@property (nonatomic, strong) WSFActivityDetailVM *detailVM;
@end

@implementation WSFActivityDetailUpView

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
    UILabel *titleLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:_detailVM.name textFont:17 colorStr:@"#1a1a1a" aligment:NSTextAlignmentLeft];
    titleLabel.numberOfLines = 0;
    [self addSubview:titleLabel];
    [titleLabel sizeToFit];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.left.mas_equalTo(self).offset(10);
        make.right.mas_equalTo(self).offset(-10);
    }];
    
    UITextView *textView = [[UITextView alloc]init];
    textView.editable = NO;
    textView.scrollEnabled = NO;
    textView.delegate = self;
    textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, 0);
    [_detailVM.detailString addAttributes:@{ NSLinkAttributeName:@"注意事项" }
                       range:[[_detailVM.detailString string] rangeOfString:@"注意事项"]];
    textView.linkTextAttributes = @{NSForegroundColorAttributeName:HEX_COLOR_0x2B84C6};
    textView.attributedText = _detailVM.detailString;
    [self addSubview:textView];
    [textView sizeToFit];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_left);
        make.right.mas_equalTo(titleLabel.mas_right);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(12);
    }];
    
    // 空间的地理位č
    HSBlockButton *spaceLocationButton = [HSBlockButton buttonWithType:UIButtonTypeCustom];
    spaceLocationButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    spaceLocationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    spaceLocationButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    spaceLocationButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [spaceLocationButton setTitle:_detailVM.address forState:UIControlStateNormal];
    [spaceLocationButton setTitleColor:HEX_COLOR_0x2B84C6 forState:UIControlStateNormal];
    [spaceLocationButton.titleLabel setFont:SYSTEMFONT_13];
    [spaceLocationButton setImage:[UIImage imageNamed:@"dibiao_small_blue"] forState:UIControlStateNormal];
    
    [spaceLocationButton addTouchUpInsideBlock:^(UIButton *button) {
        
        WSFSpaceMapVC *spaceMapVC = [[WSFSpaceMapVC alloc] init];
        spaceMapVC.currentAddress = _detailVM.address;
        CLLocationCoordinate2D coor;
        coor.longitude = _detailVM.lng;
        coor.latitude = _detailVM.lat;
        spaceMapVC.currentCoor = coor;
        [self.viewController.navigationController pushViewController:spaceMapVC animated:NO];
    }];
    [self addSubview:spaceLocationButton];
    [spaceLocationButton sizeToFit];
    [spaceLocationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textView.mas_bottom).offset(10);
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(titleLabel.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-15);
    }];

    
//    textView.backgroundColor = [UIColor cyanColor];
//    spaceLocationButton.backgroundColor = [UIColor cyanColor];
    
}




#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSLog(@"注意事项");
    WSFActivityPromptVC *promptVC = [[WSFActivityPromptVC alloc] init];
    promptVC.peopleNumber = _detailVM.manDown;
    promptVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    promptVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    promptVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    [self.viewController.navigationController presentViewController:promptVC animated:YES completion:nil];
    return YES;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
