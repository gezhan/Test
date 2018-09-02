//
//  WSFActivityEditTVCell.m
//  WinShare
//
//  Created by GZH on 2018/2/27.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityEditTVCell.h"

@interface WSFActivityEditTVCell ()
@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) NSArray *signArray;
@property (nonatomic, strong) NSArray *signArray1;
@property (nonatomic, strong) NSArray *signArray2;
@property (nonatomic, strong) UIImageView *signImage;
@end

@implementation WSFActivityEditTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
 
        [self setupContentView];
        [self setupData];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)setupData{
    _signArray = @[@"活动名称", @"举办空间", @"主办方"];
    _signArray1 = @[@"活动日期", @"活动时间", @"报名日期", @"报名费用", @"人数下线", @"人数上限"];
    _signArray2 = @[@"宣传图片", @"活动介绍"];
}

- (void)setupContentView {
    self.questionLabel.hidden = NO;
    self.signImage.hidden = YES;
    self.answerLabel.hidden = YES;
    
}

- (void)layoutSubviews {
    if (self.tag < 10) {
        _questionLabel.text = _signArray[self.tag];
        if(self.tag == 1) {
            _signImage.hidden = NO ,_answerLabel.hidden = NO;
        }else if (self.tag == 0) {
            self.textField.hidden = NO;
            _textField.placeholder = @"请输入活动名称";
        }else if (self.tag == 2) {
            self.textField.hidden = NO;
            _textField.placeholder = @"请输入主办方";
        }
    }else if (self.tag >= 10 && self.tag < 20) {
        _questionLabel.text = _signArray1[self.tag - 10];
        if(self.tag == 10) {
            _signImage.hidden = NO ,_answerLabel.hidden = NO;
        }else if (self.tag == 13) {
            self.textField.hidden = NO;
            _textField.placeholder = @"免费请输入0";
        }else if (self.tag == 14) {
            self.textField.hidden = NO;
            _textField.placeholder = @"无限制请输入0";
        }else if (self.tag == 15) {
            self.textField.hidden = NO;
            _textField.placeholder = @"默认无上限";
        }
    }else if (self.tag >= 20){
        _questionLabel.text = _signArray2[self.tag - 20];
        _signImage.hidden = NO , _answerLabel.hidden = NO, _answerLabel.text = @"未添加";
    }
    
    
}

#pragma mark -- 懒加载生成控件 --
- (UILabel *)questionLabel {
    if (_questionLabel == nil) {
        _questionLabel = [[UILabel alloc]init];
        _questionLabel.font = [UIFont systemFontOfSize:14];
        _questionLabel.textAlignment = NSTextAlignmentLeft;
        _questionLabel.textColor = [UIColor colorWithHexString:@"#808080"];
        [self.contentView addSubview:_questionLabel];
        _questionLabel.text = @"活动名称";
        [_questionLabel sizeToFit];
        [_questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(10);
            make.height.equalTo(@50);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
    }
    return _questionLabel;
}

- (UILabel *)answerLabel {
    if (_answerLabel == nil) {
        _answerLabel = [[UILabel alloc]init];
        _answerLabel.font = [UIFont systemFontOfSize:16];
        _answerLabel.textAlignment = NSTextAlignmentLeft;
        _answerLabel.hidden = YES;
        _answerLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
        [self.contentView addSubview:_answerLabel];
        _answerLabel.text = @"请选择";
        [_answerLabel sizeToFit];
        [_answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(86);
            make.right.mas_equalTo(_signImage.mas_left).offset(-20);
            make.height.equalTo(@50);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
    }
//    _answerLabel.backgroundColor = [UIColor cyanColor];
    return _answerLabel;
}

- (UIImageView *)signImage {
    if (_signImage == nil) {
        _signImage = [[UIImageView alloc]init];
        _signImage.image = [UIImage imageNamed:@"xiangyou"];
        [self.contentView addSubview:_signImage];
        [_signImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-10);
            make.size.mas_equalTo(CGSizeMake(9, 16));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        _signImage.hidden = YES;
    }
    return _signImage;
}

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc]init];
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(86);
            make.right.mas_equalTo(_signImage.mas_left).offset(-40);
            make.height.equalTo(@50);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        _textField.hidden = YES;
    }
    return _textField;
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
