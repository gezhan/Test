//
//  WSFFieldTimeTVCell.m
//  WinShare
//
//  Created by GZH on 2018/1/16.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFFieldTimeTVCell.h"
#import "NSMutableAttributedString+WSF_AdjustString.h"
//#import "WSFFieldBookVC.h"
#import "WSFFieldSelectedVM.h"
//#import "WSFFieldBookVM.h"
@interface WSFFieldTimeTVCell ()

@property (nonatomic, strong) UILabel *grayLabel;
@property (nonatomic, strong) UILabel *remindLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *backView1;
//@property (nonatomic, strong) UIButton *button;

@end
@implementation WSFFieldTimeTVCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setDetailModel:(WSFFieldDetailM *)detailModel {
    _detailModel = detailModel;
    [self setupContentView];
}

- (void)setupContentView {

    UIView *backView = [[UIView alloc] init];
    _backView = backView;
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
    }];
    
    self.grayLabel.hidden = NO;
    self.remindLabel.text = _selectedCellVM.beginEndTime;
    self.line.hidden = NO;
//    self.button.hidden = NO;
    
    UIView *backView1 = [[UIView alloc] init];
    _backView1 = backView1;
    [backView addSubview:backView1];
    [backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line.mas_bottom).offset(15);
        make.left.right.mas_equalTo(backView);
        make.bottom.mas_equalTo(backView).offset(-15);
    }];
    
    int count =  (int)_selectedCellVM.setMealArray.count;
    for (int i = 0; i < count; i++) {
        
        UIView *priceView = [UIView Z_createViewWithFrame:CGRectZero colorStr:@"#ffffff"];
        priceView.tag = i + 666;
//        priceView.backgroundColor = [UIColor greenColor];
        [backView1 addSubview:priceView];
        [priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.top.mas_equalTo(backView1);
            }else {
                UIView *tempView = [self viewWithTag:i + 665];
                make.top.mas_equalTo(tempView.mas_bottom).offset(15);
            }
            make.left.right.mas_equalTo(backView1);
            if (i == count - 1) {
                make.bottom.mas_equalTo(backView1.mas_bottom);
            }
        }];
       
        WSFFieldMealContentCellVM *setMealsM = _selectedCellVM.setMealArray[i];
        [self setupGearViewWith:priceView mealModel:setMealsM];
    }
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
}

/**  每个场次的各种价格档 */
- (void)setupGearViewWith:(UIView *)tempView mealModel:(WSFFieldMealContentCellVM *)model{
    //价钱
    UILabel *priceLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:model.minimum textFont:14 colorStr:@"#2b84c6" aligment:NSTextAlignmentLeft];
//    priceLabel.backgroundColor = [UIColor cyanColor];
    [priceLabel sizeToFit];
    [tempView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tempView.mas_top);
        make.left.mas_equalTo(tempView.mas_left).offset(19);
        make.right.mas_equalTo(tempView.mas_right).offset(-10);
    }];
    
    
    UIView *pointView = [UIView Z_createViewWithFrame:CGRectZero colorStr:@"#2b84c6"];
    [tempView addSubview:pointView];
    [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(priceLabel.mas_left).offset(-5);
        make.centerY.mas_equalTo(priceLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(3.5, 3.5));
    }];
    
    //套餐内容
    UILabel *contentLabel = [UILabel Z_createLabelWithFrame:CGRectZero title:model.mealContent textFont:12 colorStr:@"#808080" aligment:NSTextAlignmentLeft];
    contentLabel.numberOfLines = 0;
    contentLabel.attributedText = [NSMutableAttributedString wsf_setupLabelString:contentLabel.text lineSpace:5.0];
    [contentLabel sizeToFit];
    [tempView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(priceLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(priceLabel.mas_left);
        make.right.mas_equalTo(priceLabel.mas_right);
        make.bottom.mas_equalTo(tempView.mas_bottom);
    }];
    
//    priceLabel.backgroundColor = [UIColor cyanColor];
//    contentLabel.backgroundColor = [UIColor greenColor];

}



- (UILabel *)grayLabel {
    if (!_grayLabel) {
        _grayLabel = [[UILabel alloc] init];
        _grayLabel.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
        [_backView addSubview:_grayLabel];
        [_grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_backView);
            make.height.mas_equalTo(@15);
        }];
    }
    return _grayLabel;
}

- (UILabel *)remindLabel {
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] init];
        _remindLabel.font = SYSTEMFONT_16;
        _remindLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
        [_backView addSubview:_remindLabel];
        [_remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_grayLabel.mas_bottom);
            make.left.mas_equalTo(@10);
            make.height.equalTo(@40);
        }];
    }
    return _remindLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = HEX_COLOR_0xE5E5E5;
        [_backView addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_remindLabel.mas_bottom);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 1));
        }];
    }
    return _line;
}

//- (UIButton *)button {
//    if (_button == nil) {
//        _button = [[UIButton alloc]init];
//        [_button setTitle:@"预定" forState:UIControlStateNormal];
//        [_button setTitleColor:[UIColor colorWithHexString:@"#2b84c6"] forState:UIControlStateNormal];
//        _button.titleLabel.font = [UIFont systemFontOfSize:14];
//        [_button.layer setMasksToBounds:YES];
//        [_button.layer setCornerRadius:3.0]; //设置矩圆角半径
//        [_button.layer setBorderWidth:1.0];   //边框宽度
//        [_button.layer setBorderColor:[UIColor colorWithHexString:@"#2b84c6"].CGColor];//边框颜色
//        [_button addTarget:self action:@selector(bookAction) forControlEvents:UIControlEventTouchUpInside];
//        [_backView addSubview:_button];
//        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(_backView).offset(-10);
//            make.size.mas_equalTo(CGSizeMake(59, 29));
//            make.bottom.mas_equalTo(_line.mas_bottom).offset(-6.5);
//        }];
//    }
//    return _button;
//}

//- (void)bookAction {
//    NSLog(@"--------预定" );
//    WSFFieldBookVC *pgBookVC = [[WSFFieldBookVC alloc]init];
//    WSFFieldBookVM *bookVM = [[WSFFieldBookVM alloc]initWithDetailModel:_detailModel sessionString:_selectedCellVM.beginEndTime mealsContentArray:_selectedCellVM.setMealArray selectedCellVM:_selectedCellVM];
//    pgBookVC.bookVM = bookVM;
//    [self.viewController.navigationController pushViewController:pgBookVC animated:NO];
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
