//
//  WSFTimePointPickerView.m
//  WinShare
//
//  Created by GZH on 2018/2/26.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFTimePointPickerView.h"
#import "WSFTimePointVM.h"

static NSTimeInterval const WSFTimePointAnimationTime = 0.35;   // 弹出 view 的动画时间
static CGFloat const WSFTimePointViewMaxHeight = 220;             // 最大高度

@interface WSFTimePointPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) WSFTimePointVM *timePointVM;
@property (nonatomic, strong) UIButton *beSureButton;      // 确定按钮
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSString *whenSring;  //时
@property (nonatomic, strong) NSString *pointsString;  //分
@end

@implementation WSFTimePointPickerView

- (instancetype)initWithTimePointVM:(WSFTimePointVM *)timePointVM {
    if (self = [super init]) {
        _whenSring = @"00";
        _pointsString = @"00";
        self.timePointVM = timePointVM;
        self.frame = SCREEN_BOUNDS;
        [kAppWindow addSubview:self];
        self.backgroundColor = RGBA(0, 0, 0, 0);
        self.beSureButton.hidden = NO;
        self.pickerView.hidden = NO;
        [self ryj_showPickView];

    }
    return self;
}


#pragma mark - 私有方法
- (void)ryj_showPickView {
    [UIView animateWithDuration:WSFTimePointAnimationTime animations:^{
        self.bgView.frame = CGRectMake(0, SCREEN_HEIGHT - WSFTimePointViewMaxHeight, SCREEN_WIDTH, WSFTimePointViewMaxHeight);
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
    } completion:nil];
}

- (void)ryj_hidePickView {
    [UIView animateWithDuration:WSFTimePointAnimationTime animations:^{
        self.bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, WSFTimePointViewMaxHeight);
        self.backgroundColor = RGBA(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self ryj_hidePickView];
    }
}

- (void)beSureAction {
    if(_whenPiontsBlock)_whenPiontsBlock(_whenSring, _pointsString);
}

#pragma mark - 懒加载
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, WSFTimePointViewMaxHeight)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
    }
    return _bgView;
}

- (UIButton *)beSureButton {
    if (!_beSureButton) {
        _beSureButton = [[UIButton alloc] init];
        [_beSureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_beSureButton addTarget:self action:@selector(beSureAction) forControlEvents:UIControlEventTouchUpInside];
        _beSureButton.backgroundColor = HEX_COLOR_0x2B84C6;
        [self.bgView addSubview:_beSureButton];
        [_beSureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.bgView);
            make.height.equalTo(@50);
        }];
    }
    return _beSureButton;
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [_pickerView selectRow:0 inComponent:0 animated:YES];
        [_bgView addSubview:_pickerView];
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_bgView);
            make.bottom.equalTo(_beSureButton.mas_top);
        }];
    }
    return _pickerView;
}

#pragma mark - UIPickerView DataSource
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 36;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0) return self.timePointVM.whenArray.count;
    if(component == 1) return self.timePointVM.pointsArray.count;
    return 5;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 1) {
        _pointsString = self.timePointVM.pointsArray[row];
    }else {
        _whenSring = self.timePointVM.whenArray[row];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
        pickerLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    return pickerLabel;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component == 0) return self.timePointVM.whenArray[row];
    if(component == 1) return self.timePointVM.pointsArray[row];
    return @"";
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
