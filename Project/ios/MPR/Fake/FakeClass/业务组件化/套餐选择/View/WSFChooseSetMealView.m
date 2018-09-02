//
//  WSFChooseSetMealView.m
//  WinShare
//
//  Created by devRen on 2017/12/4.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFChooseSetMealView.h"
#import "WSFChooseSetMealCell.h"
#import "WSFChooseSetMealViewModel.h"
#import "UILabel+WSF_LineSpacing.h"

static NSTimeInterval const WSFShareViewAnimationTime = 0.35;   // 弹出 view 的动画时间
static CGFloat const WSFSetMealViewMaxHeight = 277;             // 最大高度

@interface WSFChooseSetMealView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *setMealLabel;        // “所有套餐”
@property (nonatomic, strong) UIView *line;                 // 分割线
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UITableView *chooseSetMealTV;
@property (nonatomic, assign) CGFloat bgHeight;
@property (nonatomic, strong) WSFChooseSetMealViewModel *chooseSetMealViewModel;

@end

@implementation WSFChooseSetMealView

- (instancetype)initWithChooseSetMealViewModel:(WSFChooseSetMealViewModel *)chooseSetMealViewModel {
    self = [super init];
    if (self) {
        self.frame = SCREEN_BOUNDS;
        [kAppWindow addSubview:self];
        self.backgroundColor = RGBA(0, 0, 0, 0);
        self.chooseSetMealViewModel = chooseSetMealViewModel;
        self.setMealLabel.text = @"所有套餐";
        self.line.backgroundColor = HEX_COLOR_0xCCCCCC;
        self.confirmButton.hidden = NO;
        self.chooseSetMealTV.hidden = NO;
        [self ryj_showPickView];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _chooseSetMealViewModel.cellViewModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSFChooseSetMealCell *cell = [[WSFChooseSetMealCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WSFChooseSetMealCell"];
    WSFChooseSetMealCellViewModel *model = _chooseSetMealViewModel.cellViewModelArray[indexPath.row];
    cell.setMealNameLabel.text = model.setMealNameString;
    cell.setMealLabel.attributedText = model.setMealContentString;
//    [cell.setMealLabel wsf_setAttributedText:model.setMealContentString lineSpacing:6];
    if (model.isDissatisfy) {
        cell.chooseImageView.hidden = NO;
        [cell theSetMealIsSelected:model.isSelected];
        cell.dissatisfyLabel.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        cell.chooseImageView.hidden = YES;
        cell.dissatisfyLabel.hidden = NO;
        cell.userInteractionEnabled = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    for (NSInteger i = 0; i < self.chooseSetMealViewModel.cellViewModelArray.count; i ++) {
        self.chooseSetMealViewModel.cellViewModelArray[i].selected = NO;
    }
    self.chooseSetMealViewModel.cellViewModelArray[indexPath.row].selected = YES;
    
    [self.chooseSetMealTV reloadData];
}

#pragma mark - 私有方法
- (void)ryj_showPickView {
    [UIView animateWithDuration:WSFShareViewAnimationTime animations:^{
        self.bgView.frame = CGRectMake(0, SCREEN_HEIGHT - _bgHeight, SCREEN_WIDTH, _bgHeight);
        self.backgroundColor = RGBA(0, 0, 0, 0.5);
    } completion:nil];
}

- (void)ryj_hidePickView {
    [UIView animateWithDuration:WSFShareViewAnimationTime animations:^{
        self.bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, _bgHeight);
        self.backgroundColor = RGBA(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 点击事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self ryj_hidePickView];
    }
}

- (void)confirmButtonClick:(UIButton *)sender {
    [self ryj_hidePickView];
    
    BOOL isHaveSetMeal = NO;
    NSString *mealNo = @"";
    for (WSFChooseSetMealCellViewModel *model in self.chooseSetMealViewModel.cellViewModelArray) {
        if (model.selected == YES) {
            isHaveSetMeal = YES;
            mealNo = model.setMealNameString;
        }
    }
    
    if (_selectedSetMealBlack) {
        mealNo = [mealNo stringByReplacingOccurrencesOfString:@":" withString:@""];
        _selectedSetMealBlack(isHaveSetMeal, mealNo);
    }
}

#pragma mark - 懒加载
- (UIView *)bgView {
    if (!_bgView) {
        // 计算高度
        _bgHeight = 115;
        for (NSInteger i = 0; i < _chooseSetMealViewModel.cellViewModelArray.count; i++) {
            WSFChooseSetMealCellViewModel *model = _chooseSetMealViewModel.cellViewModelArray[i];
            CGFloat cellHeight = [self getSpaceLabelHeight:model.setMealContentString.string withFont:SYSTEMFONT_12 withWidth:SCREEN_WIDTH - 145] + 15;
            _bgHeight += cellHeight;
        }
        _bgHeight = _bgHeight > WSFSetMealViewMaxHeight ? WSFSetMealViewMaxHeight : _bgHeight;
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, _bgHeight)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
    }
    return _bgView;
}

- (UILabel *)setMealLabel {
    if (!_setMealLabel) {
        _setMealLabel = [[UILabel alloc] init];
        _setMealLabel.font = SYSTEMFONT_16;
        _setMealLabel.textColor = HEX_COLOR_0x1A1A1A;
        [self.bgView addSubview:_setMealLabel];
        [_setMealLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [_setMealLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgView.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.bgView.mas_top).mas_offset(15);
        }];
    }
    return _setMealLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        [self.bgView addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_setMealLabel.mas_bottom).mas_offset(15);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 1));
        }];
    }
    return _line;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] init];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.backgroundColor = HEX_COLOR_0x2B84C6;
        [self.bgView addSubview:_confirmButton];
        [_confirmButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.bgView);
            make.height.equalTo(@50);
        }];
    }
    return _confirmButton;
}

- (UITableView *)chooseSetMealTV {
    if (!_chooseSetMealTV) {
        _chooseSetMealTV = [[UITableView alloc] init];
        _chooseSetMealTV.delegate = self;
        _chooseSetMealTV.dataSource = self;
        _chooseSetMealTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _chooseSetMealTV.estimatedRowHeight = 44;
        _chooseSetMealTV.rowHeight = UITableViewAutomaticDimension;
        if (_bgHeight < WSFSetMealViewMaxHeight) {
            _chooseSetMealTV.scrollEnabled = NO;
        }
        [_bgView addSubview:_chooseSetMealTV];
        [_chooseSetMealTV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_bgView);
            make.top.equalTo(_line.mas_bottom).mas_offset(7.5);
            make.bottom.equalTo(_confirmButton.mas_top);
        }];
    }
    return _chooseSetMealTV;
}

// 计算富文本的高
- (CGFloat)getSpaceLabelHeight:(NSString *)str withFont:(UIFont *)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 0;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f};
    CGSize size = [str boundingRectWithSize:CGSizeMake(width,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    if (size.height > 43) {
        return 43;
    } else {
        return size.height;
    }
}
@end
